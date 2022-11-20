# ACS_IHW3
# АВС ИДЗ№3 ВАРИАНТ№7
Дюгай Андрей Владимирович БПИ216

7. Разработать программу, вычисляющую с помощью степенного ряда
с точностью не хуже 0,05% значение функции sin (x) для заданного
параметра x.

tests.md - файл с тестами (входные данные и ожидаемый результат)

Ход работы:

т.к. sin может быть от -1 до 1, точности 0.01 * 0.05 = 0,0005 хватит для всех случаев.

когда элемент степенного ряда < 0.0005 программа будет считать, что значение уже достаточно точное и завершит свои вычисления, выведет результат.


1) Программа на С (hw3.c)

2) Программа на ассемблере (hw3.s) с использованием флагов gcc -masm=intel \
    -fno-asynchronous-unwind-tables \
    -fno-jump-tables \
    -fno-stack-protector \
    -fno-exceptions \
    ./hw3.c -S hw3.s
    
И вручную убраны следующие строки:

    .file	"hw3.c"
    	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
        0:
            .string	"GNU"
        1:
            .align 8
            .long	0xc0000002
            .long	3f - 2f
        2:
            .long	0x3
        3:
            .align 8
        4:

3) Результат компиляции hw3.s (s1.out) и hw3.c (c.out)

4) Тестирование c.out и s1.out (в файле tests.md). Результаты совпали

5) Добавлены комментарии в программу на ассемблере (hw1withcomments.s) и убраны "endbr64" и строки

		.size	factorial, .-factorial
		.size	sin, .-sin
		.size	main, .-main
		.section	.rodata
		.section	.rodata

6) Результат компиляции hw3withcomments.s (s2.out) 

7) Тестирование s2.out (в файле tests.md). Результаты совпали

8) Изменение кода для максимального использовния регистров (hw3registers.s):
