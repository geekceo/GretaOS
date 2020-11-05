bits 32                         ;работа в 32-битном режиме
section .text                   ;секция кода
        ;multiboot spec
        align 4
        dd 0x1BADB002            ;magic
        dd 0x00                  ;flags
        dd - (0x1BADB002 + 0x00) ;checksum

global start                    ;объявляет символы кода глобальными
extern kmain                    ;вызывает функцию из ядра kernel.c

start:                          ;функция запуска ядра
  cli                           ;запрещаем прерывания процессора
  mov esp, stack_space          ;перемещаем указатель в начало секции .bss
  call kmain                    ;вызываем функцию kmain() из kernel.c
  hlt                           ;"останавливаем" работу процессора

section .bss                    ;секция неициализированных переменных
resb 8192                       ;резервируем 8192 байт памяти
stack_space:                    ;