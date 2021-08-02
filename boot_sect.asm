[org 0x7c00]  ;# automatically offset label references

mov ah, 0x0e  ;# int 10/ ah = 0eh -> scrolling teletype BIOS routine

mov bp, 0x8000  ;# Stack base init
mov sp, bp      ;# Stack ptr init
push help_me
pop bx

print_str:
    mov al, [bx]
    int 0x10
    add bx, 0x01  ;# next char
    cmp al, 0x00  ;# if al != 0, continue
    jne print_str
    ret

help_me:
    db 'AHHHHHHHHHHHHHHHHH', 0

times 510-($-$$) db 0

dw 0xaa55
