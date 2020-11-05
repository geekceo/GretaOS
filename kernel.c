#define VID_ADDR 0xB8000

void kmain(void)
{
    const char *str = "Greta Operating System. Version 0.1"; //строка вывода
    char *vidptr = (char*)VID_ADDR; //ставим указатель на адрес 0x8000 - начало видеопамяти(25 строк по 80 символов ASCII)
                                    //каждый символ по 16 бит(2 байта), первый байт - код символа, второй байт - формат символа(например, цвет)
    unsigned int i = 0;
    unsigned int j = 0;

    while(j < 80 * 25 * 2) {  //цикл очистки экрана
        vidptr[j] = ' ';      //пустые символы
        vidptr[j+1] = 0x07;   //с атрибутом 0x07 - светло-серый цвет     
        j = j + 2;
    }

    j = 0;

    while(str[j] != '\0') {   //вывод строки str посимвольно
        vidptr[i] = str[j];   //первый байт на символ
        vidptr[i+1] = 0x07;   //второй байт на атрибут цвета
        ++j;                  
        i = i + 2;
    }
    return;
}

void input()
{


    return;
}