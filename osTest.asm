mov bp, 0x8000

repeat:
    mov sp, bp

looop:
    jmp waitForKeypress

backToLoop: ;if al contains ` prints out the buffer otherwise pushes into the stack
    cmp al, 0h60
    je writeBuffer
    push ax
    jmp looop

waitForKeypress:    ;waits for keypress
    mov ah, 0
    int 0x16
    jmp backToLoop

writeBuffer:    ;writes the buffer
    mov ah, 0x0e
    cmp bp, sp
    je beforeRepeat
    mov bx, bp
    jmp writeLoop

writeLoop:  ;writes a single character from the buffer
    mov al, [bx - 2]
    int 0x10
    mov cx, 0
    mov [bx - 2], cx
    sub bx, 2
    cmp bx, sp
    je beforeRepeat
    jmp writeLoop

beforeRepeat:   ;writes enter
    mov al, 0ah
    int 0x10
    mov al, 0dh
    int 0x10
    jmp repeat

end:

jmp $

times 510-($-$$) db 0   ;magic
dw 0xAA55