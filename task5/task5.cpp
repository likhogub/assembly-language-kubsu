#include <iostream>
using namespace std;

extern "C" double fcalc(double);


int main() {
    double x;
    cout << "X: ";
    cin >> x;
    cout << "Result: ";
    cout << fcalc(x) << endl;
    return 0;
}