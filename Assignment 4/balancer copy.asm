; Verifies the balance of string delimiters.
; CSC 225, Assignment 4
; Given code, Spring '22

            .ORIG x3000

MAIN        LEA R1, STACK   ; Initialize R1, the stack pointer.
            LEA R0, PROMPT  ; Print the prompt.
            PUTS
            
            ;       If an opening delimiter is typed, push it onto the stack.
            ;       If a closing delimiter is typed, pop an opening delimiter
            ;       off of the stack and ensure that they match.
            ;       When the expression ends, ensure that the stack is empty.
LOOP        GETC
            OUT
            LD R2, N_ENTER
            ADD R2, R2, R0
            BRz ENT_PRE         ; Expression ended
            JSR DELIMITERS      ; Get delimiter and store in R3
            ADD R2, R2, #0      ; If delim is 0...
            BRz LOOP            ; ...loop next character.
            
            ; Check if opening delimiter is typed
            LD R4, (
            ADD R4, R4, R2
            BRz OPEN_P         ; If delimiter is typed then push it

            LD R4, {
            ADD R4, R4, R2
            BRz OPEN_P
            
            LD R4, [
            ADD R4, R4, R2
            BRz OPEN_P

            ; Check if closing delimiter is typed
            LD R4, )        ; 
            ADD R4, R4, R2  ;
            BRnp #1
            JSR CLOSE_P

            LD R4, ]        ; 
            ADD R4, R4, R2  ;
            BRnp #1
            JSR CLOSE_P

            LD R4, }        ; 
            ADD R4, R4, R2  ;
            BRnp #1
            JSR CLOSE_P

ENT_PRE     JSR PEEK             ; Pop stack to see what's in R2
            ADD R2, R2, #0
            BRnp NOT_EMP    ; If not empty then go

            LEA R0, PASS
            PUTS
            HALT            ; Halt.

; Space for a stack with capacity 16:
            .BLKW #16
STACK       .FILL x00

; If opening delimiter is typed then push to stack and start loop again
OPEN_P      JSR PUSH
            BRnzp LOOP

; If closing delimiter is in R2 then find opposite delimiter and put in R3
; TODO: Fix this 
CLOSE_P     ADD R4, R2, #0      ; Copy delimiter in R2 and put in R4
            JSR POP             ; Put delimiter in R2
            ADD R5, R2, R3      ; Check if opposite delimiter is the same   
            BRnp #1             ; if not the same then skip
            BRnzp LOOP          ; if opposite delimiter is the same then loop again
            
            ADD R2, R2, #0      ; If stack empty than use current delimiter
            BRnp NOT_EMP        ; else use stack delimiter
            ADD R4, R2, #0      ; use current delimiter
            BRnzp #1
            
NOT_EMP     ADD R0, R2, #0      ; put delimiter in R0
            JSR DELIMITERS      ; Check what opposite delimiter is and store in R3
            LD R0, P_ENTER      ; bruh
            OUT                 ; output enter
            LEA R0, FAIL            ; load error message
            PUTS                ; print error message
            NOT R0, R3          ; Put opposite delimiter in R0 and negate
            ADD R0, R0, #1
            OUT                 ; print opposite delimiter
            LD R0, APOT_MARK    ; print quotation marks
            OUT
            LD R0, PERIOD       ; print final period
            OUT
            HALT

; Checks if there are delimiters in R0
; Puts delimiter in R2 and opposite negative delimiter in R3
; If no delimiter is found it puts 0 in R2
DELIMITERS  ST R4, SAVER4

            LD R2, (
            LD R3, )
            ADD R4, R2, R0      ; Check if delim found
            BRz DELIM_FOUND

            LD R2, )
            LD R3, (
            ADD R4, R2, R0      ; Check if delim found
            BRz DELIM_FOUND

            LD R2, [
            LD R3, ]
            ADD R4, R2, R0      ; Check if delim found
            BRz DELIM_FOUND

            LD R2, ]
            LD R3, [
            ADD R4, R2, R0      ; Check if delim found
            BRz DELIM_FOUND

            LD R2, {
            LD R3, }
            ADD R4, R2, R0      ; Check if delim found
            BRz DELIM_FOUND

            LD R2, }
            LD R3, {
            ADD R4, R2, R0      ; Check if delim found
            BRz DELIM_FOUND

            AND R2, R2, #0      ; Clear R3 if nothing was found
            
FINISH      LD R4, SAVER4
            RET

; Convert delimiters from negative to positive
DELIM_FOUND NOT R2, R2
            ADD R2, R2, #1
            BRnzp FINISH

PROMPT      .STRINGZ "Enter a string: "
PASS        .STRINGZ "Delimiters are balanced."
FAIL        .STRINGZ "Delimiters are not balanced. Expected '"
P_ENTER     .FILL x0A
N_ENTER     .FILL x-0A
APOT_MARK   .FILL x27
PERIOD      .FILL x2E
(           .FILL x-28
)           .FILL x-29
[           .FILL x-5B
]           .FILL x-5D
{           .FILL x-7B
}           .FILL x-7D
SAVER4      .FILL x00

; Create space for an array of delimiters
            .BLKW #6
DELIM_ARR   .FILL x00

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
