ORG 0x7c00
BITS 16

message: db 'Hello World!', 0

jmp _init

_init:
    mov si, message
    mov ah, 0eh
    call _loop
    jmp $

_loop:
    lodsb
    cmp al, 0
    je _done
    int 10h
    jmp _loop

_done:
    ret

ret

times 510-($ - $$) db 0
dw 0xAA55