
; read a line from the stdin, 
; while respectiving backspace,
; until enter it hit.

var _limit
var _buf
var _n


; (buf* limit)
lab line-resume
    stv _limit
    stv _buf

    ; print buffer
    ldv _buf
    jsr string/print

    ; read edit index from buffer
    ldv _buf
    jsr string/len
    stv _n

    jmp line/loop

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

    ; translate tabs
    dup
    lit 9
    equ
    jcn line/tab

    ; filter control characters
    dup
    lit 32
    lth
    jcn line/control


    ; check buffer bounds
    ldv _limit
    ldv _n
    equ
    jcn line/bound

    jsr line/type
    jmp line/loop

; skip control characters
lab line/control
    pop
    jmp line/loop

lab line/bound
    pop
    jmp line/loop

lab line/tab
    pop

    ; one tab -> four spaces
    lit 32
    lit 32
    lit 32
    lit 32

    jsr line/type
    jsr line/type
    jsr line/type
    jsr line/type

    jmp line/loop


; ( char -- )
lab line/type
    ;echo
    dup
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
    ret


lab line/backspace
    ; key code don't care
    pop

    ; skip backspace if buffer empty
    ldv _n
    lit 0
    equ
    jcn line/loop

    ; erase character
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
    ; key code don't care
    pop
    ; send lfcr
    lit 10
    out
    lit 13
    out
    ; write terminator
    lit 0
    ldv _buf
    ldv _n
    add
    sta

    ret

