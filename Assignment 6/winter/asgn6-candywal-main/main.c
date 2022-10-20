/*
 * Recursively computes Fibonacci numbers.
 * CSC 225, Assignment 6
 * Given code, Winter '22
 * TODO: Complete this file.
 */

#include "fib.h"
#include <stdio.h>
int main(void) {


int n;
printf("Enter an integer: ");
scanf(" %i\n", &n);
printf("f(%i) = %i\n", n, fib(n));
return 0;
}
