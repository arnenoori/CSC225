; Supports interrupt-driven keyboard input.
; CSC 225, Assignment 5
; Given code, Winter '22

        .ORIG x500
        
; Program 1 -> takes user input and calls Trap x26 (this file)
; ISR180 -> update, print R1

; Reads one character, executing a second program while waiting for input:
;  0. Save state of Program 1
;  1. Saves the keyboard entry in the IVT. (at hex value 180)
;  2. Sets the keyboard entry in the IVT to ISR180.
;  3. Enables keyboard interrupts.
;  4. Returns to the second program.
;  5. Load state of Program 2
TRAP26                  ; TODO: Implement this service routine.
    ; Put &ISR180 into IVT
    ; Turn on interrupts
    ; Save state of P1
    ; Load State of R2
    ; R6 keeps track of top of super stack
    ; 
    ST R0, P1R1
    ST R1, P1R2
    ST R3, P1R3
    ST R4, P1R4
    ST R5, P1R5
    ST R7, P1R7
    ST R6, P1PC      ; points to PC
    ST R6, P1PSR, #1 ; PSR offset of 1
    
    ; get the contents at memory location 180 and store it in
    ; SAVEIV
    LDR R4, R4, #0
    ADD R2, R4, #1
    RET
    
    
    RTI

; Responds to a keyboard interrupt:
;  0. Save state of Program 2
;  1. Disables keyboard interrupts.
;  2. Restores the original keyboard entry in the IVT.
;  3. Places the typed character in R0.
;  4. Returns to the caller of TRAP26. (-> Save state of P2)
;  5. Load state of Program 1
ISR180                  ; TODO: Implement this service routine.


; Program 1's data:
P1R1    .FILL x0000     ; TODO: Use these memory locations to save and restore
P1R2    .FILL x0000     ;       the first program's state.
P1R3    .FILL x0000
P1R4    .FILL x0000
P1R5    .FILL x0000
P1R7    .FILL x0000
P1PC    .FILL x0000
P1PSR   .FILL x0000

; Program 2's data:
P2R0    .FILL x0000     ; TODO: Use these memory locations to save and restore
P2R1    .FILL x0000     ;       the second program's state.
P2R2    .FILL x0000
P2R3    .FILL x0000
P2R4    .FILL x0000
P2R5    .FILL x0000
P2R7    .FILL x0000
P2PC    .FILL x4000     ; Initially, Program 2's PC is 0x4000.
P2PSR   .FILL x8002     ; Initially, Program 2 is unprivileged.

; Shared data:
SAVEIV  .FILL x0000     ; TODO: Use this memory location to save and restore
                        ;       the keyboard's IVT entry.

; Shared constants:
KBIV    .FILL x0180     ; The keyboard's interrupt vector (current keyboard entry)
KBSR    .FILL xFE00     ; The Keyboard Status Register
KBDR    .FILL xFE02     ; The Keyboard Data Register
KBIMASK .FILL x4000     ; The keyboard interrupt bit's mask

        .END
