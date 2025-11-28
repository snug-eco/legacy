jsr main
brk


use lib.quad.s
use lib.mem.s
use lib.heap.s
use lib.string.s
use lib.line.s

var _buffer
var _iter
var _exec
var _argument


lab args-not-exist-error
    lit 0
    str "[PANIC] Shell Error: args file does not exist."
    lit 0
    jsr string/print
    jsr string/newline
    brk


lab main
    ;line buffer
    lit 128
    jsr heap/new
    stv _buffer

    ; print startup message
    ldv _buffer
    str "--- Snug Shell ---"

    ldv _buffer
    jsr string/print
    jsr string/newline

    ; open args file
    ldv _buffer 
    str "args"
    
    ldv _buffer
    s04
    lit 0
    equ
    jcn args-not-exist-error

    lit 4
    jsr heap/new
    stv _iter

    ldv _iter
    ldv _buffer
    s05 ;seek file

    ldv _iter
    s06 ;open file iterator


lab loop
    ; prompt
    lit 62
    out
    lit 32
    out

    ; user interact 
    ldv _buffer
    lit 80
    jsr line

    ; parse exec
    ldv _buffer
    lit 32
    jsr string/token
    dup
    stv _exec
    lda
    lit 0 
    equ
    jcn loop

lab args-loop
    ; tokenize next arg and bounds check
    lit 32
    jsr string/token
    dup
    stv _argument
    lda
    lit 0
    equ
    jcn args-done

    ldv _argument
    jsr string/print
    jsr string/newline

    ;flag
    ldv _iter
    lit 1
    s03 ;disk write
    ldv _iter
    jsr quad/inc

    ; length prefix
    ldv _iter
    ldv _argument
    jsr string/len
    s03 ;disk write
    ldv _iter
    jsr quad/inc

lab arg-write-loop
    ;check
    ldv _argument    
    lda
    lit 0
    equ
    jcn args-loop

    ldv _iter
    ldv _argument
    lda
    s03 ;disk write
    
    ldv _iter
    jsr quad/inc

    ldv _argument
    inc
    stv _argument
    jmp arg-write-loop


lab args-done


    ret
    
    




