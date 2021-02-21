#include <iostream>
using namespace std;

extern "C" double fcalc(double);


int main() {
    cout << fcalc(3) << endl;
    
    return 0;
}