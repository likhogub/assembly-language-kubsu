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
        for (int j = 0; j < (n+1); j ++) {
            cin >> c;
            F[i] <<= 1;
            F[i] += c - '0';
        }
    }

    bitArray* G = new bitArray[1 << n];

    cout << "G truth table:" << endl;
    for (int i = 0; i < (1 << n); i++) {
        for (int j = 0; j < (n+1); j ++) {
            cin >> c;
            G[i] <<= 1;
            G[i] += c - '0';
        }
    }

    bitArray* H = new bitArray[1 << (2*n-1)];

    ttable(F, G, H, n);

    cout << "F(G) truth table:" << endl;
    for (int i = 0; i < (1<<(2*n-1)); i++) {
        bitArray mask = (1<<(2*n-1));
        for (int j = 0; j < (2*n); j++) {
            cout << (((H[i] & mask) > 0) ? 1 : 0);
            mask >>= 1;
        }
        cout << endl;
    }

    return 0;
}