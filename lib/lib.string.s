


; (a* -- ) IO
lab string/print
lab string/print/loop
    dup
    lda
    dup
    lit 0
    equ
    jcn string/print/done
    out
    inc
    jmp string/print/loop

lab string/print/done
    pop
    pop

    ret

; ( -- ) IO
lab string/newline
    lit 10
    out
    lit 13
    out
    ret


; (*a -- len)
lab string/len
    dup

lab string/len/loop
    dup
    lda
    lit 0
    equ
    jcn string/len/done

    inc
    jmp string/len/loop

lab string/len/done
    swp
    sub
    ret




var _delim

; (str* delim -- sub* str*)
lab string/token
    stv _delim

    ; find start of string
lab string/token/start-loop
    dup
    lda
    lit 0
    equ
    jcn string/token/start-cancel

    dup
    lda
    ldv _delim
    equ 
    jcn string/token/start-again

lab string/token/start-cancel
    dup ;substring
lab string/token/end-loop
    dup
    lda
    lit 0
    equ
    jcn string/token/end-cancel

    dup
    lda
    ldv _delim
    neq 
    jcn string/token/end-again


    ; write substring terminator
    dup
    lit 0
    swp
    sta
    inc

    ;already written
lab string/token/end-cancel
    ; done
    swp
    ret


lab string/token/start-again
    inc
    jmp string/token/start-loop
    
lab string/token/end-again
    inc 
    jmp string/token/end-loop



var _total

; ( *str -- int )
lab string/to-int
    lit 0 
    stv _total
lab string/to-int/loop
    dup
    lda

    ; check termi
    dup
    lit 0
    equ
    jcn string/to-int/done

    ; conv
    lit 48
    sub
    ldv _total
    lit 10
    mul
    add
    stv _total

    inc
    jmp string/to-int/loop

lab string/to-int/done
    pop
    ldv _total
    ret
    



var _digits
var _str

; ( int -- str* )
lab string/from-int
    dup
    stv _total

    dup
    lit 0
    equ
    jcn string/from-int/zero

    lit 0
    stv _digits

    ; count the number of digits
lab string/from-int/digit-loop
    ; check zero
    dup
    lit 0
    equ
    jcn string/from-int/digit-done

    ; next place value
    lit 10
    div

    ; count digit
    ldv _digits
    inc
    stv _digits

    jmp string/from-int/digit-loop

lab string/from-int/digit-done
    pop

    ; allocate string
    ldv _digits
    inc
    jsr heap/new
    dup
    
    ; compute send of string
    ldv _digits
    add
    lit 1
    sub
    stv _str

lab string/from-int/loop
    ; check zero
    ldv _total
    lit 0
    equ
    jcn string/from-int/done

    ; digit extration
    ldv _total
    dup
    lit 10
    div
    dup
    stv _total
    lit 10
    mul
    sub

    ; convert
    lit 48
    add

    ; write into string
    ldv _str
    sta

    ; inc ptr
    ldv _str
    lit 1
    sub
    stv _str

    jmp string/from-int/loop

lab string/from-int/done
    ret

lab string/from-int/zero
    pop
    
    lit 2
    jsr heap/new
    dup
    str "0"
    ret



    

; ( int -- ) IO
lab string/print-int
    ; 100s place
    dup
    lit 100
    div
        dup
        lit 48
        add
        out
    lit 100
    mul
    sub

    ; 10s place
    dup
    lit 10
    div
        dup
        lit 48
        add
        out
    lit 10
    mul
    sub

    ; 1s place
    lit 48
    add
    out

    ret




