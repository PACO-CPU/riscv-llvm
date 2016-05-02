; RUN: llc < %s -march=riscv -mattr=+d | FileCheck %s

declare double @llvm.riscv.fadd.d.approx(double, double, i32)

define double @Y(double %A, double %B) {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: fadd.d.approx f10, f10, f11, 10
        %Z = call double @llvm.riscv.fadd.d.approx(double %A, double %B, i32 10) 
        ret double %Z
}
