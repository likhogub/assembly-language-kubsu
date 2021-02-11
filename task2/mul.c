void multiply(int* A, int* B, int* C, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            C[i*size + j] = 0;
            for (int k = 0; k < size; k++) {
                C[i*size + j] += A[j*size + k]*B[i*size + k];
            }
        }
    }
}

int main(){
    multiply(0, 0, 0, 0);
    return 0;
}