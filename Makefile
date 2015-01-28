CFLAGS = -O2 -g3
ASFLAGS = -g

use-coop: use-coop.o coop.o

use-coop.o: use-coop.c
use-coop.s: use-coop.c
	$(CC) $(CFLAGS) -S -o $@ $<

coop.o: coop.s
	$(AS) $(ASFLAGS) $< -o $@

