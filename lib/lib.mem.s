
; memory manipulation.
; in the likes of C.


var _n
var _src
var _dst

;(dst* src* n --)
lab mem/cpy
    stv _n
    stv _src
    stv _dst

lab mem/cpy/loop
    ;loop check
    ldv _n
    lit 0
    equ
    jcn mem/cpy/done

    ;count down
    ldv _n
    lit 1
    sub 
    stv _n

    ;read from src
    ldv _src
    dup
    inc
    stv _src
    lda

    ;write to dst
    ldv _dst
    dup
    inc
    stv _dst
    sta

    jmp mem/cpy/loop

lab mem/cpy/done
    ret


var _char

;(dst* char n -- )
lab mem/set
    stv _n
    stv _char
    stv _dst

lab mem/set/loop
    ;loop check
    ldv _n
    lit 0
    equ
    jcn mem/set/done

    ;count down
    ldv _n
    lit 1
    sub 
    stv _n

    ldv _char

    ldv _dst
    dup
    inc
    stv _dst
    sta

    jmp mem/set/loop

lab mem/set/done
    ret



