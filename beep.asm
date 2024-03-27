format mz



                
                
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
call backs
    ; Toca a nota C por 1 segundo
    mov eax, Ng
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
                
