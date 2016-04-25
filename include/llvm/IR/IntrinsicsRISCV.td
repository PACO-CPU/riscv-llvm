

let TargetPrefix = "riscv" in { // all intrinsics start with "llvm.riscv."

def int_riscv_add_approx : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;

}
