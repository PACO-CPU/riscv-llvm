

let TargetPrefix = "riscv" in { // all intrinsics start with "llvm.riscv."

def int_riscv_add_approx : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
def int_riscv_sub_approx : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
def int_riscv_mul_approx : Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;

def int_riscv_fadd_s_approx : Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty, llvm_i32_ty], [IntrNoMem]>;
def int_riscv_fsub_s_approx : Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty, llvm_i32_ty], [IntrNoMem]>;
def int_riscv_fmul_s_approx : Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty, llvm_i32_ty], [IntrNoMem]>;
def int_riscv_fsqrt_s_approx : Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty, llvm_i32_ty], [IntrNoMem]>;

def int_riscv_fadd_d_approx : Intrinsic<[llvm_double_ty], [llvm_double_ty, llvm_double_ty, llvm_i32_ty], [IntrNoMem]>;
def int_riscv_fsub_d_approx : Intrinsic<[llvm_double_ty], [llvm_double_ty, llvm_double_ty, llvm_i32_ty], [IntrNoMem]>;
def int_riscv_fmul_d_approx : Intrinsic<[llvm_double_ty], [llvm_double_ty, llvm_double_ty, llvm_i32_ty], [IntrNoMem]>;
def int_riscv_fsqrt_d_approx : Intrinsic<[llvm_double_ty], [llvm_double_ty, llvm_double_ty, llvm_i32_ty], [IntrNoMem]>;

def int_riscv_lutl  : Intrinsic<[],[llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], []>;
def int_riscv_lute  : Intrinsic<[llvm_i32_ty],[llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;

}
