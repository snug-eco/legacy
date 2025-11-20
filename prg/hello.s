jsr main
brk


lab main
    ;write string into data memory at $0
    lit 0
    dup
    stv _ptr ;store base ptr
    str "hello world" ;write string into buffer

lab main/loop
    ldv _ptr
    dup
    lda ;read char from buffer
    dup
    lit 0
    equ ;check null terminator
    jcn main/done
    out ;output char
    inc ;inc ptr
    stv _ptr
    jmp main/loop
lab main/done
    pop ;remove char copy
    pop ;remove ptr copy

    ret







