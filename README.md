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

