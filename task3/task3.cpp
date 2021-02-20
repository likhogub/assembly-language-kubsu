#include <iostream>
using namespace std;

#define bitArray unsigned long long

extern "C" void tclsr(void*, void*, int);

int main() {
    char c;
    int size;
    cout << "Size:" << endl;
    cin >> size;

    bitArray* A = new bitArray[size];
    fill(A, A+size, 0);
    bitArray* B = new bitArray[size];
    fill(B, B+size, 0);

    cout << "Adjacency matrix:" << endl;

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            cin >> c;
            c -= '0';
            A[i] <<= 1;
            A[i] += c;
            B[j] <<= 1;
            B[j] += c;
        }
    }

    tclsr(A, B, size);
    
    cout << "Result: " << endl;

    bitArray mask = 1 << size - 1;
    for (int i = 0; i < size; i++) {
        for (int j = 0 ; j < size; j++) {
            cout << ((B[j] & mask) ? 1 : 0);
        }
        cout << endl;
        mask >>= 1;
    }

    return 0;
}