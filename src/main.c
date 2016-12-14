#include <avr/io.h>
#include <util/delay.h>

/************************************************************************/
/*                           Defining Constants                         */
/************************************************************************/

//--- PIN Assignments ----------------------------------------------------
#define RED_PIN             3
#define GREEN_PIN           4
#define BLUE_PIN            5
#define BUZZ_PIN            1

//--- PIN Controls -------------------------------------------------------
#define RED_ON              (PORTB |= (0x0F))
#define RED_OFF             (PORTB &= ~(1<<RED_PIN))
#define GREEN_ON            (PORTB |= (0x10))
#define GREEN_OFF           (PORTB &= ~(1<<GREEN_PIN))
#define YELLOW_ON           (PORTB |= (1<<RED_PIN) | (1<<GREEN_PIN))
#define YELLOW_OFF          (PORTB &= (0x00))

#define BUZZ_ON             (PORTB |= (1<<BUZZ_PIN))
#define BUZZ_OFF            (PORTB &= ~(1<<BUZZ_PIN))

//--- Device Setup -------------------------------------------------------
#define OUTPUT_CONFIG       (DDRB |= (1<<RED_PIN) | (1<<GREEN_PIN) | (1<<BUZZ_PIN))
#define CPU_PRESCALE(n)     (CLKPR = 0x80, CLKPR = (n))
int buzzerState = 1;

/************************************************************************/
/*                     Device function definitions                      */
/************************************************************************/

//--- Buzzer -------------------------------------------------------------
void toggleBuzz(void) {
    if (buzzerState == 1) {
        BUZZ_OFF;
        buzzerState = 0;
    } else {
        BUZZ_ON;
        buzzerState = 1;
    }
}
void buzzEnable(void) {
    char ticks = 0;
    while(1) {
        while((TIFR0 & 0x01) == 0) {} 
        TIFR0 = 1;
        ticks++;
        if (ticks == 60) {
            ticks = 0;
            toggleBuzz();
        }
    }
}

//--- LED ----------------------------------------------------------------
void LEDColor(int distance) {
    RED_OFF;
    YELLOW_OFF;
    GREEN_OFF;


    if (distance >= 3) {
        RED_ON;
    }
    else if (distance >= 2) {
        YELLOW_ON;
    }
	else {
        GREEN_ON;
        buzzEnable();
    }
}

/************************************************************************/
/*                           MAIN function                              */
/************************************************************************/

int main(void) {
    //--- Setup ----------------------------------------------------------
    int distance;
    OUTPUT_CONFIG;
    
    // Set Timer/Counter to proper speed for buzzer
    TIMSK0 = 0;
    TCCR0B = 2;

    //--- Main Loop ------------------------------------------------------
    while(1){
        distance = sonar();
        LEDColor(distance);
    }
    return 0;
}
