
#include "llvm-c/Initialization.h"
#include "llvm/InitializePasses.h"
#include "llvm/PassManager.h"
#include "llvm/Transforms/PACO/Paco.h"

using namespace llvm;
void llvm::initializePACO(PassRegistry &Registry) {
  initializeLutTranslatePass(Registry);
}

