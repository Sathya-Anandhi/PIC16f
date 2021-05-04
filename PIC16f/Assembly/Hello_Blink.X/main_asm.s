    ;Simple code to demonstrate the Led Blink with assembly code.
    ;The code configures PORTB pin 0 as output pin.
    ;Making the pin toggle between HIGH and LOW with a reasonable delay to visualize.
    ;Simple subroutine is coded to generate some delay.
    ;Code can be Improved in Future.

PROCESSOR 16f877a

#include <xc.inc>

;Configuration Bit Settings
;For simulation purpose some default configurations has been reconfigured.
    
  CONFIG  FOSC = HS             ; Oscillator Selection bits (HS oscillator)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = ON            ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP = OFF             ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF             ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT = OFF             ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP = OFF   

PSECT   MAINCODE, GLOBAL, CLASS = CODE, DELTA = 2 ; PIC10/12/16
 
;Bank0 General Purpose Registers for Delay Generation.
COUNT1 EQU 0X20
COUNT2 EQU 0X21
COUNT3 EQU 0X22
 
PORTB EQU 0X06	;Address of PortB 

TRISB EQU 0X86	;Address of PortB Config Reg

STATUS EQU 0X03   ;Address of Status Register
 
 SETUP:
    ;Selecting reg Bank-0	<rp1(0) rp0(0)>
    BCF STATUS, 6	;Clear the 6th bit of status reg.
    BCF STATUS, 5	;Clear the 5th bit of status reg.
    MOVLW 0X00	    ;Move 0x00 (clear) to Working reg.
    MOVWF PORTB	    ;Clear PORTB before making it as OUPUT 
		    ;else it might affect the device connected on it.

    ;Selecting reg Bank-1   <rp1(0) rp0(1)>
    BCF STATUS, 6	
    BSF STATUS, 5
    MOVLW 0XFE
    MOVWF TRISB	;Config PORTC as OUTPUT.
    
    ;Selecting reg Bank-0	<rp1(0) rp0(0)>
    BCF STATUS, 6	;Clear the 6th bit of status reg.
    BCF STATUS, 5	;Clear the 5th bit of status reg.
    GOTO MAINLOOP
    
;Infinite loop for led blink (simillar to) -> while(True) in C-Programming
 MAINLOOP:
    BSF PORTB, 0    ;set PORTB bit 0 (ie ON).
    CALL DELAY	    ;Call to delay routine.
    BCF PORTB, 0    ;Clear PORTB bit 0 (ie OFF).
    CALL DELAY
    GOTO MAINLOOP   ;Routine calling itself.
    
;Delay Routine (approximation) to visualize led blink.
;Three loops nested to generate a reasonable delay function.(0x66 arbitary value)
DELAY:	MOVLW 0X66  
	MOVWF COUNT1
LOOP3:	MOVLW 0X66
	MOVWF COUNT2
LOOP2:	MOVLW 0X66
	MOVWF COUNT3
LOOP1:	DECFSZ COUNT3
	GOTO LOOP1
	DECFSZ COUNT2
	GOTO LOOP2
	DECFSZ COUNT1
	GOTO LOOP3
	RETURN
END;