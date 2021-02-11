#include <stdio.h>
#include <malloc.h>
#define bitArray unsigned long long int

extern void func(void*, void*, void*, int size);


int A[3][3] = {
    {1,0,0},
    {0,0,1},
    {0,1,1}};

int B[3][3] = {
    {0,0,0},
    {0,0,0},
    {0,0,0}};

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
            newArr[i*size + j] = tmp % 2;
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

void printBitarray(bitArray* target, int size) {
    for (int i = 0; i < size; i++) {
        bitArray tmp = target[i];
        for (int j = 0; j < size; j++) {
            printf("%lld", tmp%2);
            tmp >>= 1;
        }
        printf("\n");
    }
    printf("-------------------\n");
} 

printArray(int* target, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d", target[i*size + j]);
        }
        printf("\n");
    }
}

int main() {
    bitArray* a = toBitArray(A, 3);
    bitArray* b = toBitArray(B, 3);
    bitArray* c = getEmptyBitArray(3);


    printBitarray(a, 3);
    //printBitarray(b, 3);

    func(a, a, c, 3);

    printBitarray(c, 3);
    printArray(toArray(c, 3), 3);

    return 0;
}