; Defines functions for computing greatest common divisors.
; CSC 225, Assignment 6
; Given code, Spring '21
; TODO: Complete this file.

            .ORIG x4000

; int gcd(int, int)
GCDFN
          ADD R6, R6, #-1
          ADD R6, R6, #-1
          STR R7, R6, #0
          ADD R6, R6, #-1
          STR R5, R6, #0
          ADD R5, R6, #-1
          ADD R6, R6, #-1
          LDR R0, R5, #4
          LDR R1, R5, #5
          NOT R2, R1
          ADD R2, R2, #1
          ADD R3, R2, R0

          BRz EQUAL
          BRn BIGGER
          BRnzp LESS

LESS
          ADD R0, R3, #0
          BRnzp CALLEE

BIGGER
          NOT R2, R0
          ADD R2, R2, #1
          ADD R1, R2, R1
          BRnzp CALLEE

CALLEE
          ADD R6, R6, #-1
          STR R1, R6, #0
          ADD R6, R6, #-1
          STR R0, R6, #0
          JSR GCDFN

          LDR R1, R6, #0
          STR R1, R5, #0
          ADD R6, R6, #1
          ADD R6, R6, #2
          BRnzp POP

EQUAL
          LDR R0, R5, #4
          STR R0, R5, #0

POP
          LDR R0, R5, #0
          STR R0, R5, #3
          ADD R6, R5, #1
          LDR R5, R6, #0
          ADD R6, R6, #1
          LDR R7, R6, #0
          ADD R6, R6, #1
          RET


            .END
