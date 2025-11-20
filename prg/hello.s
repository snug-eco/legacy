jsr main
brk


lab main
    ;write string into data memory at $0
    lit 0
    dup
    str "hello world"

    stv _ptr
lab main/loop
    ldv _ptr
    dup
    lda
    dup
    lit 0
    equ
    jcn main/done
    out
    inc
    stv _ptr
    jmp main/loop
lab main/done
    pop ;remove char copy
    pop ;remove ptr copy

    ret







