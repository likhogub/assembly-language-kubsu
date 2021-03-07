#include <iostream>
using namespace std;

extern "C" int arc1(void*, int);
extern "C" int arc2(void*, int);
extern "C" int arc3(void*, int);



int main() {
    int size;
    cin >> size;
    char c;
    int* arr = new int[size*size];
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            cin >> c;
            c -= '0';
            arr[i]<<=1;
            arr[i] += c;
        }
    }
    cout << arc3(arr, size) << endl;
    return 0;
}