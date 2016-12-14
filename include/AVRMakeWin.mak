OBJS	= $(CSRCS:.c=.o) $(ASRCS:.S=.o)

ARDUINO = "C:\Program Files (x86)"/Arduino/hardware
TOOLS 	= $(ARDUINO)/tools/avr/bin

GCC	= $(TOOLS)/avr-gcc.exe
OBJCOPY	= $(TOOLS)/avr-objcopy.exe
OBJDUMP	= $(TOOLS)/avr-objdump.exe
RM	= del
DUDE	= $(TOOLS)/avrdude.exe

CFLAGS		= -mmcu=$(MCU)
CFLAGS		+= -DF_CPU=$(F_CPU)L
CFLAGS		+= $(INCLUDES)
CFLAGS		+= -Os

AFLAGS		= -mmcu=$(MCU)
AFLAGS		+= -x assembler-with-cpp
AFLAGS		+= -DF_CPU=$(F_CPU)L
AFLAGS		+= $(INCLUDES)

LFLAGS		= -v
LFLAGS		+= -p$(MCU) -carduino
LFLAGS		+= -P$(PORT)
LFLAGS		+= -b115200

DUDECNF		= -C$(ARDUINO)/tools/avr/etc/avrdude.conf
INCLUDES	= -I$(ARDUINO)/arduino/avr/cores/arduino
INCLUDES	+= -I$(ARDUINO)/arduino/avr/variants/standard

all:	$(TARGET).hex
