// PIC16F15244 LED Blink - XC8 Compiler
// CONFIG1
//#pragma config FEXTOSC = OFF    // External Oscillator Mode Selection bits (Oscillator not enabled)
//#pragma config RSTOSC = HFINTOSC_32MHZ// Power-up Default Value for COSC bits (HFINTOSC (32 MHz))
#pragma config FEXTOSC = 11     //External oscillator at or above 16 MHz
#pragma config RSTOSC = 111     //External oscillator select
#pragma config CLKOUTEN = OFF   // Clock Out Enable bit (CLKOUT function is disabled; I/O function on RA4)
#pragma config VDDAR = HI       // VDD Range Analog Calibration Selection bit (Internal analog systems are calibrated for operation between VDD = 2.3V - 5.5V)

// CONFIG2
#pragma config MCLRE = EXTMCLR  // Master Clear Enable bit (If LVP = 0, MCLR pin is MCLR; If LVP = 1, RA3 pin function is MCLR)
#pragma config PWRTS = PWRT_OFF // Power-up Timer Selection bits (PWRT is disabled)
#pragma config WDTE = OFF       // WDT Operating Mode bits (WDT disabled; SEN is ignored)
#pragma config BOREN = ON       // Brown-out Reset Enable bits (Brown-out Reset Enabled, SBOREN bit is ignored)
#pragma config BORV = LO        // Brown-out Reset Voltage Selection bit (Brown-out Reset Voltage (VBOR) set to 1.9V)
#pragma config PPS1WAY = ON     // PPSLOCKED One-Way Set Enable bit (The PPSLOCKED bit can be set once after an unlocking sequence is executed; once PPSLOCKED is set, all future changes to PPS registers are prevented)
#pragma config STVREN = ON      // Stack Overflow/Underflow Reset Enable bit (Stack Overflow or Underflow will cause a reset)

// CONFIG3

// CONFIG4
#pragma config BBSIZE = BB512   // Boot Block Size Selection bits (512 words boot block size)
#pragma config BBEN = OFF       // Boot Block Enable bit (Boot Block is disabled)
#pragma config SAFEN = OFF      // SAF Enable bit (SAF is disabled)
#pragma config WRTAPP = OFF     // Application Block Write Protection bit (Application Block is not write-protected)
#pragma config WRTB = OFF       // Boot Block Write Protection bit (Boot Block is not write-protected)
#pragma config WRTC = OFF       // Configuration Registers Write Protection bit (Configuration Registers are not write-protected)
#pragma config WRTSAF = OFF     // Storage Area Flash (SAF) Write Protection bit (SAF is not write-protected)
#pragma config LVP = ON         // Low Voltage Programming Enable bit (Low Voltage programming enabled. MCLR/Vpp pin function is MCLR. MCLRE Configuration bit is ignored.)

// CONFIG5
#pragma config CP = OFF         // User Program Flash Memory Code Protection bit (User Program Flash Memory code protection is disabled)

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

#include <xc.h>
#define _XTAL_FREQ 32000000
#define LINE_SIZE_PX 80
#define RED     1
#define GREEN   4
#define BLUE    16

extern void drawLine(uint8_t *buf);

uint8_t hsv_to_rgb(uint8_t h) {
    h %= 24;
    
    if (h < 4) {
        return 3 * RED + (h % 4) * GREEN;
    }
    else if (h < 8) {
        return 3 * GREEN + (3 - (h % 4)) * RED;
    }
    else if (h < 12) {
        return 3 * GREEN + (h % 4) * BLUE;
    }
    else if (h < 16) {
        return 3 * BLUE + (3 - (h % 4)) * GREEN;
    }
    else if (h < 20) {
        return 3 * BLUE + (h % 4) * RED;
    }
    else if (h < 24) {
        return 3 * RED + (3 - (h % 4)) * BLUE;
    }
}

void fillLineBuffer(uint8_t line[], uint8_t size) {
    for (uint8_t i = 0; i < size; i++) {
        line[i] = (i%64) + 64 + 128;
        //line[i] = 63 + 64 + 128;
        //line[i] = hsv_to_rgb(i) + 64 + 128;
    }
}

extern uint8_t line_buffer[LINE_SIZE_PX];

int main(void) {    
    ANSELA = 0x00;
    ANSELB = 0x00;
    ANSELC = 0x00;
        
    fillLineBuffer(line_buffer, LINE_SIZE_PX);
    
    TRISC = 0; //Set output
    LATC = 0; //Set low

    while (1) {
        drawLine(line_buffer);
    }
    
    return 0;
}