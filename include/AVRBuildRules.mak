# standard build rules for all platforms

%.hex:  %.elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

%.elf:  $(OBJS)
	$(GCC) -w -Os -mmcu=$(MCU) -o $@ $^ -lm

%.o:    %.c
	$(GCC) -c $(CFLAGS) $< -o $@

%.o:    %.S
	$(GCC) -c $(AFLAGS) $< -o $@

load:   $(TARGET).hex
	$(DUDE) $(DUDECNF) $(LFLAGS) -Uflash:w:$(TARGET).hex:i

%.lst:   %.elf
	$(OBJDUMP) -d $< > $@

clean:
	$(RM) *.o *.hex *.eep *.elf *.map *.lst

