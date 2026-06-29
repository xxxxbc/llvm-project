! Test that a metadirective loop variant whose affected loop is not a canonical
! DO loop reports a graceful TODO instead of crashing lowering. Here COLLAPSE
! descends across intervening code (allowed in an imperfect nest) into a DO
! WHILE, which is not a canonical loop. The metadirective loop-nest semantic
! checks (a companion patch) reject this earlier once present.

! RUN: %not_todo_cmd %flang_fc1 -emit-hlfir -fopenmp -fopenmp-version=51 -o - %s 2>&1 | FileCheck %s

! CHECK: not yet implemented: METADIRECTIVE variant with a non-canonical affected loop

subroutine test_noncanonical_loop(n, a)
  integer :: n, i, j, a(n, n)
  !$omp metadirective &
  !$omp & when(implementation={vendor(llvm)}: parallel do collapse(2)) &
  !$omp & default(nothing)
  do i = 1, n
    j = 0
    do while (j < n)
      j = j + 1
      a(j, i) = j
    end do
  end do
end subroutine
