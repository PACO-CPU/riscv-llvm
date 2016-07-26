; RUN: llc < %s -march=-march=riscv | FileCheck %s


define i32 @Y1(i32 %A, i32 %B, i32 %C) nounwind {
; CHECK: Y1:
; CHECK: # BB#0:
; CHECK: lute x5, x10, 0
; CHECK: lute3 x10, x5, x11, x12, 1 
        %Z = tail call i32 @llvm.riscv.lute( i32 %A, i32 9 ) 
        %W = tail call i32 @llvm.riscv.lute3( i32 %Z, i32 %B, i32 %C, i32 5) 
        ret i32 %W
}


define i32 @Y2(i32 %A) nounwind {
; CHECK: Y2:
; CHECK: # BB#0:
; CHECK: lute x5, x10, 1
; CHECK: lute x10, x5, 2 
        %Z = tail call i32 @llvm.riscv.lute( i32 %A, i32 5) 
        %W = tail call i32 @llvm.riscv.lute( i32 %Z, i32 7) 
        ret i32 %W
}

define i32 @Y3(i32 %A) nounwind {
; CHECK: Y3:
; CHECK: # BB#0:
; CHECK: luts x10, 0
; CHECK: lutl x10, 2, 0, 0
        %Z = tail call i32 @llvm.riscv.luts( i32 9) 
        tail call void @llvm.riscv.lutl( i32 %Z, i32 0, i32 7) 
        ret i32 %Z
}


declare void @llvm.riscv.lutl(i32, i32, i32) nounwind
declare i32 @llvm.riscv.luts(i32) nounwind
declare i32 @llvm.riscv.lute(i32, i32) nounwind
declare i32 @llvm.riscv.lute3(i32, i32, i32, i32) nounwind
