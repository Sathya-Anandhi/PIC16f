# 1 "main_assembly.s"
# 1 "<built-in>" 1
# 1 "main_assembly.s" 2






processor 16F877A

CBLOCK 0X20
  COUNT1
  COUNT2
ENDC

; Similar to Macro Definition in C-Programming

PORTB EQU 0X06 ;Address of PortB
PORTC EQU 0X07 ;Address of Portc

TRISB EQU 0X86 ;Address of PortB Config Reg
TRISC EQU 0X87

 STATUS EQU 0X03 ;Address of Status Register

 ORG 0X00 ;Starting adress of program coutner user defined

 MAIN:
    ;Selecting reg Bank-0 <rp1(0) rp0(0)>
    BCF STATUS, 6 ;Clear the 6th bit of status reg.
    BCF STATUS, 5 ;Clear the 5th bit of status reg.
    MOVLW 0X00; ;Move 0x00 (clear) to Working reg.
    MOVWF PORTB ;Clear PORTB before making it as OUPUT.

    ;Selecting reg Bank-1 <rp1(0) rp0(1)>
    BCF STATUS, 6
    BSF STATUS, 5
    MOVLW 0X00
    MOVWF TRISC ;Config PORTC as OUTPUT.

 MAINLOOP:
    BCF PORTB, 0
    CALL DELAY3
    BSF PORTB, 0
    CALL DELAY3
    GOTO MAINLOOP

DELAY3:
    DECFSZ COUNT1
    GOTO DELAY3
    DECFSZ COUNT2
    GOTO DELAY3
    RETURN
END
