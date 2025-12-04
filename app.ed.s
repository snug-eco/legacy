jsr main
brk


use lib.mem.s
use lib.quad.s
use lib.heap.s
use lib.string.s
use lib.args.s

var _filename
var _buffer
var _iter
var _ptr
var _cursor
var _content
var _n
var _file


lab main
    ; line buffer
    lit 80
    jsr heap/new
    stv _buffer

    ; read file name argument
    jsr args/get
    stv _filename

    ; check present
    ldv _filename
    lit 0
    equ
    jcn no-file-error

    ; check file
    ldv _filename
    s04
    lit 0
    equ
    jcn file-not-exist-error

    ; open file
    ldv _file
    ldv _filename
    s05
    ldv _file
    s06

    ; cursor
    lit 0
    stv _cursor
 
lab loop
    ; read input
    lit 36
    out
    ldv _buffer
    lit 80
    jsr line

    ; first character
    ldv _buffer
    lda

    ; quit
    dup
    lit 113 ;q
    equ
    jcn command-quit

    ; goto
    dup
    lit 103 ;g
    equ
    jcn command-goto

    ; insert after
    dup
    lit 105 ;i
    equ
    jcn command-insert

    ; delete
    dup
    lit 100
    equ
    jcn command-delete

    ; change
    dup
    lit 99
    equ
    jcn command-change

    ; enumerate
    dup
    lit 110
    equ
    jcn command-enum

    ; print line
    dup
    lit 112
    equ
    jcn command-print

    pop
    jmp loop


lab command-quit
    brk


lab command-insert
    ;insert after
    ; -> pre inc
    ldv _cursor
    inc
    stv _cursor

    ; grab line
    ldv _cursor
    jsr seek-line

    ;get remaining file content size
    ldv _cursor
    jsr remaining-size
    
    ; compute content buffer
    ldv _buffer
    lit 2
    add
    stv _content

    ;get length of line
    ldv _content
    jsr string/len
    inc ; linefeed
    stv _n









    
; ( *addr -- size)
; given a pointer into a file,
; computes the size of remaining
; content in the file from the pointer onwards.
lab remaining-size


; ( n -- *ptr )
; given the line number (zero indexed),
; returns a pointer to the base address of
; the line in the _file with that number.
lab seek-line
    stv _n

    ; ptr
    lit 4
    jsr heap/new
    stv _ptr

    ; copy
    ldv _ptr
    ldv _file
    lit 4
    jsr mem/cpy

lab seek-line/loop
    ; check countdown
    ldv _n
    lit 1
    equ
    jcn seek-line/done

    ;next line
    ldv _ptr
    jsr next-line

    ; dec 
    ldv _n
    lit 1
    sub
    stv _n

    jmp seek-line/loop
lab seek-line/done
    ldv _ptr
    ret

    


; ( *ptr -- )
; advances a pointer by one line in a file,
; assuming it points to the base address of the
; preceeding line.
lab next-line
    stv _ptr

lab next-line/loop 
    ; check linefeed 
    ldv _ptr
    s02
    lit 10 ;linefeed
    equ
    jcn next-line/done
    
    ; inc ptr
    ldv _ptr
    s16

    jmp next-line/loop
lab next-line/done

    ; inc ptr
    ldv _ptr
    s16
    ret
    





; --- errors ---

lab file-not-exist-error
    lit _buffer
    str "editor error: no such file "
    lit _buffer
    jsr string/print
    ldv _filename
    jsr string/print
    jsr string/newline
    brk
    

lab no-file-error
    lit _buffer
    str "editor error: no file name provided"
    lit _buffer
    jsr string/print
    jsr string/newline
    brk












