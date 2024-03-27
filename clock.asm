format mz                
start:
JMP MAIN                
sourcetext dd 1
destenytext dd 1
x:    dd 0     
y:     dd 0
hesvalue1: dw 0,0,0,0,0,0,0,0
hesvalue2: dw 0,0,0,0,0,0,0,0
color dd 07h
MAIN:   		
          call backs
                    mov bx,str3
                    call len
                    mov cx,ax        
                    mov bx,str3
                    call cprint
mov cl,0                
          FOR1:                
                                    
                                    
                    mov ah,2                
                    int 1ah 
                                   
                    push dx                
                    push cx                
                    push cx                
                                    
                    pop ax
                                    
                    mov al,ah
                    mov di,hesvalue1
                    call hex 
                    mov cx,2
                            
                    mov bx,hesvalue1
                    call cprint
                    mov cx,1
                            
                    mov bx,str4
                    call cprint                    
                    
                    pop ax                
                    mov di,hesvalue1
                    call hex                
                    mov cx,2
                            
                    mov bx,hesvalue1
                    call cprint
                    mov cx,1
                            
                    mov bx,str4
                    call cprint                                                                                 
                    pop ax                
                    mov al,ah
                    mov di,hesvalue1
                    call hex       
                    mov cx,2
                            
                    mov bx,hesvalue1
                    call cprint        
 
                    mov cx,5        
                    mov bx,str5
                    call cprint
                    mov cx,1        
                    mov bx,str3
                    call cprint
          mov eax,18
          call sleep
          mov ah,1
          int 16h
          ;jz FOR2       
          cmp al,27
          jnz FOR1  
                               
 FOR2:                                                                 
                                                                   
           call backs                                       
                                         
                     
                          
          exitdo:                
                    mov bx,str3
                    call len
                    mov cx,ax        
                    mov bx,str3
                    call cprint   
call backs
                                   
                    exit:     
                              retf           
                              int 20h                
                              xor ah,ah
                              int 21h                
                                             
halt:
jmp halt               

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
                    
copymem32:
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
          JNZ COPYMEM3211
          inc edx                
          COPYMEM3211:
          cmp ecx,0
          JZ COPYMEM326
          COPYMEM321:
                    ds
                    mov al,[esi]
                    ds
                    mov [edi],al
                    clc                
                    add edi,edx
                    inc esi                
                    dec ecx                
                    JNZ COPYMEM321
                    COPYMEM326:
                    pop ds                
                    pop ebp                
                    pop edi                
                    pop esi                
                    pop edx                
                    pop ecx                 
                    pop ebx                
                    pop eax                
                    RET 
mem32:                
          push esi                
                          
          and eax,0ffffh
          clc                
          shl eax,4
          and esi,0ffffh
          clc                 
          add eax,esi
                          
          pop esi                
          RET 
gotoxy:                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          mov si,ax
          mov di,bx
          and si,0fffh
          and di,0fffh
          xor cx,cx
          xor dx,dx
          mov ax,si
          mov bx,2                
          clc                
          mul bx                
          mov si,ax
          mov ax,di
          mov bx,160
          clc                
          mul bx                
          mov bx,si
          clc                
          add ax,bx
          and eax,0ffffh
          mov ebx,0b8000h
          clc                
          add eax,ebx
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          RET                                       

print:                
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          push es                
          mov ax,cs
          mov es,ax
          xchg dx,bp 
          mov bx,bp
          cs
          mov cl,[bx]
          inc bp                
          and cx,0ffh 
          mov bx,x
          cs
          mov dx,[bx]
          mov bx,color
          cs
          mov al,[bx]
          mov bl,al
          mov bh,0                
          mov al,0                
          mov ah,13h
          int 10h                
          pop es                
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET         
clears:
          push ax                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          push bp                
          push es    
          mov edi,0b8001h
          mov ecx,80*26
          mov al,017h
          mov edx,2
          call fill32
          mov edi,0b8000h
          mov ecx,80*26
          mov al,32
          mov edx,2
          call fill32
          pop es                
          pop bp                
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET        

print32:                
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          cmp ecx,0
          JZ PRINT3213
          cs
          mov al,[x]                
          cs
          mov bl,[y]               
          and ax,0ffh
          and bx,0ffh
          call gotoxy
          mov edi,eax
          cmp ecx,255
          JB PRINT3212
          mov ebx,255
          PRINT3212:
          mov edx,2
          call copymem32 
          cs
          mov al,[x]                
          cs
          mov bl,[y]                
          and ax,0ffh
          and bx,0ffh
          mov si,bx
          clc                
          add ax,cx
          cmp ax,80
          JB PRINT328
          mov bx,80
          sub ax,bx
          xor dx,dx
          xor cx,cx
          mov bx,80
          clc                
          div bx                
          clc                
          add ax,si
          cmp ax,24
          JB PRINT328
          mov ax,24
          PRINT328:
          cs
          mov [y],ax                
          cs
          mov [x],dx 
          PRINT3213:
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET                
               
scrollup:
          push eax                
          push ebx                
          push ecx                
          push edx                
          push esi                
          push edi                
          push ebp                
          push ds                
          mov ax,0                
          mov ds,ax
          mov edi,0b8000h
          mov esi,0b8000h+160  
          mov ecx,80*24*2
          mov edx,1
          call copymem32
          pop ds                
          pop ebp                
          pop edi                
          pop esi                
          pop edx                
          pop ecx                 
          pop ebx                
          pop eax                
          RET          

printf:                
          push ax                
          push bx                
          xor bh,bh
          mov bl,70h
          mov ah,0eh
          int 10h                
          pop bx                
          pop ax                
          RET                
                
                
getchar:                
          xor ax,ax
          int 16h                
          RET                
                
                
getstr:                
          push ax                
          push bx                
          push cx                
          push dx                
          mov dx,cx
          GETSTR1:                
                    call getchar
                    cmp al,7                
                    JNZ GETSTR2
                    inc cx                
                    dec bx                
                    cmp cx,dx
                    JB GETSTR2
                    inc bx                
                    mov cx,dx
                    GETSTR2:                
                    cmp al,13
                    JZ GETSTR3
                    mov [bx],al
                    call printf
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JA GETSTR1 
          GETSTR3:                
          pop dx                
          pop cx                
          pop bx                
          pop ax                
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
                
cprint:                
          push ax                
          push bx                
          push cx                
          push dx                
          CPRINT1:               
                    mov al,[bx]
                    call printf
                    inc bx                
                    dec cx                
                    cmp cx,0                
                    JNZ CPRINT1
          pop dx                
          pop cx                
          pop bx                
          pop ax                
          RET     

len:                
          push bx                
          push cx                
          push dx                
          mov cx,0                
          LEN1:                
                    mov al,[bx]
                    cmp al,0                
                    JZ LEN2                
                    inc bx                
                    inc cx                
                    cmp cx,0                
                    JNZ LEN1                
          LEN2:                
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
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
hhex1: db 16
hhex: db "0123456789ABCDEF.$",0
                
hex:                
          push ax                
          push bx                
          push dx                
          push esi                
          push edi                
          push ds                
                          
          inc di                           
          xor ah,ah
          mov dx,ax
          and ax,0fh
          cs
          mov si,hhex
          clc                
          add si,ax
          cs 
          mov al,[si]
          ds
          mov [di],al
          dec edi                
          mov ax,dx
          and ax,0f0h
          shr ax,4                
          mov si,hhex
          clc                
          add si,ax 
          cs
          mov al,[si]
          ds
          mov [di],al
                          
          pop ds                
          pop edi                
          pop esi                
          pop dx                
          pop bx                
          pop ax                
          RET                                              
text1 db 22,"input a string.....",13,10,0
string2 db "$",0
file1 db "list.txt"
str2 db 13,10,"turn off pc",13,10,0
str3 db 13,10,13,10,0
str4 db ":",0
str5 db "                                             ",0
endf db "          .                                                               "
