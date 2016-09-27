; RUN: llc < %s -march=-march=riscv | FileCheck %s

declare i32 @llvm.riscv.sub.approx_op32(i32, i32, i32)

define i32 @Y(i32 %A, i32 %B) {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: sub.approx_op32 x10, x10, x11, 10
        %Z = call i32 @llvm.riscv.sub.approx_op32( i32 %A, i32 %B, i32 10) 
        ret i32 %Z
}
