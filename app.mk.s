jsr main
brk


use lib.quad.s
use lib.mem.s
use lib.heap.s
use lib.string.s
use lib.args.s

var _name
var _size_int
var _size_str

lab main
    jsr args/get
    stv _name

    jsr args/get
    stv _size_str

    ; check name given
    ldv _name
    lit 0
    equ
    jcn usage

    ; check size given
    ldv _size_str
    lit 0
    equ
    jcn usage

    ;convert
    ldv _size_str
    jsr string/to-int
    stv _size_int


    lit 4  
    jsr heap/new
    
    dup
    ldv _name
    ldv _size_int
    s08 ; fs_create

    jsr heap/void
    brk


lab usage
    lit 0
    str "usage: mk filename size"
    lit 0
    jsr string/print
    jsr string/newline
    brk





