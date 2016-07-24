#!/bin/bash
#
# see also https://balau82.wordpress.com/2011/03/29/programming-arduino-uno-in-pure-c/
#          http://dangerousprototypes.com/forum/viewtopic.php?t=1691
#
# tools expected to be installed: /usr/lib/avr/include/avr/avr-gcc
#

# takes the C source file and compiles it into an object file
avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o blink.o blink.c

# links the object file together with system libraries (that are linked implicitly as needed) into an ELF program
avr-gcc -mmcu=atmega328p blink.o -o blink

# converts the ELF program into an IHEX file
avr-objcopy -vv -O ihex -R .eeprom blink blink.hex

#
# Note to use buspirate to program Arduino Uno, the ICSP pins need special attention
#
# Bus Pirate    Arduino 6   Ardunio 10
# ----------    ----------  ----------
#   1    GND     6  GND     10  GND
#   2    3V3         -           -
#   3    5V      2  VCC      2  VCC
#   4    ADC         -           -
#   5    Vpu         -           -
#   6    AUX         -           -
#   7  CLK/RTS   3  SCK      7  SCK
#   8  MOSI/TX   4  MOSI     1  MOSI
#   9  CS/TMS    5  RST      5  RST
#  10  MISO/RX   1  MISO     9  MISO

sudo avrdude -v -c buspirate -p ATMEGA328P -P /dev/ttyUSB0 -b 115200 -U flash:w:blink.hex

