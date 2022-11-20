#include "math.h"
#include "stdio.h"


unsigned long long factorial (unsigned long long n) {
	return (n < 2) ? 1 : n * factorial (n - 1);
}

double sin(double x) {
	int i = -1;
	unsigned long long j = 3;
	double s = x;
	double e = x;
	while (e >= 0.0005 || e <= -0.0005) {
		e = i * pow(x, j) / factorial(j);
		i = -i;
		j += 2;
		s += e;
	}
	return s;
}

int main() {
	double x;
	printf("Введите размерность угла x (в радианах): ");
	scanf("%lf", &x);
	printf("sin(x) = %.*lf\n", 23, sin(x));
}
