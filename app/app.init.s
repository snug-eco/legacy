jmp main

var _file
var _name

use lib.string.s

lab main
    ; message
    lit 0
    str "[INIT] Initializing root processes... "
    lit 0
    jsr string/print
    jsr string/newline

    ; manual memory
    lit 0
    stv _file
    lit 4
    stv _name

lab register
    ldv _name
    str "bin.shell"
    jsr init

    brk





lab init
    ldv _name
    jsr string/print
    jsr string/newline

    ldv _name
    s04 ; fs_check
    lit 0
    equ
    jcn init-done

    ldv _file
    ldv _name
    s05 ; fs_seek

    ldv _file
    s11 ; vm_launch
lab init-done
    ret






