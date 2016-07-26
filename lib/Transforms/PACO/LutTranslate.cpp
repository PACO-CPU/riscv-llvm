
#define DEBUG_TYPE "paco-lut-translate"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/InstVisitor.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/Transforms/PACO/Paco.h"
#include <stdio.h>
using namespace llvm;

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
    typedef MapVector<uint64_t,uint64_t> id_map_t;
  private:
    uint64_t _id_high;
    id_map_t _id_map;
  public:
    LutTranslator() : _id_high(0) {

    }

    void update_arg(IntrinsicInst &II, int idx) {
      ConstantInt *ci=cast<ConstantInt>(II.getArgOperand(idx));
      uint64_t id_orig=ci->getZExtValue();
      uint64_t id_new;
      id_map_t::iterator it;

      it=_id_map.find(id_orig);
      if (it!=_id_map.end()) {
        id_new=it->second;
      } else {
        id_new=_id_high;
        _id_map[id_orig]=_id_high;
        _id_high++;
      }

      II.setArgOperand(idx,ConstantInt::get(Type::getInt32Ty(II.getContext()),id_new));

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
/*
static RegisterPass<LutTranslate> X("lut-translate",
                "PACO LUT identifier translation", false, false);
                */

INITIALIZE_PASS(LutTranslate,"lut-translate",
                "PACO LUT identifier translation", false, false)

ModulePass *llvm::createLutTranslatePass() { return new LutTranslate(); }
bool LutTranslate::runOnModule(Module &M) {
  
  LutTranslator LT;
  LT.visit(M);

  return false;
}



