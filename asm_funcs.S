#include <xc.inc>
    
GLOBAL _drawLine
GLOBAL _line_buffer
    
PSECT udata_bank0
    _line_buffer:
	DS 80
    
PSECT udata_bank1
    linecount_outer:
	DS 1
    linecount_inner:
	DS 1
    

PSECT mainCode, class=CODE, delta=2

_drawLine:
    BANKSEL linecount_outer
    
    MOVLW   2
    MOVWF   BANKMASK(linecount_outer)   ; outer counter (2 passes)
    MOVLW   240
    MOVWF   BANKMASK(linecount_inner)     ; inner counter (240 lines each)
    
    BANKSEL LATC
    frame:
    
    line_loop:
    ;------------- 4 Instruction front porch (16 pixel clocks) ------------
    ;; 2 instructions from GOTO at EOF
    MOVLW 0x20
    
    
    ;------------- 24 Instruction sync pulse (96 pixel clocks) ------------

    BCF BANKMASK(LATC), 6
    MOVWF FSR1L
    CLRF FSR1H
    /*DECFSZ BANKMASK(linecount_inner), 1	;Decrement linecount and store in linecount, skip next instruction if zero
    GOTO long_continue_sync			;Continue sync pulse if linecount not zero
    
    ;If inner linecount is zero
    MOVLW   240
    MOVWF   BANKMASK(linecount_inner)
    DECFSZ  BANKMASK(linecount_outer), 1	;If second time counting down from 240
    GOTO    short_continue_sync
    
    ;If outer linecount is zero
    GOTO    vblank*/
long_continue_sync:    
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
short_continue_sync:
    NOP
    NOP
    NOP
    NOP
    NOP 
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    
    ;------------- 12 Instruction back porch (48 pixel clocks) ------------
   
    BSF BANKMASK(LATC), 6
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    
    ;------------- Output 80 pixels with 160 instructions (640 pixel clocks) ------------
    
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVLW   0b11000000
    MOVWF   BANKMASK(LATC)
    GOTO line_loop
    
vblank:
    ;;;FINISH LAST LINE AS EMPTY LINE
    ;Finish last sync pulse
    NOP
    NOP
    NOP
    NOP 
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    
    ;------------- 12 Instruction back porch (48 pixel clocks) ------------
   
    BSF BANKMASK(LATC), 6
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    
    ;------------- Output 80 pixels with 160 instructions (640 pixel clocks) ------------
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    ;Commented 6 for the 6 instructions below
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    
    ;do horizontal line
    ;MOVLW   240
    ;MOVWF   BANKMASK(linecount_inner)
    ;MOVLW   2
    ;MOVWF   BANKMASK(linecount_outer)
    GOTO frame
    
    RETURN