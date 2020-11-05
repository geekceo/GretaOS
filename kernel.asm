bits 32                         ;работа в 32-битном режиме
section .text                   ;секция кода
        ;multiboot spec
        align 4
        dd 0x1BADB002            ;magic
        dd 0x00                  ;flags
        dd - (0x1BADB002 + 0x00) ;checksum

global start                    ;объявляет символы кода глобальными
global keyboard_handler
global read_port
global write_port
global load_idt

extern kmain                    ;вызывает функцию из ядра kernel.c
extern keyboard_handler_main

read_port:
	mov edx, [esp + 4]          ;al is the lower 8 bits of eax
	in al, dx	                ;dx is the lower 16 bits of edx
	ret

write_port:
	mov   edx, [esp + 4]    
	mov   al, [esp + 4 + 4]  
	out   dx, al  
	ret

load_idt:
	mov edx, [esp + 4]
	lidt [edx]
	sti 				        ;turn on interrupts
	ret

keyboard_handler:                 
	call    keyboard_handler_main
	iretd

turn_off:
    mov   ax,5307h
    mov   bx,1
    mov   cx,3
    int   15h

start:                          ;функция запуска ядра
  cli                           ;запрещаем прерывания процессора
  mov esp, stack_space          ;перемещаем указатель в начало секции .bss
  call kmain                    ;вызываем функцию kmain() из kernel.c
  hlt                           ;"останавливаем" работу процессора


section .bss                    ;секция неициализированных переменных
resb 8192                       ;резервируем 8192 байт памяти
stack_space:                    ;