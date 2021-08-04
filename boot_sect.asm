[org 0x7c00]  ;# automatically offset label references

mov ah, 0x0e  ;# int 10/ ah = 0eh -> scrolling teletype BIOS routine

mov bp, 0x8000  ;# Stack base init
mov sp, bp      ;# Stack ptr init

mov edx, help_me
call print_str
jmp $

print_str:
    mov al, [edx]
    int 0x10       ;# BIOS print interrupt
    add edx, 0x01  ;# next char addr
    mov al, [edx]  ;# read next char to check if continue
    cmp al, 0      ;# if al != \0, continue
    jne print_str
    ret            ;# else, return

help_me:
    db 'AHHHHHHHHHHHHHHHHH...', 0xd, 0xa, 0  ;# null terminated string, 0xd: carriage return, 0xa: newline

times 510-($-$$) db 0

dw 0xaa55
