#Makefile for converted-group-project

TARGET	= test

CSRCS 	= $(wildcard *.c)
ASRCS	= $(wildcard *.S)
INTTBL	= FALSE

# board definition
MCU	= atmega328p
F_CPU	= 16000000

# uncomment one of these linesand check for your system:
#PORT	= COM4
#PORT	= /dev/ttyACM0
PORT	= /dev/cu.usbmodem1421

# uncomment one of these lines
MAKE_BASE = ../
#MAKE_BASE = /usr/local/
include $(MAKE_BASE)include/AVRMakefile.mak
