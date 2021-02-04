//puts first command line argument as integer to RDI register
#include <stdio.h>

extern void func(int f);

int main(int argc, char* argv[]) {
    int arg = atoi(argv[1]);
    func(arg);
    return 0;
}