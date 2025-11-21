
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>


// the vm segments memory into 4 areas.
// - the return stack   (256B)
// - the working stack  (128B)
// - the variable store (128B)
// - the data store     (256B)
// for a total of 768B of memory.


void usage()
{
    fprintf(stderr, "usage: vm build");
    exit(1);
}


static uint8_t prog[1000];
uint32_t prog_size;


void load_prog(char* path)
{
    FILE* f = fopen(path, "r");
    int8_t c;
    while ((c = fgetc(f)) != EOF)
        prog[prog_size++] = c;

    fclose(f);
}

uint8_t return_stack[256];
uint8_t return_index = 0;

uint8_t working_stack[256];
uint8_t working_index = 0;

uint8_t  var_store[128];
uint8_t data_store[256];

uint8_t pull()
{
    return working_stack[--working_index];
}
void push(uint8_t x)
{
    working_stack[working_index++] = x;
}


void run()
{
    uint32_t pc = 0;
    bool running = true;

    while (pc < prog_size && running)
    {
        uint8_t inst = prog[pc++];

        switch (inst)
        {
            case 0x00: running = false; break;

            case 0x01: push(pull() + 1); break;
            case 0x02: pull();
            case 0x03: {
                uint8_t a = pull();
                uint8_t b = pull();
                push(a);
                push(b);
            }; break;
            case 0x04: uint8_t x = pull(); push(x); push(x); break;
            case 0x05: push(prog[pc++]); break;
            
            case 0x06: push(pull() == pull()); break;
            case 0x07: push(pull() != pull()); break;
            case 0x08: push(pull() < pull()); break;
            case 0x09: push(pull() > pull()); break;

            case 0x0a: pc = (prog[pc++] + (prog[pc++] << 8)); break;
            case 0x0b: if (pull()) pc = (prog[pc++] + (prog[pc++] << 8)); else pc += 2; break;
            case 0x0c:
                return_stack[return_index++] = pc+2; 
                pc = (prog[pc++] + (prog[pc++] << 8)); 
                break;
            case 0x0d: pc = return_stack[--return_index]; break;

            case 0x0e: push(var_store[prog[pc++]]); break;
            case 0x0f: var_store[prog[pc++]] = pull(); break;
            case 0x10: push(data_store[pull()]); break;
            case 0x11: uint8_t val = pull(); data_store[pull()] = val; break;

            case 0x12: /*not impl'd*/ break;
            case 0x13: printf("%c", pull()); break;

            case 0x14: push(pull() + pull()); break;
            case 0x15: val = pull(); push(pull() - val); break;
            case 0x16: push(pull() * pull()); break;
            case 0x17: val = pull(); push(pull() / val); break;

            case 0x18: push(pull() & pull()); break;
            case 0x19: push(pull() | pull()); break;
            case 0x1a: push(pull() ^ pull()); break;
            case 0x1b: val = pull(); push(pull() << val); break;
            case 0x1c: val = pull(); push(pull() >> val); break;
            case 0x1d: push(~pull()); break;

            case 0x1e: printf("%d\n", pull());
            case 0x1f: {
                uint8_t addr = pull();
                for (; prog[pc]; pc++)
                    data_store[addr++] = prog[pc];
                pc++; //skip termi
            }; break;
        }
    }
}



int main(int argc, char** argv)
{
    if (argc != 2) usage();
    char* path = argv[1];

    load_prog(path);
    run();
}













