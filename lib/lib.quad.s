
; quad from quadrus (lat. square, four-sided).
; "let them be four, four bytes as one 32-bit word"
;   so they spoke and so it was.




; (a* -- ) IO
lab quad/print
    jsr quad/print/do
    jsr quad/print/do
    jsr quad/print/do
    jsr quad/print/do

    pop
    ret

lab quad/print/do
    dup
    lda
    dbg
    inc
    ret




var _a
var _b

; (a* b* -- bool)
lab quad/comp
lab quad/compare
    stv _b
    stv _a
    
    jsr quad/comp/do
    jcn quad/comp/bad
    jsr quad/comp/do
    jcn quad/comp/bad
    jsr quad/comp/do
    jcn quad/comp/bad
    jsr quad/comp/do
    jcn quad/comp/bad

    lit 1
    ret

lab quad/comp/bad
    lit 0
    ret

lab quad/comp/do
    ldv _a
    dup
    inc
    stv _a
    lda

    ldv _b
    dup
    inc
    stv _b
    lda

    neq ;not equal -> bad
    ret


; (a*)
lab quad/inc
lab quad/increment
    stv _a

    jsr quad/inc/do
    jcn quad/inc/done
    jsr quad/inc/do
    jcn quad/inc/done
    jsr quad/inc/do
    jcn quad/inc/done
    jsr quad/inc/do
    jcn quad/inc/done

lab quad/inc/done
    ret

lab quad/inc/do
    ;grab byte address
    ldv _a
    dup
    inc
    stv _a

    ;inc byte
    dup 
    dup
    lda
    inc
    swp
    sta

    ;compare
    lda
    lit 0
    neq
    ret



