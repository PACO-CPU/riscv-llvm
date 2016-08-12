; RUN: llc < %s -march=-march=riscv | FileCheck %s


define i32 @Y(i32 %A, i32 %B, i32 %C) nounwind {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: lute3 x5, x10, x11, x12, 0
; CHECK: lute3 x10, x5, x12, x11, 1 
        %Z = tail call i32 @llvm.riscv.lute3( i32 %A, i32 %B, i32 %C, i32 0, i32 0, i32 0, i32 0) 
        %W = tail call i32 @llvm.riscv.lute3( i32 %Z, i32 %C, i32 %B, i32 1, i32 0, i32 0, i32 0) 
        ret i32 %W
}


declare i32 @llvm.riscv.lute3(i32, i32, i32, i32, i32, i32, i32) nounwind
