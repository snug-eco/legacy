


var _k
var _addr
var _buf
var _tmp


; ( addr* buf* n -- )
lab disk/write
    stv _k
    stv _buf
    stv _tmp

    ; copy quad word ptr
    lit 4
    jsr heap/new
    dup
    stv _addr

    ldv _tmp
    lit 4
    jsr mem/cpy

lab disk/write/loop
    ; check loop
    ldv _k
    lit 0
    equ
    jcn disk/write/done

    ;dec n
    ldv _k
    lit 1
    sub
    stv _k

    ;transfer
    ldv _buf
    lda
    ldv _addr
    swp
    s03 ; fs_write

    ; incs
    ldv _buf
    inc
    stv _buf

    ldv _addr
    s16

    jmp disk/write/loop

lab disk/write/done
    ldv _addr
    jsr heap/void

    ret



    



    


