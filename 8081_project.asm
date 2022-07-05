      ; -----------------------------------------------------------
      ; Microcontroller Based Systems homework example
      ; Author name: Ali Muneeb
      ; Neptun code: ZG0KE2
      ; -------------------------------------------------------------------
      ; Task description:
      ;   Center alignment of a sentence (ASCII string) in a c of given character length.
      ;   The size of the field is an input parameter. Use space characters (ASCII code: 0x20)
      ;   to fill the empty positions. The field which contains the aligned text does not need
      ;   to be null-terminated.
      ;   Inputs: Start address of the (null-terminated) string (pointer),
      ;           start address of the field (pointer),
      ;           length of the field (value)
      ;   Output: The correctly filled field containing the aligned text
      ; -------------------------------------------------------------------
       
       
      ; Definitions
      ; -------------------------------------------------------------------
       
      ; Address symbols for creating pointers
       
      FIELD_ADDR_IRAM  EQU 0x40
      FIELD_LEN  EQU 16
       
      ; Test data for input parameters
      ; (Try also other values while testing your code.)
       
      ; Store the string in the code memory as an array
       
      ORG 0x0070 ; Move if more code memory is required for the program code
      STR_ADDR_CODE:
      DB "Hello 8051!"
      DB 0
       
      ; Interrupt jump table
      ORG 0x0000;
     SJMP  MAIN                  ; Reset vector
       
       
       
      ; Beginning of the user program, move it freely if needed
      ORG 0x0010
       
      ; -------------------------------------------------------------------
      ; MAIN program
      ; -------------------------------------------------------------------
      ; Purpose: Prepare the inputs and call the subroutines
      ; -------------------------------------------------------------------
       
  MAIN:
       
          ; Prepare input parameters for the subroutine
 MOV DPTR,#STR_ADDR_CODE
 MOV R6,#FIELD_ADDR_IRAM
 MOV R7,#FIELD_LEN
       
      ; Infinite loop: Call the subroutine repeatedly
      LOOP:
       
  CALL STR_ALIGN_CENTER ; Call the right align subroutine
       
    SJMP  LOOP
       
       
       
       
      ; ===================================================================          
      ;                           SUBROUTINE(S)
      ; ===================================================================          
       
      ; -------------------------------------------------------------------
      ; STR_ALIGN_CENTER
      ; -------------------------------------------------------------------
      ; Purpose: Center alignment of a sentence (ASCII string) in a memory field of given character length.
      ; -------------------------------------------------------------------
      ; INPUT(S):
      ;   DPTR - Base address of the string in code memory
      ;   R6 - Base address of the field in internal memory
      ;   R7 - Length of the field
      ; OUTPUT(S):
      ;   -
      ; MODIFIES:
      ;   [TODO]
      ;The value these register and pointers are changing
      ;DPTR:Pointer to string 
      ;R1:Used to find the string length and latter on used to put the spcaes before the string
      ;R4:String lengh its decremneting while putting string from program memory to data memory
      ;R0:starting address of the data memory
      ;R4 :putting spaces(0x20) after the string
      ; -------------------------------------------------------------------
         
       
      STR_ALIGN_CENTER:
      ;This is LOOP2 i am going to find the length of string 
       
 mov A,R6;shorting the string length in R4 
 mov R0,A
       
 MOV DPTR,#STR_ADDR_CODE
MOV R1,#-1 ;Because while calculating the string length becuase while ;checking the terminater first 
      ;we increment the value of R1 and then check thats why the length ;should me decreased first
      LOOP2:
 MOV A,#0
 movc A,@A+DPTR
 inc DPTR
 inc R1
jnz LOOP2
       
       
mov A,R1
mov R4,A
       
       
       
 mov A,R7
 SUBB A,R1

 mov B,#2
 div AB
 mov R1,A ;R1 for putting initial spaces
 mov R2,A;R1 for putting last spaces
      
 
       
      ;Intial spaces on the given address
       
ODD_NUMER_INCR:
MOV A,B
jz CC       
INCREMNET:
Inc R2

CC:

 LOOP_SPACE_FIRST:
 MOV A,R1
 jz AA
      LOOP_SPACE_FIRST_Act:
 MOV A,#0x20
 MOV @R0,A
 inc R0
 djnz R1,LOOP_SPACE_FIRST
      AA:
         
         
      ;Putting the whole string after the initial spaces
 MOV DPTR,#STR_ADDR_CODE
      LOOP1:
 MOV A,#00
 movc A,@A+DPTR
 MOV @R0,A
 inc DPTR
inc R0
djnz R4,LOOP1
      ; [TODO: Place your code here]
       
      ;Putting spcaes at the end of string 
      LOOP_SPACE_LAST:
MOV A,R2
jz BB
       
      LOOP_SPACE_LAST_Act:
MOV A,#0x20
MOV @R0,A
inc R0
 djnz R2,LOOP_SPACE_LAST
       
       BB:
       
RET
       
      ; [TODO: You can also create other subroutines if needed.]
       
      ;MOV R4,#FIELD_LEN;
