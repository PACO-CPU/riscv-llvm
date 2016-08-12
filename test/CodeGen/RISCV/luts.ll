; RUN: llc < %s -march=-march=riscv | FileCheck %s


define i32 @Y() nounwind {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: luts x10, 0
        %Z = tail call i32 @llvm.riscv.luts( i32 1, i32 0, i32 0, i32 0 ) 
        ret i32 %Z
}


declare i32 @llvm.riscv.luts(i32, i32, i32, i32) nounwind
