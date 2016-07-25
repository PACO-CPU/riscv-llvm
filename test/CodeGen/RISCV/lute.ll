; RUN: llc < %s -march=-march=riscv | FileCheck %s


define i32 @Y(i32 %A) nounwind {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: lute x5, x10, 0
; CHECK: lute x10, x5, 1 
        %Z = tail call i32 @llvm.riscv.lute( i32 %A, i32 0) 
        %W = tail call i32 @llvm.riscv.lute( i32 %Z, i32 1) 
        ret i32 %W
}


declare i32 @llvm.riscv.lute(i32, i32) nounwind
