#include <xc.inc>
    
GLOBAL _drawLine
GLOBAL _line_buffer

;Number of displayed lines = inner * outer
INNER_LOOPS	EQU	240
OUTER_LOOPS	EQU	2
	
V_FRONT_PORCH	EQU	11
V_SYNC_PULSE	EQU	2
V_BACK_PORCH	EQU	31
	
ARRAY_ADDR	EQU	0x20

PSECT udata_bank0
    _line_buffer:
	DS 80
    
PSECT udata_bank1
    linecount_outer:
	DS 1
    linecount_inner:
	DS 1
    v_counter:
	DS 1
    v_state:
	DS 1
    

PSECT mainCode, class=CODE, delta=2

_drawLine:
    MOVLB   0x01			    ;Select bank 1
    
    MOVLW   OUTER_LOOPS
    MOVWF   BANKMASK(linecount_outer)	    ; outer counter (2 passes)
    MOVLW   INNER_LOOPS
    MOVWF   BANKMASK(linecount_inner)	    ; inner counter (240 lines each)
    CLRF    BANKMASK(v_counter)
    CLRF    BANKMASK(v_state)
    
    MOVLB   0x00			    ;Select bank 0
    CLRF    FSR1H
    
    frame:
    
    line_loop:
    ;------------- 4 Instruction front porch (16 pixel clocks) ------------
    ;; 3 instructions from MOVWF and GOTO at EOL
    MOVLW   ARRAY_ADDR
    
    ;------------- 24 Instruction sync pulse (96 pixel clocks) ------------

    BCF	    BANKMASK(LATC), 6
    MOVLB   0x01			;Select bank 1
    BTFSC   BANKMASK(v_counter), 7	;Skip next instruction (NOP) if bit 7 is zero
    GOTO    vblank
    MOVLB   0x00			;Select bank 0
    NOP
    NOP
    NOP 
    NOP
    NOP
    
    MOVWF   FSR1L
    
    MOVLB   0x01				;Select bank 1
    DECFSZ  BANKMASK(linecount_inner), 1	;Decrement linecount and store in linecount, skip next instruction if zero
    GOTO    long_continue_sync			;Continue sync pulse if linecount not zero
    
    ;If inner linecount is zero
    MOVLW   INNER_LOOPS
    MOVWF   BANKMASK(linecount_inner)
    DECFSZ  BANKMASK(linecount_outer), 1	;If second time counting down from 240
    GOTO    short_continue_sync
    
    ;If outer linecount is zero
    MOVLW   OUTER_LOOPS
    MOVWF   BANKMASK(linecount_outer)
    BSF	    BANKMASK(v_counter), 7
    GOTO    shorter_continue_sync
    ;GOTO    vblank
    
long_continue_sync:   ;After 15 cycles 
    NOP
    NOP
    NOP
    NOP
    
short_continue_sync:	;After 19 cycles
    NOP
    NOP
    NOP
    NOP
    
shorter_continue_sync:	;After 23 cycles
    MOVLB   0x00	;Select bank 0
    
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
    MOVIW   FSR1++
    
    ;------------- Output 80 pixels with 160 instructions (640 pixel clocks) ------------
    
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
    MOVIW   FSR1++
    MOVWF   BANKMASK(LATC)
    MOVLW   0b11000000
    MOVWF   BANKMASK(LATC)
    GOTO line_loop
    
vblank:
    ;;;FINISH LAST LINE AS EMPTY LINE
    ;Finish last sync pulse, got here with 5 cycles
    BCF	BANKMASK(v_counter), 7
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
    MOVLB   0x00    ;Select bank 0
    
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
    MOVLB   0x01    ;Select bank 1
    MOVLW   (V_FRONT_PORCH - 1)
    MOVWF   BANKMASK(v_counter)
    
    v_early_front_porch:
    ;16 Instruction padding
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    v_early_sync_pulse_setup:
    ;7 Instruction padding
    NOP
    NOP
    NOP
    v_early_back_porch_setup:
    ;4 Instruction padding
    NOP
    NOP
    NOP
    NOP
    
    
    ;-------END OF FIRST VBLANK LINE---------;

    v_front_porch:
    ;4 instruction front porch
    MOVLB   0x00    ;Select bank 1
    NOP
    NOP
    NOP
    ;24 instruction sync
    BCF BANKMASK(LATC),  6
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
    ;12 instruction back porch
    BSF BANKMASK(LATC),  6
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
    ;160 instruction active video (-10)
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
    
    ;-----------140 instructions
    MOVLB   0x01
    DECFSZ  BANKMASK(v_counter)
    GOTO    v_early_front_porch
   
    BTFSS   BANKMASK(v_state), 0
    ;MOVLW   V_SYNC_PULSE
    ;MOVLW   V_BACK_PORCH
    GOTO    v_sync_pulse_setup
    GOTO    v_back_porch_setup
    
    v_sync_pulse_setup:
    BSF	    BANKMASK(v_state), 0
    MOVLW   V_SYNC_PULSE
    MOVWF   BANKMASK(v_counter)
    MOVLB   0x00
    BCF	    BANKMASK(LATC), 7
    GOTO    v_early_sync_pulse_setup
    
    v_back_porch_setup:
    ;Here after 7 cycles
    BTFSC   BANKMASK(v_state), 1
    GOTO    finish_vsync
    
    BSF	    BANKMASK(v_state), 1
    MOVLW   V_BACK_PORCH
    MOVWF   BANKMASK(v_counter)
    MOVLB   0x00
    BSF	    BANKMASK(LATC), 7
    GOTO    v_early_back_porch_setup
    
    finish_vsync:
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    MOVLB   0x01
    CLRF    BANKMASK(v_state)
    
    ;-----------160 instructions
    
    
    //3 instruction return to frame
    MOVLB   0x00
    GOTO    frame
    
    RETURN