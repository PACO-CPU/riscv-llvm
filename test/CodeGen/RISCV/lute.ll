; RUN: llc < %s -march=-march=riscv | FileCheck %s


define i32 @Y(i32 %A) nounwind {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: lute x5, x10, 0
; CHECK: lute x5, x5, 1 
; CHECK: lute x10, x5, 2
        %Z = tail call i32 @llvm.riscv.lute( i32 %A, i32 0, i32 1, i32 2, i32 4)  
        %W = tail call i32 @llvm.riscv.lute( i32 %Z, i32 1, i32 2, i32 3, i32 1) 
        %X = tail call i32 @llvm.riscv.lute( i32 %W, i32 1, i32 2, i32 4, i32 1) 
        ret i32 %X
}


declare i32 @llvm.riscv.lute(i32, i32, i32, i32, i32) nounwind
