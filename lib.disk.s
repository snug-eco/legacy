


var _n
var _src
var _dst


; ( dst* src* n -- )
lab disk/copy
    stv _n
    stv _src
    stv _dst

lab disk/copy/loop
    ; countdown
    ldv _n
    lit 0
    equ
    jcn disk/copy/done

    ; read
    ldv _src
    s02

    ; write
    ldv _dst
    swp
    s03

    ;inc
    ldv _src
    s16
    ldv _dst
    s16

    ;dec
    ldv _n
    lit 1
    sub
    stv _n

    jmp disk/copy/loop
lab disk/copy/done
    ret

    
    






; ( dst* src* n -- )
lab disk/rcopy
    stv _n
    stv _src
    stv _dst

    ldv _src
    ldv _n
    s18 ; quad/advance

    ldv _dst
    ldv _n
    s18 ; quad/advance

lab disk/rcopy/loop
    ; countdown
    ldv _n
    lit 0
    equ
    jcn disk/rcopy/done

    ; read
    ldv _src
    s02

    ; write
    ldv _dst
    swp
    s03

    ;dec
    ldv _src
    s19
    ldv _dst
    s19

    ;dec
    ldv _n
    lit 1
    sub
    stv _n

    jmp disk/rcopy/loop
lab disk/rcopy/done
    ret
