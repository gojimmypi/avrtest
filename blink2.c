/*
Blink
Turns on an LED at pin PB5 on for one second, then off for one second, repeatedly.

by Fernando Gil
*/

#define F_CPU 8000000UL // Clock Speed
#include <avr/io.h>
#include <util/delay.h>
#define LED_PIN PB5

void delayms(uint16_t millis) {
    while ( millis ) {
        _delay_ms(1);
        millis--;
    }
}

int main(void)
{
    DDRB |= 1LED_PIN; /* set LED_PIN to output */

    while(1)
    {
        PORTB |= 1LED_PIN; /* 1 - LED ON */
    delayms(1000);
    PORTB &= ~(1LED_PIN); /* 0 - LED OFF */
    delayms(1000);
    }
    return 0;
}

