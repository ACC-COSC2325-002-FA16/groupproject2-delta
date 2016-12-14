OBJS	= $(CSRCS:.c=.o) $(ASRCS:.S=.o)

ARDUINO	= /usr/share/arduino
TOOLS	= $(ARDUINO)/hardware/tools/avr/bin
GCC	= $(TOOLS)/avr-gcc 
OBJCOPY	= $(TOOLS)/avr-objcopy 
OBJDUMP = $(TOOLS)/avr-objdump
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


BASEDIR		= $(ARDUINO)/hardware
INCLUDES	= -I"$(BASEDIR)/arduino/avr/variants/standard"
INCLUDES	+= -I"$(BASEDIR)/tools/avr/avr/include/avr"
DUDECNF     	= -C"$(BASEDIR)/tools/avrdude.conf"

all:	$(TARGET).hex
