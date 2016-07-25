; RUN: llc < %s -march=-march=riscv | FileCheck %s


define i32 @Y() nounwind {
; CHECK: Y:
; CHECK: # BB#0:
; CHECK: luts x10, 1
        %Z = tail call i32 @llvm.riscv.luts( i32 1 ) 
        ret i32 %Z
}


declare i32 @llvm.riscv.luts(i32) nounwind
