CSDS16	EQU	0FF30H						;
CSDB16	EQU	0FF38H
T0IB    BIT     7FH
SEGOFF  BIT     P1.6
PRZE_1  EQU     7DH
PRZE_2  EQU     7EH
S_J     EQU     6AH
S_D     EQU     6BH
    ORG 0H
    LJMP START

    ORG 0BH
    LJMP TI0MAIN
    ORG 0B0H
TI0MAIN:
      PUSH ACC
      PUSH PSW

      MOV TH0, #255 - 3
      ADD A, TL0
      MOV TL0, A

      JNC TI0MAIN_TH0_OK
      INC TH0

TI0MAIN_TH0_OK:
      POP PSW
      POP ACC
      SETB T0IB
      RETI

      ORG 100H
START:
      MOV S_J, #0
      MOV S_D, #0
      MOV IE, #00H
      MOV TMOD, #71H
      MOV TCON, #10H
      SETB ET0
      SETB EA
      MOV PRZE_1, #250
      MOV PRZE_2, #4
      MOV R1, #0
ZEGARSTART:
      JNB T0IB, ZEGARSTART
      CLR T0IB;

      MOV A, S_J
      MOV DPTR, #WZORY
      MOVC A, @A+DPTR
      MOV DPTR, #CSDB16
      MOVX @DPTR, A
      MOV DPTR, #CSDS16
      MOV A, #1;
      MOVX @DPTR, A
      CLR SEGOFF
      SETB SEGOFF

      MOV A, S_D
      MOV DPTR, #WZORY
      MOVC A, @A+DPTR
      MOV DPTR, #CSDB16
      MOVX @DPTR, A
      MOV DPTR, #CSDS16
      MOV A, #2
      MOVX @DPTR, A
      CLR SEGOFF
      SETB SEGOFF

      MOV A, #7
      MOV DPTR, #WZORY
      MOVC A, @A+DPTR
      MOV DPTR, #CSDB16
      MOVX @DPTR, A
      MOV DPTR, #CSDS16
      MOV A, #4
      MOVX @DPTR, A
      CLR SEGOFF
      SETB SEGOFF

      MOV A, #3
      MOV DPTR, #WZORY
      MOVC A, @A+DPTR
      MOV DPTR, #CSDB16
      MOVX @DPTR, A
      MOV DPTR, #CSDS16
      MOV A, #8
      MOVX @DPTR, A
      CLR SEGOFF
      SETB SEGOFF

      MOV A, #1
      MOV DPTR, #WZORY
      MOVC A, @A+DPTR
      MOV DPTR, #CSDB16
      MOVX @DPTR, A
      MOV DPTR, #CSDS16
      MOV A, #16
      MOVX @DPTR, A
      CLR SEGOFF
      SETB SEGOFF

      MOV A, #2
      MOV DPTR, #WZORY
      MOVC A, @A+DPTR
      MOV DPTR, #CSDB16
      MOVX @DPTR, A
      MOV DPTR, #CSDS16
      MOV A, #32
      MOVX @DPTR, A
      CLR SEGOFF
      SETB SEGOFF

      DJNZ PRZE_1, SKROT
      MOV PRZE_1, #250
      DJNZ PRZE_2, SKROT
      MOV PRZE_2, #4
      INC S_J
      MOV A, S_J
      CJNE A, #10, SKROT
      INC S_D
      MOV S_J, #0
      MOV A, S_D
      CJNE A, #6, SKROT
      MOV S_D, #0
SKROT:
      LJMP ZEGARSTART

;############################ WZORY
WZORY:
	DB	00111111B, 00000110B, 01011011B, 01001111B	;0123
	DB	01100110B, 01101101B, 01111101B, 00000111B	;4567
	DB	01111111B, 01101111B, 01110111B, 01111100B	;89Ab
	DB	01011000B, 01011110B, 01111001B, 01110001B	;cdEF
;############################################
END