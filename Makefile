all: boot_sect.bin
	objdump -D boot_sect.bin -b binary -m i386 -M intel > boot_sect.list

boot_sect.bin: boot_sect.asm
	nasm boot_sect.asm -f bin -o boot_sect.bin

clean: 
	rm *.bin *.list *.o

init:
	sudo apt install nasm qemu-system qemu
