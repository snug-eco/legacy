

var _args_iter
var _args_inited
var _arg_len
var _arg_ptr

; ( -- )
lab args/init
    ; args file iterator
    lit 4
    jsr heap/new
    stv _args_iter

    ; open args file
    lit 4    
    jsr heap/new

    ; name
    dup
    str "args"

    ; check exists
    dup
    s04 ; fs_exists
    lit 0
    equ
    jcn args/init/error

    ; seek
    dup
    ldv _args_iter
    swp
    s05 ; fs_seek

    ; clean up name
    jsr heap/void

    ; open file
    ldv _args_iter
    s06 ; fs_open


    ; loop will iterate read blocks,
    ; till unread one if found
lab args/init/loop
    ; switch flag 
    ldv _args_iter
    s02 ; disk read 
    
    ; 0x00 end of argument stream
    dup
    lit 0
    equ
    jcn args/init/done

    ; 0x01 argument not read
    dup
    lit 1
    equ
    jcn args/init/done

    ; otherwise assume argument read
    pop
    jsr args/next
    jmp args/init/loop 
    
lab args/init/done
    pop ;flag

    ; set initialized flag
    lit 1
    stv _args_inited
    ret

lab args/init/error
    lit 0
    dup
    str "args error: args file not found"
    jsr string/print
    jsr string/newline
    brk



; ( -- )
lab args/next
    ; skip flag
    ldv _args_iter
    jsr quad/inc

    ; length
    ldv _args_iter
    s02

lab args/next/loop
    ; check exit
    dup
    lit 0
    equ
    jcn args/next/done

    ; dec count
    lit 1
    sub

    ; inc iter
    ldv _args_iter
    jsr quad/inc

    jmp args/next/loop

lab args/next/done
    pop
    ret




; ( -- arg* ) HEAP
lab args/get
    ; auto initialize 
    ldv _args_inited
    jcn args/get/inited
    jsr args/init

lab args/get/inited
    
    ; check flag
    ldv _args_iter
    s02
    lit 0
    equ
    jcn args/get/bound

    ; skip flag
    ldv _args_iter
    jsr quad/inc

    ; length
    ldv _args_iter
    s02
    dup
    stv _arg_len

    ; output allocate
    inc
    jsr heap/new
    dup
    stv _arg_ptr

    ; skip length
    ldv _args_iter
    jsr quad/inc

lab args/get/loop
    ; check exit
    ldv _arg_len
    lit 0
    equ
    jcn args/get/done

    ; dec count
    ldv _arg_len
    lit 1
    sub
    stv _arg_len

    ; transit character
    ldv _args_iter
    s02
    ldv _arg_ptr 
    sta

    ; inc iter
    ldv _args_iter
    jsr quad/inc

    ; inc ptr
    ldv _arg_ptr
    inc
    stv _arg_ptr

    jmp args/get/loop

lab args/get/done
    lit 0
    ldv _arg_ptr
    sta
    ret

lab args/get/bound
    lit 0
    ret

    

