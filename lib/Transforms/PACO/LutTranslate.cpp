
#define DEBUG_TYPE "paco-lut-translate"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/InstVisitor.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/Transforms/PACO/Paco.h"
#include <stdio.h>
using namespace llvm;

namespace llvm {
  struct uuid_t {
    // stores the UUID highest order first, that is, a UUID of the form
    // aaaaaaaa-bbbb-bbbb-cccc-ccccdddddddd
    // is stored by words a,b,c,d.
    uint32_t words[4];
  };
  // 10ebbe8e-536c-11e6-a013-3c970e4f450b
  // time-based UUID generated at some time in the past, unlikely to
  // occur in production.
  static const uuid_t UUID_EMPTY { 0x10ebbe8e, 0x536c11e6, 0xa0133c97, 0x0e4f450b };

  // 23e1649e-536c-11e6-b457-3c970e4f450b
  // time-based UUID generated at some time in the past, unlikely to
  // occur in production.
  static const uuid_t UUID_TOMBSTONE { 0x23e1649e, 0x536c11e6, 0xb4573c97, 0x0e4f450b };

  template<> struct DenseMapInfo<uuid_t> {
    
    static inline uuid_t getEmptyKey() {
      return UUID_EMPTY;
    }
    static inline uuid_t getTombstoneKey() {
      return UUID_TOMBSTONE;
    }


    static unsigned getHashValue(const uuid_t &Val) {
      return Val.words[0]^Val.words[1]^Val.words[2]^Val.words[3];
    }
    static bool isEqual(const uuid_t &a, const uuid_t &b) {
      return (
        (a.words[0]==b.words[0]) &&
        (a.words[1]==b.words[1]) &&
        (a.words[2]==b.words[2]) &&
        (a.words[3]==b.words[3]));
    }
  };
}
namespace {
  

  struct LutTranslate : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    LutTranslate() : ModulePass(ID) {  
      initializeLutTranslatePass(*PassRegistry::getPassRegistry());
    }

    bool runOnModule(Module &M);

    virtual const char *getPassName() const {
      return "PACO Lut Translate";
    }
  };

  char LutTranslate::ID = 0;

  struct LutTranslator : public InstVisitor<LutTranslator> {
  public:
    typedef MapVector<uuid_t,uint64_t> id_map_t;
  private:
    uint64_t _id_high;
    id_map_t _id_map;
  public:
    LutTranslator() : _id_high(0) {

    }

    void update_arg(IntrinsicInst &II, int idx) {
      #define ARGV(i) \
       ((cast<ConstantInt>(II.getArgOperand(i)))->getZExtValue())
      uuid_t id_orig;
      uint64_t id_new;
      id_map_t::iterator it;

      id_orig.words[0]=ARGV(idx+0);
      id_orig.words[1]=ARGV(idx+1);
      id_orig.words[2]=ARGV(idx+2);
      id_orig.words[3]=ARGV(idx+3);


      it=_id_map.find(id_orig);
      if (it!=_id_map.end()) {
        id_new=it->second;
      } else {
        id_new=_id_high;
        _id_map[id_orig]=_id_high;
        _id_high++;
      }

      //Set all other uuid flieds to 0 to prevent overflow errors
      II.setArgOperand(idx+0,ConstantInt::get(Type::getInt32Ty(II.getContext()),(uint64_t)0));
      II.setArgOperand(idx+1,ConstantInt::get(Type::getInt32Ty(II.getContext()),(uint64_t)0));
      II.setArgOperand(idx+2,ConstantInt::get(Type::getInt32Ty(II.getContext()),(uint64_t)0));
      //Set new id
      II.setArgOperand(idx+3,ConstantInt::get(Type::getInt32Ty(II.getContext()),id_new));

      #undef ARGV
    }
    void visitIntrinsicInst(IntrinsicInst &II) {
      switch(II.getIntrinsicID()) {
        case Intrinsic::riscv_lutl:
          update_arg(II,2);
          break;
        case Intrinsic::riscv_luts:
          update_arg(II,0);
          break;
        case Intrinsic::riscv_lute:
          update_arg(II,1);
          break;
        case Intrinsic::riscv_lute3:
          update_arg(II,3);
          break;
        default:
          break;
      }
    }
  };
}

INITIALIZE_PASS(LutTranslate,"lut-translate",
                "PACO LUT identifier translation", false, false)

ModulePass *llvm::createLutTranslatePass() { return new LutTranslate(); }
bool LutTranslate::runOnModule(Module &M) {
  
  LutTranslator LT;
  LT.visit(M);

  return false;
}



