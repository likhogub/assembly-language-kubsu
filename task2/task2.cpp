#include <iostream>
using namespace std;
#define bitArray unsigned long long

extern "C" void imgmir(void*, void*, int, int);


int main() {
    int H, W;
    cout << "H:"<< endl;
    cin >> H;
    cout << "W:"<< endl;
    cin >> W;

    bitArray* img = new bitArray[H*W];
    
    char c;
    for (int h = 0; h < H; h++) {
        for (int w = 0; w < W; w++) {
            cin >> c;
            c -= '0';
            img[h] <<= 1;
            img[h] += c;
        }
    }
    
    bitArray* mir = new bitArray[H*W];

    imgmir(img, mir, H, W);
    
    cout << "Result:" << endl;

    for (int h = 0; h < H; h++) {
        bitArray mask = (1<<(W-1));
        for (int w = 0; w < W; w++) {
            cout << (((mir[h] & mask) > 0) ? 1 : 0);
            mask >>= 1;
        }
        cout << endl;
    }

    return 0;
}