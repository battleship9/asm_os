mov bp, 0x8000
mov sp, bp

repeat:

looop:
    jmp waitForKeypress

backToLoop:
    cmp al, 0h60
    je writeBuffer
    push ax
    jmp looop

waitForKeypress:
    mov ah, 0
    int 0x16
    jmp backToLoop

writeBuffer:
    jmp writeLoop

writeLoop:
    pop ax
    mov ah, 0x0e
    int 0x10
    cmp sp, bp
    je beforeRepeat
    jmp writeLoop

beforeRepeat:
    mov al, 0ah
    int 0x10
    mov al, 0dh
    int 0x10
    jmp repeat

end:

jmp $

times 510-($-$$) db 0
db 0x55, 0xaa