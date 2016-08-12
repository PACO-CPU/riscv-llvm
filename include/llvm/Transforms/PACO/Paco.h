#ifndef LLVM_TRANSFORMS_PACO_H
#define LLVM_TRANSFORMS_PACO_H

namespace llvm {

class ModulePass;

//===----------------------------------------------------------------------===//
/// createLutTranslatePass - Return a new pass object which transforms LUT
/// instruction UUIDs into LUT hardware core indices
///
ModulePass *createLutTranslatePass();

} // End llvm namespace

#endif
