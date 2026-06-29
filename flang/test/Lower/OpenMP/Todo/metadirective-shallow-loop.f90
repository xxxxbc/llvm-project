! Test that a metadirective loop variant whose COLLAPSE is deeper than the
! associated loop nest reports a graceful TODO instead of crashing lowering.
! The metadirective loop-nest semantic checks (a companion patch) reject this
! earlier once present.

! RUN: %not_todo_cmd %flang_fc1 -emit-hlfir -fopenmp -fopenmp-version=51 -o - %s 2>&1 | FileCheck %s

! CHECK: not yet implemented: METADIRECTIVE variant with COLLAPSE or ORDERED requires a deeper

subroutine test_shallow_loop(n)
  integer :: n, i
  !$omp metadirective &
  !$omp & when(implementation={vendor(llvm)}: parallel do collapse(2)) &
  !$omp & default(nothing)
  do i = 1, n
  end do
end subroutine
