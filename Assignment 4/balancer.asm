; Verifies the balance of string delimiters.
; CSC 225, Assignment 4
; Given code, Spring '22

            .ORIG x3000

MAIN        LEA R1, STACK   ; Initialize R1, the stack pointer.
            LEA R0, PROMPT  ; Print the prompt.
            PUTS

MAIN_LOOP   GETC
            OUT
            LD  R2, ROOK_SPACER
            ADD R2, R2, R0
            BRz POPR2
            JSR DELIMITER
            ADD R2, R2, #0
            BRz MAIN_LOOP        ; loop back
            
            ; opening
            LD R4, (
            ADD R4, R4, R2
            BRz PUSH_READY

            LD R4, [
            ADD R4, R4, R2
            BRz PUSH_READY
            
            LD R4, {
            ADD R4, R4, R2
            BRZ PUSH_READY
            
            ; closing
            LD R4, )
            ADD R4, R4, R2
            BRnp #1
            JSR CLOSER
            
            LD R4, ]
            ADD R4, R4, R2
            BRnp #1
            JSR CLOSER
            
            LD R4, }
            ADD R4, R4, R2
            BRnp #1
            JSR CLOSER
            
            
            ; TODO: Complete this program:
            ;       If an opening delimiter is typed, push it onto the stack.
            ;       If a closing delimiter is typed, pop an opening delimiter
            ;        off of the stack and ensure that they match.
            ;       When the expression ends, ensure that the stack is empty.



POPR2       JSR PEEK
            ADD R2, R2, #0
            BRnp POPULATED
            LEA R0, PASSING
            PUTS
        
            HALT            ; Halt.

; Space for a stack with capacity 16:
            .BLKW #16
STACK       .FILL x00

PUSH_READY  JSR PUSH
            BRnzp MAIN_LOOP
            
CLOSER      ADD R4, R2, #0
            JSR POP
            ADD R5, R2, R3 ; check if delimiters are hte same on both sides
            BRnp #1
            BRnzp MAIN_LOOP
            ADD R2, R2, #0 ; clear
            BRnp POPULATED
            ADD R4, R2, #0
            BRnzp #1
            
POPULATED   ADD R0, R2, #0
            JSR DELIMITER
            LD R0, KING_SPACER  ; creates space for the stack
            OUT
            LEA R0, FAILED
            PUTS                ; print error message
            NOT R0, R3
            ADD R0, R0, #1
            OUT
            LD R0, APOSTROPHE
            OUT
            LD R0, DOT
            OUT
            
            HALT            ; Halt.


DELIMITER   ST R4, SAVE_STACK

            LD R2, (
            LD R3, )
            ADD R4, R2, R0
            BRz COVERT_D
            
            LD R2, )
            LD R3, (
            ADD R4, R2, R0
            BRz COVERT_D
            
            LD R2, {
            LD R3, }
            ADD R4, R2, R0
            BRz COVERT_D
            
            LD R2, }
            LD R3, {
            ADD R4, R2, R0
            BRz COVERT_D
            
            LD R2, [
            LD R3, ]
            ADD R4, R2, R0
            BRz COVERT_D
            
            LD R2, ]
            LD R3, [
            ADD R4, R2, R0
            BRz COVERT_D
            
            AND R2, R2, #0 ; clear r2
            
            
COVERT_D    NOT R2, R2
            ADD R2, R2, #1
            BRnzp FD
            
FD          LD R4, SAVE_STACK
            RET

; TODO: Add any additional required constants or subroutines below this point.
PROMPT      .STRINGZ "Enter a string: "
PASSING     .STRINGZ "Delimiters are balanced."
FAILED      .STRINGZ "Delimiters are not balanced. Expected '"


; Spacers
ROOK_SPACER .FILL x-0A ; trying to do some chess naming conventions LOL
KING_SPACER .FILL x0A  ; ascii 10
SAVE_STACK  .FILL x00


; Saving space for symbols
DOT         .FILL x2E
(           .FILL x-28 ; ascii 40
)           .FILL x-29 ; ascii 41
{           .FILL x-7B ; ascii 123
}           .FILL x-7D ; ascii 125
[           .FILL x-5B ; ascii 91
]           .FILL x-5D ; ascii 93
APOSTROPHE  .FILL x27

            .BLKW #6

; NOTE: Do not alter the following lines. They allow the subroutines in other
;       files to be called without manually calculating their offsets.

PUSH        ST  R6, PUSHR6
            ST  R7, PUSHR7
            LDI R6, PUSHADDR
            JSRR R6
            LD  R7, PUSHR7
            LD  R6, PUSHR6
            RET

PUSHR6      .FILL x0000
PUSHR7      .FILL x0000
PUSHADDR    .FILL x4000

POP         ST  R6, POPR6
            ST  R7, POPR7
            LDI R6, POPADDR
            JSRR R6
            LD  R7, POPR7
            LD  R6, POPR6
            RET

POPR6       .FILL x0000
POPR7       .FILL x0000
POPADDR     .FILL x4001

PEEK        ST  R6, PEEKR6
            ST  R7, PEEKR7
            LDI R6, PEEKADDR
            JSRR R6
            LD  R7, PEEKR7
            LD  R6, PEEKR6
            RET

PEEKR6      .FILL x0000
PEEKR7      .FILL x0000
PEEKADDR    .FILL x4002

            .END
