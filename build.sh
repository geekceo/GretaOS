nasm -f elf32 kernel.asm -o kasm.o
echo "ELF32 file: Done"
gcc -fno-stack-protector -m32 -c kernel.c -o kc.o
echo "Compiling kernel.c: Done"
ld -m elf_i386 -T link.ld -o kernel kasm.o kc.o
echo "Executable file kernel: Done"
