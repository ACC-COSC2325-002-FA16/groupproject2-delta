;-----------------------------------------------;              
;     ASM code for the HC-SRO4 Sonar device     ;
;         Created by: The Delta Group           ; 
;-----------------------------------------------;

#include "config.inc"

	.section        .text
	.global		sonar

;-----------------------------------------------;
;               SONAR FUNCTION                  ;
;-----------------------------------------------;
sonar:
	
        sbi             _DDRD, TRIG_PIN         ; sets pin 2's direction to output => Trig Pin
        cbi             _DDRD, ECHO_PIN         ; sets pin 4's direction to input  <= Echo Pin
        cbi             _PORTD,	TRIG_PIN        ; sets the output to LOW
send:						
        sbi             _PORTD, TRIG_PIN        ; set Trig Pin to HIGH to send a burst of 8 pings
        call            tenMicroDelay           ; HIGH signal must continue for 10 microseconds
        cbi             _PORTD,	TRIG_PIN        ; set the output to LOW after pings are sent
receive:
        clr             r21                     ; clear counter value
waiting:
        call            hundredCMDelay          ; wait long enough for the sound to travel 100 cm (each way)
        inc             r21                     ; increment counter
        sbic            _PIND, ECHO_PIN		; break out of loop if response received
        rjmp            waiting                 ; otherwise keep waiting for the response
        clr		r25			; zero out high bits of return register
        mov		r24, r21                ; set lower bits to the value of counter
        call            hundredCMDelay
        ret					; return to calling function

;-----------------------------------------------;
;               DELAY FUNCTIONS                 ;
;-----------------------------------------------;
tenMicroDelay:
        ldi             r18, 2                  ; set outer loop to 2
1:
        ldi             r19, 80                 ; set inner loop to 80 (160 cycles total)
2:
        dec             r19                     ; decrement inner loop
        brne            2b                      ; keep looping until (r19 == 0)
        dec             r18                     ; decrement outer loop
        brne            1b                      ; keep looping until (r18 == 0)
        ret                                     ; return after 10 microseconds
hundredCMDelay:
        ldi             r18, 100                ; set outer loop to 100 (centimeters)
5:
        ldi             r19, 58                 ; set middle loop to 58 (microseconds per centimeter)
6:      
        ldi             r20, 16                 ; set inner loop to 16 (cycles per microsecond)
7:
        dec             r20                     ; decrement inner loop
        brne            7b                      ; keep looping until r20 == 0
        dec             r19                     ; decrement middle loop
        brne            6b                      ; keep looping until r19 == 0
        dec             r18                     ; decrement outer loop
        brne            5b                      ; keep looping until r18 == 0
        ret                                     ; return after a delay equal to 100 centimeters
