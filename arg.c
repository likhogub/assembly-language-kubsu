//puts 0-3 argument as integer to RDI, RSI,  register
#include <stdio.h>

extern void func(int, int, int);

int main(int argc, char* argv[]) {
    int arg1 = (argc > 1) ? atoi(argv[1]) : 0;
    int arg2 = (argc > 2) ? atoi(argv[2]) : 0;
    int arg3 = (argc > 3) ? atoi(argv[3]) : 0;
    func(arg1, arg2, arg3);
    return 0;
}