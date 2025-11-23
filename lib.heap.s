
; in the begining there was memory.
; and the memory was uniform and of no structure.
; the programs roam over the face of the memory,
; confused in their ways and disorganized.
; so the creator said:
; "how can there be no structure in the memory,
;  if structure is inherent to it? 
;  hence, let there be chunks.
;  and each chunk shall be known by its first word,
;  which tells its length."
; and so it was how they said. and it was good.

var _heap_origin
var _size
var _walker
var _trial

; (origin -- )
lab heap/set_origin
    stv _heap_origin
    ret


; (size -- chunk*)
lab heap/new
    ; the requested sized only refers to the content of the chunk.
    ; so the true size of the chunk is computed by adding one,
    ; for the size header.
    inc
    stv _size

    ; *collars and leashes you* let's go for walkies~
    ldv _heap_origin
    stv _walker

    ldv _size
    stv _trial

lab heap/new/loop
    ; check trial done.
    ldv _trial 
    lit 0
    equ
    jcn heap/new/done

    ; check must restart.
    ; restart if not enough space.
    ldv _walker
    lda
    lit 0
    neq
    jcn heap/new/restart

    ; advance trial
    ldv _walker
    inc
    stv _walker

    ldv _trial
    lit 1
    sub
    stv _trial

    jmp heap/new/loop

lab heap/new/restart
    ; the walker must now stand on header of a chunk.
    ; the chunk can therefore be skipped by add its size to the walkers position.

    ldv _walker
    dup
    lda
    add
    stv _walker

    ; restart trial
    ldv _size
    stv _trial

    jmp heap/new/loop

lab heap/new/done
    ; now a chunk of requested size has been walked.
    ; its base address is computed.
    ldv _walker
    ldv _size
    sub

    ; bring chunk into existance by writing its header.
    ; PER DEI VIM, EX NIHILO AD ORDINEM
    dup
    ldv _size
    swp
    sta

    ; chunk content address
    inc
    ret



; (*chunk -- )
lab heap/void
    dup
    lda
    lit 0
    swp
    jsr mem/set
    ret








    





