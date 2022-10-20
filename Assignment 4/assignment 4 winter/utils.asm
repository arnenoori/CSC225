; Implements integer I/O utilities.
; CSC 225, Assignment 4
; Given code, Winter '20

        .ORIG x5000     ; NOTE: Do not alter these addresses. They are
        .FILL GETI      ;       hardcoded within "calculator.asm", since the
        .FILL OUTI      ;       assembler cannot resolve cross-file labels.

; Reads one integer in the range {-9, ..., 9}.
;  Takes no arguments.
;  Returns the read integer in R0.
;  TODO: Implement this subroutine.
GETI

    ST R1, REVERT1
    LD R1, DNEGATIVE
    
    GETC
    
    ADD R1, R1, R0
    BRnp CHECKZERO
    
    GETC
    
    LD R1, NZERO
    ADD R0, R0, R1
    NOT R0, R0
    ADD R0, R0 #1
    
    Brnzp GETR1
    
CHECKZERO
    LD R1, NZERO
    ADD R0, R0, R1
    
GETR1
    LD R1, REVERT1
    RET
    
; Prints one integer in the range {-9, ..., 9}.
;  Takes the integer in R0.
;  Returns no values.
;  TODO: Implement this subroutine.
OUTI
    ST R1, REVERT1
    ST R0, REVERT
    ADD R0, R0, #0
    
    Brn CHECKNEGATIVE
    LD R1 ZERO
    ADD R0, R1, R0
    OUT
    
    BRnzp GETR0
    
CHECKNEGATIVE
    ADD R1, R0, #0
    LD R0, NEGATIVE
    OUT
    
    NOT R1, R1
    ADD R1, R1, #1 
    
    LD R0, ZERO
    ADD R0, R0, R1
    OUT
GETR0
    LD R1, REVERT1
    LD R0, REVERT
    RET
    ; 
REVERT .FILL x0000
REVERT1 .FILL x0000
NEGATIVE .FILL #45
DNEGATIVE .FILL #-45
ZERO .FILL #48
NZERO .FILL #-48


        .END


; .ORIG x3000
;     LEA R0, PROMPT_ENCRYPT_VALUE   ; loads users entered message into R0
;     PUTS                                ; prints prompt_unecrypted_string
    
;     GETC
;     PUTC
    
;     LD R1 ASCII_OFFSET ; ascii 
;     ADD R0, R0 R1 ; -48 offset
    
;     ADD R2 R0 #0 ; R2 stores key 
    
;     GETC
;     PUTC ; Enter key
    
;     LEA R0, PROMPT_UNENCRYPTED_STRING ; prompts user to enter the key they want to encrypt
;     PUTS
    
;     LEA R1, ARRAY ; stores R1 in Array
    
; inputLoop:
;     GETC
;     PUTC
    
;     ADD R3 R0 #-10
;     BRz enter
    
;     ADD R0, R0, R2
;     LD R4 TOO_LITTLE
;     LD R5 TOO_BIG
    
;     ADD R4 R0 R4
;     BRn replaces 

;     ADD R5 R0 R5
;     BRp replaces
    
;     BRnzp #1

; replaces: 
;     LD R0 QUESTION

;     STR R0, R1, #0 ; storing R0 into the address at R1

;     ADD R1 R1 #1
    
;     BRnp inputLoop

; enter:    
;     LEA R0 RETURN_ENCRYPTED
;     PUTS

;     LEA R0 ARRAY
;     PUTS

;     AND R0 R0, #0
;     LD R1 EDGE
;     LEA R2 ARRAY
    
; memoryclear:
;     STR R0 R2 #0
;     ADD R2 R2 #1
;     ADD R1 R1 #-1
    
;     Brp memoryclear
    
;     HALT ; TRAP 25

; ARRAY .BLKW #33 ; create an array to hold maximum of 33 characters
; ASCII_OFFSET .FILL #-48
; PROMPT_UNENCRYPTED_STRING   .STRINGZ "Unencrypted string: " ; string to be encrypted
; PROMPT_ENCRYPT_VALUE  .STRINGZ "Encryption key (0-9): "   ; sets up the cipher
; RETURN_ENCRYPTED .STRINGZ "Encrypted string: "                  ; outputs encrypted string depending on encryption key value
; TOO_LITTLE .FILL #-32
; TOO_BIG .FILL #-126
; QUESTION .FILL x3F
; EDGE .FILL #33

; .END