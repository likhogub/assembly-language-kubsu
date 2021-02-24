#include <iostream>
#define bitArray unsigned long long

extern "C" bitArray ttable(void*, void*, void*, int);

using namespace std;

int main() {
    char c;
    int n;
    cout << "N:" << endl;
    cin >> n;

    bitArray* F = new bitArray[1 << n];

    cout << "F truth table:" << endl;
    for (int i = 0; i < (1 << n); i++) {
        cin >> c;
        F[i] <<= 1;
        F[i] += c - '0';
    }

    bitArray* G = new bitArray[1 << n];

    cout << "G truth table:" << endl;
    for (int i = 0; i < (1 << n); i++) {
        cin >> c;
        G[i] <<= 1;
        G[i] += c - '0';
    }

    bitArray* H = new bitArray[1 << (2*n-1)];

    ttable(F, G, H, n);

    cout << "F(G) truth table:" << endl;
    for (int i = 0; i < (1<<(2*n-1)); i++) {
        cout << (H[i]%2);
    }
    cout << endl;
    return 0;
}