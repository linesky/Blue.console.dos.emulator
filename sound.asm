[bits 16]
org 0h
host_exe_header:
.signature1: db "MZ"     ; the 'MZ' characters                                   0x00

.last_page_size: dw 1   ; number of used bytes in the final file page, 0 for all 2
.page_count: dw 1       ; number of file pages including any last partial page   4
.reloc: dw 0            ; number of relocation entries after the header          6
.paragraphs: dw 0       ; size of header + relocation table, in paragraphs       8
.minalloc: dw 0         ; minimum required additional memory, in paragraphs      a
.maxalloc: dw 0xFFFF    ; maximum memory to be allocated, in paragraphs          c
.in_ss: dw 0fffh           ; initial relative value of the stack segment         e
.in_sp: dw 0xFFF0       ; initial sp value                                       10
.checksum: dw 1         ; checksum: 1's complement of sum of all words           12
.in_ip: dw start        ; initial ip value                                       14
.in_cs: dw  0      ; initial relative value of the text segment                  16
.offset: dw 0         ; offset of the relocation table from start of header      18
.overlay: dw 0          ; overlay value (0h = main program)                      1a
.overlay2: dw 0         ;                                                        1c
.ovs:      dw 0         ;1e
.ovs2:     db 0         ;1f
section .text
.reserv : times 200h db 0x90
 
main: db 090h                
jmp start

; Porta para o speaker (3x64h)
Ng equ  400
Nf equ  450
Ne equ  500
Nd equ  550
Nc equ  600
Nb equ  650
Na equ 700
speaker_port: db 0x61
dur1: dw 0
dur2: dw 0

playNote:
    ; Recebe a frequencia da nota como argumento
    ; Recebe a duração da nota como argumento
    push ebx
    push ecx
    push edx

    push eax ; frequencia da nota
   push ebx ; duracao da nota

    ; Ativa o speaker
    in al, 0x61
    or al, 3
    out  0x61, al

    noteLoop:
        ; Gera o som da nota
        pop eax
        pop ebx
        push eax
        mov edx,0
        mov ecx,0
        mov eax,1193181
        idiv ebx
        mov dx,ax
        mov al,0xb6
        out 43h, al
        mov al, dl
        out 42h, al
        mov al, dh
        out 42h, al
        pop ecx
        waitLoop3:
        mov ebx,100
        waitLoop:
          mov eax,2*18
          call sleep     
        ; Desativa o speaker
        in al,  0x61
        and al, 0xFC
        out  0x61, al

    ; Restaura o registrador
    pop edx
    pop ecx
    pop ebx
    ret
    
start:
push ax
push bx
call backs
pop bx
pop ds
mov cl,0

forii:
    ds
    mov al,[bx]
    inc bx
    inc cl
    cmp al,0
    jnz forii

mov di,endf
mov ax,10
clc
add di,ax

    
foriii:
    ds
    mov al,[bx]
    cs
    mov[di],al
    dec bx
    dec di
    dec cl
    jnz foriii 

mov ax,cs
mov ds,ax
mov es,ax
mov bx,endf 
call val32      
    mov ebx, 2000
    call playNote


    ; Sair do programa

retf
fill32:                
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          push ds                
          mov bp,0                
          mov ds,bp
          cmp edx,0
          JNZ FILL3211
          inc edx                
          FILL3211:
          FILL321:  
                    ds    
                    mov [edi],al
                    clc                
                    add edi,edx
                    dec ecx                
                    JNZ FILL321
                    pop ds                
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
                    pop eax                
                    RET 
                    
backs:
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          push es    
          mov edi,0b8001h
          mov ecx,80*30
          mov al,017h
          mov edx,2
          call fill32
          mov edi,0b8000h
          mov ecx,80*26
          mov al,32
          mov edx,2
          pop es                
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET  
          
          
timer:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
                          
          mov ax,40h
          mov ds,ax
          mov bx,6ch
          ds
          mov eax,[bx]
                          
          pop es                
          pop ds                
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          RET                
                
                
                
                
                
sleep:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          push ds                
          push es                
          mov ecx,eax
          mov ebx,eax
          call timer
          clc                
          add ebx,eax
          mov ecx,ebx
          JO SLEEP5
          SLEEP1:                
                    call timer
                    cmp eax,ecx
                    JB SLEEP1
          JMP SLEEP6
          SLEEP5:                
          call timer
          cmp eax,ecx
          JA SLEEP5
JMP SLEEP1
SLEEP6:                
                
pop es                
pop ds                
pop ebp                
pop esi                
pop edi                
pop edx                
pop ecx                
pop ebx                
RET                                    

val32:                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          mov edi,0
          mov ebp,1000000000
          mov si,bx
          VAL321:   
                    ds             
                    mov al,[si]
                    mov ah,'0'
                    clc                
                    sub al,ah
                    and eax,0ffh
                    mov ebx,ebp
                    xor edx,edx
                    xor ecx,ecx
                    clc                
                    mul ebx                
                    clc                
                    add eax,edi
                    mov edi,eax
                    mov eax,ebp
                    mov ebx,10
                    xor edx,edx
                    xor ecx,ecx
                    clc                
                    div ebx                
                    mov ebp,eax
                    inc si                
                    cmp ebp,0
                    JNZ VAL321
          mov eax,edi
                          
                          
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          RET 
          
          
          
endf db "00000000000000000000000",0                     
