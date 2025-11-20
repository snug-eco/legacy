
#include <stdio.h>
#include <stdlib.h>

void error(char* msg)
{
    fprintf(stderr, "error: %s\n", msg);
    exit(1);
}

void usage()
{
    fprintf(stderr, "usage: asm source.s");
    exit(1);
}




int main(int argc, char** argv)
{
    if (argc != 2) usage();
    char* path = argv[1];

    printf("path: %s\n", path);


    return 0;
}



