#include <iostream>
using namespace std;

extern "C" double fcalc(double);


int main() {
    cout << fcalc(38) << endl;
    
    return 0;
}