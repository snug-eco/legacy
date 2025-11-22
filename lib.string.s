


;(a* -- ) IO
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



