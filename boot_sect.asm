[org 0x7c00]  ; automatically offset label references

; CONSTANTS
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f


; INIT
mov ah, 0x0e  ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

mov bp, 0x8000  ; Stack base init
mov sp, bp      ; Stack ptr init

mov edx, init_msg
call _BIOS_print_str
jmp $

; BIOS PRINT
_BIOS_print_str:
    mov al, [edx]
    int 0x10       ; BIOS print interrupt
    add edx, 0x01  ; next char addr
    mov al, [edx]  ; read next char to check if continue
    cmp al, 0      ; if al != \0, continue
    jne print_str
    ret            ; else, return





[bits 64]
print_str:
    pushadd
    mov ebx, VIDEO_MEMORY  ; ptr to mem target
    mov ah, WHITE_ON_BLACK ; set byte for metadata
    print_str_loop:
        mov al, [rdx]     ; store first char
        cmp al, 0         ; if al (next char) == \0, break loop
        je print_str_done ; return
        add rdx, 0x01     ; next char addr
        add rbx, 0x02     ; next vid mem addr 
    print_str_done:
        popadd
        ret 



init_msg:
    db 'Initializing....', 0xd, 0xa, 0  ; null terminated string, 0xd: carriage return, 0xa: newline

times 510-($-$$) db 0

dw 0xaa55
