ORG 0
BITS 16

_start:
    jmp short start
    nop

times 33 db 0 ; Reserve space for BIOS Parameter Block

start:
    jmp 0x7c0:step2 ; Set Code Segment as 0x7c0

step2:
    cli
    mov ax, 0x7c0 ; Initialize our memory segments inside critical area
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    sti
    mov si, message
    call print
    jmp $

print:
    mov bx, 0

.loop:
    lodsb
    cmp al, 0
    je .done
    call print_char
    jmp .loop

.done:
    ret

print_char:
    mov ah, 0eh
    int 0x10
    ret

message: db 'Hello World!', 0

times 510-($ - $$) db 0 ; Fill rest of the memory until byte 510 with 0s
dw 0xAA55 ; BTLD signature