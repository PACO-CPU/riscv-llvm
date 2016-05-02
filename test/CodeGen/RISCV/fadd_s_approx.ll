; RUN: llc < %s -march=riscv -mattr=+f | FileCheck %s

declare float @llvm.riscv.fadd.s.approx(float, float, i32)

define float @Y(float %A, float %B) {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: fadd.s.approx f10, f10, f11, 10
        %Z = call float @llvm.riscv.fadd.s.approx(float %A, float %B, i32 10) 
        ret float %Z
}
