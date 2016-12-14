OBJS	= $(CSRCS:.c=.o) $(ASRCS:.S=.o)

ARDUINO = /Applications/Arduino.app/Contents/Java/hardware

TOOLS   = $(ARDUINO)/tools/avr/bin
GCC		= $(TOOLS)/avr-gcc 
OBJCOPY	= $(TOOLS)/avr-objcopy 
OBJDUME = $(TOOLS)/avr-objdump
RM      = rm -f 
DUDE    = $(TOOLS)/avrdude

CFLAGS      = -mmcu=$(MCU)
CFLAGS      += -DF_CPU=$(F_CPU)L
CFLAGS      += $(INCUDES)
CFLAGS      += -Os

AFLAGS		= -mmcu=$(MCU)
AFLAGS		+= -x assembler-with-cpp
AFLAGS		+= -DF_CPU=$(F_CPU)L
AFLAGS		+= $(INCLUDES)

LFLAGS		= -v
LFLAGS		+= -p$(MCU) -carduino
LFLAGS		+= -P$(PORT)
LFLAGS		+= -b115200


INCLUDES	= -I"$(ARDUINO)/arduino/avr/variants/standard"
INCLUDES	+= -I"$(ARDUINO)/tools/avr/avr/include/avr"
DUDECNF     = -C"$(ARDUINO)/tools/avr/etc/avrdude.conf"

all:	$(TARGET).hex
