#include <stdio.h>
int A[3][3] = {
    {1,1,1},
    {1,81,1},
    {47,1,1}};

int B[3][3] = {
    {17,0,1},
    {0,2,23},
    {1,0,1}};

int C[3][3] = {0};

extern void func(void*, void*, void*, int);

void printMatrix(void* m, int size) {
    printf("________________\n");
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%5d", ((int*)m)[i*size+j]);
        }
        printf("\n");
    }
}

void transpose(void* m, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < i; j++) {
            int tmp = ((int*)m)[i*size+j];
            ((int*)m)[i*size+j] = ((int*)m)[j*size + i];
            ((int*)m)[j*size + i] = tmp;
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
    transpose(B,3);

    //multiply(3);
    func(A, B, C, 3);
    transpose(C,3);
    //printMatrix(C, 3);


    return 0;
}