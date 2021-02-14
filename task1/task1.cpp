#include <iostream>
using namespace std;

extern "C" int nxtprm(int);

int main() {
    int n;
    cin >> n;
    cout << nxtprm(n) << endl; 
    return 0;
}