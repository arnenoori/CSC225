; Performs stack-based arithmetic.
; CSC 225, Assignment 4
; Given code, Winter '21

        .ORIG x3000

MAIN    LEA R1, STACK   ; Initialize R1, the stack pointer.

LOOP    LEA R0, PROMPT  ; Print the prompt.
        PUTS
        GETC            ; Read the command into R0.
        OUT

        ; If the command is an 'a'...
IFA     LD  R3, ASCIIA
        ADD R3, R0, R3
        BRnp ELIFS
        ; add
        JSR POP ; get first integer
        ADD R3, R2, #0
        JSR POP ; get second integer
        ADD R2, R2, R3 ; compute sum
        JSR PUSH ; push to the stack
        BRnzp ENDIF

        ; Else if the command is an 's'...
ELIFS   LD  R3, ASCIIS
        ADD R3, R0, R3
        BRnp ELIFN
        ; JSR POP
        ; ADD R5, R5, #0
        ; ADD R1, R0, #0
        ; JSR POP
        ; ADD R5, R5, #0
        ; NOT R0, R0
        ; ADD R1, R1, #1
        ; ADD R0, R0, R1
        ; JSR PUSH
        JSR POP ; get first integer
        ADD R3, R2, #0
        NOT R3, R3
        ADD R3, R3, #1
        JSR POP ; get second integer
        ADD R2, R2, R3 ; compute sum
        JSR PUSH ; push to the stack
        ; TODO: Complete this case.
        BRnzp ENDIF

        ; Else if the command is an 'n'...
ELIFN   LD  R3, ASCIIN
        ADD R3, R0, R3
        BRnp ELIFQ
        ; ; TODO: Complete this case.
        ; JSR POP
        ; ADD R5, R5, #0
        ; NOT R0, R0
        ; ADD R1 R1, #1
        ; JSR PUSH
        JSR POP ; get first integer
        NOT R2, R2
        ADD R2, R2, #1
        JSR PUSH ; push to the stack
        BRnzp ENDIF

        ; Else if the command is a 'q'...
ELIFQ   LD  R3, ASCIIQ
        ADD R3, R0, R3
        BRnp ELSE
        ; TODO: Complete this case.
        GETC
        OUT
        BRnzp DONE

        ; Else, assume the command is '#'...
ELSE    ; TODO: Complete this case.
        JSR GETI
        JSR OUTI
        ADD R2, R0, #0
        JSR PUSH


ENDIF   GETC            ; Consume the newline.
        OUT
        BRnzp LOOP      ; Loop back.

DONE    LEA R0, RESSTR  ; Pop and print an integer.
        PUTS
        JSR POP
        ADD R0, R2, #0
        JSR OUTI
        LEA R0, ENDSTR
        PUTS
        HALT            ; Halt.

; Space for a stack with capacity 16:
        .BLKW #16
STACK   .FILL x00

; Shared constants:
PROMPT  .STRINGZ "Enter a command (#N/a/s/n/q): "
RESSTR  .STRINGZ "Value on top of the stack: "
ENDSTR  .STRINGZ "\n"
ASCIIA  .FILL x-61
ASCIIS  .FILL x-73
ASCIIN  .FILL x-6E
ASCIIQ  .FILL x-71

; NOTE: Do not alter the following lines. They allow the subroutines in other
;       files to be called without manually calculating their offsets.

PUSH    ST  R7, PSHR7
        ST  R5, PSHR5
        LDI R5, PSHADDR
        JSRR R5
        LD  R5, PSHR5
        LD  R7, PSHR7
        RET
PSHR5   .FILL x0000
PSHR7   .FILL x0000
PSHADDR .FILL x4000

POP     ST  R7, POPR7
        ST  R5, POPR5
        LDI R5, POPADDR
        JSRR R5
        LD  R5, POPR5
        LD  R7, POPR7
        RET
POPR5   .FILL x0000
POPR7   .FILL x0000
POPADDR .FILL x4001

GETI    ST  R7, GETR7
        ST  R5, GETR5
        LDI R5, GETADDR
        JSRR R5
        LD  R5, GETR5
        LD  R7, GETR7
        RET
GETR5   .FILL x0000
GETR7   .FILL x0000
GETADDR .FILL x5000

OUTI    ST  R7, OUTR7
        ST  R5, OUTR5
        LDI R5, OUTADDR
        JSRR R5
        LD  R5, OUTR5
        LD  R7, OUTR7
        RET
OUTR5   .FILL x0000
OUTR7   .FILL x0000
OUTADDR .FILL x5001

        .END
