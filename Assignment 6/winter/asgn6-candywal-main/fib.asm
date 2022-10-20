; Recursively computes Fibonacci numbers.
; CSC 225, Assignment 6
; Given code, Winter '22

        .ORIG x4000

; int fib(int)
; TODO: Implement this function..

FIBFN   ADD R6, R6, #-1    
        ADD R6, R6, #-1    
        STR R7, R6, #0
        ADD R6, R6, #-1     
        STR R5, R6, #0
        ADD R5, R6, #-1     
        ADD R6, R6, #-2     

        AND R1, R1, #0
        LDR R0, R5, #4
        BRp POS               
        BRnzp TDOWN       

POS     AND R4, R4, #0
        ADD R4, R0, #-1
        BRp RETN01           
        ADD R1, R1, #1
        BRnzp TDOWN        

RETN01   LDR R0, R5, #4      
        ADD R0, R0, #-1
        ADD R6, R6, #-1
        STR R0, R6, #0      
        JSR FIBFN           

        LDR R1, R6, #0      
        STR R1, R5, #0
        ADD R6, R6, #2

        LDR R0, R5, #4      
        ADD R0, R0, #-2
        ADD R6, R6, #-1
        STR R0, R6, #0      
        JSR FIBFN           
        LDR R1, R6, #0      
        STR R1, R5, #-1

        ADD R6, R6, #2

        LDR R0, R5, #0
        LDR R1, R5, #-1

        ADD R1, R1, R0      

TDOWN  STR R1, R5, #3      
        ADD R6, R5, #1
        LDR R5, R6, #0
        ADD R6, R6, #1
        LDR R7, R6, #0
        ADD R6, R6, #1

        RET

        .END
