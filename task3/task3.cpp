#include <iostream>
#define bitArray unsigned long long

extern "C" bitArray ttable(void*, void*, void*, int);

using namespace std;

int main() {
 /*   
    char c;
    int n;
    cout << "N:" << endl;
    cin >> n;

    bitArray* F = new bitArray[1 << n];
    //fill(F, F + (1 << n), 0);
    cout << "F truth table:" << endl;
    for (int i = 0; i < (1 << n); i++) {
        for (int j = 0; j < (n+1); j ++) {
            cin >> c;
            F[i] <<= 1;
            F[i] += c - '0';
        }
    }

    bitArray* G = new bitArray[1 << n];
    //fill(G, G + (1 << n), 0);
    cout << "G truth table:" << endl;
    for (int i = 0; i < (1 << n); i++) {
        for (int j = 0; j < (n+1); j ++) {
            cin >> c;
            G[i] <<= 1;
            G[i] += c - '0';
        }
    }

    bitArray* H = new bitArray[1 << 2*n];
    //fill(H, H + (1 << 2*n), 0);

*/
    cout << ttable(0, 0, 0, 18);

    return 0;
}