/*
 * Defines functions for manipulating square integer matrices.
 * CSC 225, Assignment 7
 * Given code, Fall '20
 */

#include "matrix.h"

/* matscl: Multiplies each element of a matrix by a scalar. */
void matscl(int *mat, unsigned int n, int c) {
    /* TODO: Complete this function, given:
     *  mat - A pointer to the first element in a multidimensional array
     *  n   - The height and width of the matrix
     *  c   - The constant scalar
     * ...multiply each element in "mat" by "c". */

     int row, column;
     for (row = 0; row < n; row++) {
       for (column=0; column < n; column++) {
         mat[row * n+column] = (mat[row*n+column]) * c;
       }
     }

}

/* matpscl: Multiplies each element of a matrix by a scalar. */
void matpscl(int **mat, unsigned int n, int c) {
    /* TODO: Complete this function, given:
     *  mat - An array of pointers to arrays of integers
     *  n   - The height and width of the matrix
     *  c   - The constant scalar
     * ...multiply each element in "mat" by "c". */

     int row, column;

     for (row=0; row < n; row++) {
       for (column=0; column<n; column++) {
         mat[row][column] = (mat[row][column]) * c;
       }
     }
}

/* mattrn: Transposes a matrix about its diagonal, in-place. */
void mattrn(int *mat, unsigned int n) {
    /* TODO: Complete this function, given:
     *  mat - A pointer to the first element in a multidimensional array
     *  n   - The height and width of the matrix
     * ...transpose "mat" about its diagonal. */
     int row, column, temp;

     for(row=0; row<n; row++) {
       for(column=0; column<n; column++) {
         if(row >column) {
           temp = mat[row*n + column];
           mat[row*n + column] = mat[column*n + row];
           mat[column*n + row] = temp;
         }
       }
     }
}

/* matptrn: Transposes a matrix about its diagonal, in-place. */
void matptrn(int **mat, unsigned int n) {
    /* TODO: Complete this function, given:
     *  mat - An array of pointers to arrays of integers
     *  n   - The height and width of the matrix
     * ...transpose "mat" about its diagonal. */
     int row, column, temp;

     for(row=0; row<n; row++) {
       for(column=0; column<n; column++) {
         if(row >column) {
           temp = mat[row][column];
           mat[row][column] = mat[column][row];
           mat[column][row] = temp;
         }
       }
     }
}

/* matadd: Adds two matrices, placing their sum into a third. */
void matadd(int *mata, int *matb, int *matc, unsigned int n) {
    /* TODO: Complete this function, given:
     *  mata - A pointer to the first element in a multidimensional array
     *  matb - A pointer to the first element in a multidimensional array
     *  matc - A pointer to the first element in a multidimensional array
     *  n    - The height and width of the matrices
     * ...compute "matc = mata + matb". */
     int row, column;

     for(row=0; row<n; row++) {
       for(column=0; column<n; column++) {
         matc[row*n + column] = mata[row*n + column] + matb[row*n + column];
       }
     }
}

/* matpadd: Adds two matrices, placing their sum into a third. */
void matpadd(int **mata, int **matb, int **matc, unsigned int n) {
    /* TODO: Complete this function, given:
     *  mata - An array of pointers to arrays of integers
     *  matb - An array of pointers to arrays of integers
     *  matc - An array of pointers to arrays of integers
     *  n    - The height and width of the matrices
     * ...compute "matc = mata + matb". */
     int row, column;

     for(row=0; row<n; row++) {
       for(column=0; column<n; column++) {
         matc[row][column] = mata[row][column] + matb[row][column];
       }
     }
}

/* matmul: Multiplies two matrices, placing their product into a third. */
void matmul(int *mata, int *matb, int *matc, unsigned int n) {
    /* TODO: Complete this function, given:
     *  mata - A pointer to the first element in a multidimensional array
     *  matb - A pointer to the first element in a multidimensional array
     *  matc - A pointer to the first element in a multidimensional array
     *  n    - The height and width of the matrices
     * ...compute "matc = mata * matb". */
     int row, column, dimension, sum;

     for(row=0; row<n; row++) {
       for(column=0; column<n; column++) {
         sum = 0;
         for(dimension=0; dimension<n; dimension++) {
           sum += mata[row*n + dimension] * matb[dimension*n + column];
           matc[row*n + column] = sum;
         }
       }
     }

}

/* matpmul: Multiplies two matrices, placing their product into a third. */
void matpmul(int **mata, int **matb, int **matc, unsigned int n) {
    /* TODO: Complete this function, given:
     *  mata - An array of pointers to arrays of integers
     *  matb - An array of pointers to arrays of integers
     *  matc - An array of pointers to arrays of integers
     *  n    - The height and width of the matrices
     * ...compute "matc = mata * matb". */
     int row, column, dimension, sum;

     for(row=0; row<n; row++) {
       for(column=0; column<n; column++) {
         sum = 0;
         for(dimension=0; dimension<n; dimension++) {
           sum += mata[row][dimension] * matb[dimension][column];
           matc[row][column] = sum;
         }
       }
     }
}
