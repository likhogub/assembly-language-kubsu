#include <stdio.h>

char B[3][3] = {
    {1,0,0},
    {0,1,0},
    {0,0,1}};

char A[3][3] = {
    {0,2,2},
    {3,7,5},
    {1,7,3}};


char C[3][3] = {0};

extern void func(void*, void*, void*, int);

void printMatrix(void* m, int size) {
    printf("________________\n");
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%7d", ((char*)m)[i*size+j]);
        }
        printf("\n");
    }
}

void transpose(void* m, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < i; j++) {
            char tmp = ((char*)m)[i*size+j];
            ((char*)m)[i*size+j] = ((char*)m)[j*size + i];
            ((char*)m)[j*size + i] = tmp;
        }
    }
}

void multiply( int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            C[i][j] = 0;
            for (int k = 0; k < size; k++) {
                C[i][j] += A[j][k]*B[i][k];
            }
        }
    }
}

int main() {
    transpose(B, 3);
    //printMatrix(A, 3);
    //multiply(3);
    func(A, B, C, 3);
    transpose(C, 3);
    printMatrix((void*)C, 3);
    //transpose(C,3);
    //printMatrix(C, 3);


    return 0;
}