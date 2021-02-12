#include <stdio.h>
#include <malloc.h>
#include "string.h"
#define bitArray unsigned long long int

extern void func(void*, void*, void*, int size);

#define SIZE 4
int A[SIZE*SIZE] = {
    0, 0, 0, 0,
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0};

int* transposeArray(int* target, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < i; j++) {
            int tmp = target[i*size+j];
            target[i*size+j] = target[j*size + i];
            target[j*size + i] = tmp;
        }
    }
    return target;
}

bitArray* getEmptyBitArray(int size) {
    bitArray* newArr = (bitArray*)malloc(sizeof(bitArray)*size);
    for (int i = 0; i < size; i++) {
        newArr[i] = 0;
    }
    return newArr;
}

int* toArray(bitArray* target, int size) {
    int* newArr = (int*)malloc(sizeof(int)*size*size);
    for (int i = 0; i < size; i++) {
        bitArray tmp = target[i];
        for (int j = 0; j < size; j++) {
            newArr[i*size + size - j - 1] = tmp % 2;
            tmp >>= 1;
        }
    }
    return newArr;
}

bitArray* toBitArray(int* target, int size) {
    bitArray* newArr = getEmptyBitArray(size);
    for (int i = 0 ; i < size; i++) {
        newArr[i] = 0;
        for (int j = 0; j < size; j++) {
            newArr[i] <<= 1;
            if (target[i*size + j]) 
                newArr[i] += 1;
        }
    }
    return newArr;
}


void printBitarray(bitArray* target, int size, const char * msg) {
    printf("----------%s---------\n", msg);
    for (int i = 0; i < size; i++) {
        bitArray tmp = target[i];
        for (int j = 0; j < size; j++) {
            printf("%lld", tmp%2);
            tmp >>= 1;
        }
        printf("\n");
    }
} 



void printArray(int* target, int size) {
    printf("-------------------\n");
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d", target[i*size + j]);
        }
        printf("\n");
    }
}



bitArray* transposeBitArray(bitArray* target, int size) {
    return toBitArray(transposeArray(toArray(target, size), size), size);
}

int main() {
    bitArray* a = toBitArray(A, SIZE);
    bitArray* b = transposeBitArray(a, SIZE);

//    bitArray* b = toBitArray(B, SIZE);


    for (int i = 0; i < 4; i++) {
        bitArray* c = getEmptyBitArray(SIZE);
        //printBitarray(a, SIZE, "A");
        printArray(toArray(a, SIZE), SIZE);
        //printBitarray(b, SIZE, "B");
        printArray(toArray(b, SIZE), SIZE);
        //c = toBitArray(toArray(b, SIZE),SIZE);
        func(a, b, b, SIZE);

        //b = c;
        //printBitarray(b, SIZE, "Result");
        printArray(transposeArray(toArray(b, SIZE), SIZE), SIZE);

    }

    return 0;
}