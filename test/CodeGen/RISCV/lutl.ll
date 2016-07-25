; RUN: llc < %s -march=-march=riscv | FileCheck %s


define void @Y(i32 %A) nounwind {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: lutl x10, 0, 0, 0
; CHECK: lutl x10, 0, 0, 1
; CHECK: lutl x10, 12, 0, 0
        tail call void @llvm.riscv.lutl( i32 %A, i32 0, i32 0) 
        tail call void @llvm.riscv.lutl( i32 %A, i32 1, i32 0) 
        tail call void @llvm.riscv.lutl( i32 %A, i32 0, i32 12) 
        ret void
}


declare void @llvm.riscv.lutl(i32, i32, i32) nounwind
