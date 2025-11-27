
; read a line from the stdin, 
; while respectiving backspace,
; until enter it hit.

var _limit
var _buf
var _n


; (buf* limit)
lab line
    stv _limit
    stv _buf

    lit 0
    stv _n

lab line/loop
    inp

    ; check enter
    dup
    lit 13
    equ
    jcn line/enter

    ; check backspace
    dup
    lit 127
    equ
    jcn line/backspace

    ; check buffer bounds
    ldv _limit
    ldv _n
    equ
    jcn line/loop

    ;echo
    out
    ; append to buffer
    ldv _buf
    ldv _n
    add
    sta
    ; advance
    ldv _n
    inc
    stv _n

    jmp line/loop

lab line/backspace
    ; skip backspace if buffer empty
    ldv _n
    lit 0
    equ
    jcn line/loop

    ; key code don't care
    pop
    ; erase chracter
    lit 8
    out
    lit 32
    out
    ; backspace
    lit 8
    out

    ; preceed buffer
    ldv _n
    lit 1
    sub
    stv _n

    jmp line/loop

lab line/enter
    ; write terminator
    lit 0
    ldv _buf
    ldv _n
    add
    sta

    ret








    


    







