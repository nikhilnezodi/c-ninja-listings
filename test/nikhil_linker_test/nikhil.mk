#
# Copyright 2023 inpyjama.com. All Rights Reserved.
# Author: Piyush Itankar <piyush@inpyjama.com>
#

TOOLCHAIN_PREFIX ?= riscv64-unknown-elf-

OBJCOPY           = $(TOOLCHAIN_PREFIX)objcopy
LD                = $(TOOLCHAIN_PREFIX)ld
AS                = $(TOOLCHAIN_PREFIX)as
GCC               = $(TOOLCHAIN_PREFIX)gcc

all: linker_exp.s
	$(GCC)  -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tlinker_exp.ld linker_exp.s -o linker_exp.elf
	$(OBJCOPY) -O binary linker_exp.elf linker_exp.bin
	xxd -e -c 4 -g 4 linker_exp.bin

debug:
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernel linker_exp.elf -gdb tcp::1234

gdb:
	gdb-multiarch linker_exp.elf -ex "target remote localhost:1234" -ex "break _start" -ex "continue" -q

.PHONY: clean
clean:
	rm -rf *.o *.elf *.bin *.out .gdb_history
