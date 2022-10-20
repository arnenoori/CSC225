.ORIG x3000
    LEA R0, PROMPT_ENCRYPT_VALUE   ; loads users entered message into R0
    PUTS                                ; prints prompt_unecrypted_string
    
    GETC
    PUTC
    
    LD R1 ASCII_OFFSET ; ascii 
    ADD R0, R0 R1 ; -48 offset
    
    ADD R2 R0 #0 ; R2 stores key 
    
    GETC
    PUTC ; Enter key
    
    LEA R0, PROMPT_UNENCRYPTED_STRING ; prompts user to enter the key they want to encrypt
    PUTS
    
    LEA R1, ARRAY ; stores R1 in Array
    
inputLoop:
    GETC
    PUTC
    
    ADD R3 R0 #-10
    BRz enter
    
    ADD R0, R0, R2
    LD R4 TOO_LITTLE
    LD R5 TOO_BIG
    
    ADD R4 R0 R4
    BRn replaces 

    ADD R5 R0 R5
    BRp replaces
    
    BRnzp #1

replaces: 
    LD R0 QUESTION

    STR R0, R1, #0 ; storing R0 into the address at R1

    ADD R1 R1 #1
    
    BRnp inputLoop

enter:    
    LEA R0 RETURN_ENCRYPTED
    PUTS

    LEA R0 ARRAY
    PUTS

    AND R0 R0, #0
    LD R1 EDGE
    LEA R2 ARRAY
    
memoryclear:
    STR R0 R2 #0
    ADD R2 R2 #1
    ADD R1 R1 #-1
    
    Brp memoryclear
    
    HALT ; TRAP 25

ARRAY .BLKW #33 ; create an array to hold maximum of 33 characters
ASCII_OFFSET .FILL #-48
PROMPT_UNENCRYPTED_STRING   .STRINGZ "Unencrypted string: " ; string to be encrypted
PROMPT_ENCRYPT_VALUE  .STRINGZ "Encryption key (0-9): "   ; sets up the cipher
RETURN_ENCRYPTED .STRINGZ "Encrypted string: "                  ; outputs encrypted string depending on encryption key value
TOO_LITTLE .FILL #-32
TOO_BIG .FILL #-126
QUESTION .FILL x3F
EDGE .FILL #33

.END