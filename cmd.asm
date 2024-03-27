org 0x100
           
                          
start:
jmp MAIN                
sourcetext dd 1
destenytext dd 1
x:    dd 0     
y:     dd 0
color dd 07h
MAIN:

mov sp,0ffffh
mov ax,cs
mov ss,ax
mov ax,cs
mov es,ax
mov ds,ax

call backs

          mov si,endf
          mov ax,cs
          call mem32
          mov edi,eax
          mov edx,1
          mov al,0
          mov ecx,86
          call fill32
          
   		
          
         mov bx,text1
         mov cx,6
         call cprint
                 
mov bx,endf
mov cx,79
call getstr
         mov bx,endf
         call len
         mov cx,2
         mov bx,str2
         
         call cprint 
         mov bx,endf
         mov dx,spc
         mov cx,1
         call findstring
         
         mov dx,endf
         cmp ax,0ffffh
         jz escpp

         mov bx,exch
         inc ax
         cs
         mov [bx],ax
         
         mov bx,ax
         dec bx
         mov al,0
         cs
         mov [bx],al
         
         jmp escpp2
         escpp:
         mov bx,exch
         cs
         mov [bx],dx
         escpp2:
                    
call backs



                   
                     
                          
          exitdo:                
                                    
                                  
                    exit:                
                              jmp loads            
                                             
                

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
          mov al,0
          mov [bx],al                
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
          mov ecx,80*26
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
loads:

;calculator of next 64 segment

	mov ax,cs
	mov bx,0x1000
	clc
	add ax,bx
	push ax
	mov ds,ax
	mov bx,0
	mov al,0
	mov cx,1024
	fori:
	    
	    ds
	    mov [bx],al
	    inc bx
	    dec cx
	    cmp cx,0
	    jnz fori

;----------------------------------	
;open file
        mov ax,cs
        mov ds,ax
        mov es,ax
	mov ah,3dh
	mov al,0
	mov dx,endf
	int 0x21
	mov bx,ax
	jc printe
	
;----------------------------------
reads:

;read file	
        
        mov dx,0
        mov cx,0ffffh
        pop ax
        mov ds,ax
        mov es,ax
        push ds
        push bx
        mov ah,3fh
	int 0x21
;----------------------------------
;close file
        pop bx
	mov ah,3eh
	int 0x21
pop ax
mov es,ax
mov ds,ax
;----------------------------------
mov ax,ds
mov bx,0x0
ds
mov al,[bx]
cmp al,'M'

jnz printe
;----------------------------------
;cs load
mov ax,ds
mov bx,0x8
ds
mov cx,[bx]
add ax,cx
mov bx,0x16
ds
mov cx,[bx]
add ax,cx
mov si,ax
;----------------------------------
;ip load
mov bx,0x14
ds
mov cx,[bx]
mov di,cx
;----------------------------------
;ss load
mov ax,ds
mov sp,0xFFFF
mov bx,0x0e
ds
mov cx,[bx]
add ax,cx
mov ss,ax
;----------------------------------
;sp load
mov bx,0x10
ds
mov cx,[bx]
mov sp,cx
;----------------------------------
mov ax,cs
push ax
mov ax,MAIN
push ax
push si
push di
mov ax,si
mov es,ax
mov ds,ax
mov si,0
mov bx,exch
cs
mov ax,[bx]
mov bx,ax
mov dx,0
mov cx,32000
mov ax,cs
retf
printe:
mov ax,cs
mov ds,ax
mov es,ax
pop ax

         mov bx,errors
         call len
         mov cx,ax
         mov bx,errors
         
         call cprint 
mov ax,cs
mov ds,ax
mov es,ax
jmp MAIN 
compstr:                
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov cx,0                
          mov si,bx
          mov di,dx
          COMPSTR1:
                    mov al,[si]
                    mov ah,[di]
                    cmp al,0                
                    JZ COMPSTR2
                    cmp ah,0                
                    JZ COMPSTR2
                    cmp al,ah
                    JNZ COMPSTR2
                    inc di                
                    inc si                
                    inc cx                
                    cmp cx,0                
                    JNZ COMPSTR1
          COMPSTR2:
          mov ax,cx
          pop si                
          pop di                
          pop dx                
          pop cx                
          pop bx                
          RET                
                
findstring:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov si,dx
          xor ax,ax
          mov al,[si]
          mov di,ax
          mov si,bx
          mov bx,dx
          call len 
          cmp ax,0                
          JNZ FINDSTRING9
          mov ax,0ffffh
          jmp  FINDSTRING8
          FINDSTRING9:
          mov bx,si
          mov si,ax
          FINDSTRING1:
                    mov ax,di
                    call findchar
                    cmp ax,0ffffh
                    JZ FINDSTRING8
                    clc                 
                    add bx,ax
                    call compstr
                    cmp si,ax
                    JZ FINDSTRING10
                    inc bx                
                    jmp FINDSTRING1
                    FINDSTRING10:
                    mov ax,bx
                    FINDSTRING8:
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                                    
                    RET
        
          RET                                        
findchar:
          push bx                
          push cx                
          push dx                
          mov cx,0                
          mov ah,al
          FINDCHAR1:
                    mov al,[bx]
                    cmp al,0                
                    JZ FINDCHAR2
                    cmp al,ah
                    JZ FINDCHAR3
                    inc bx                
                    inc cx                
                    cmp cx,255
                    JNZ FINDCHAR1
          FINDCHAR2:
          mov cx,0ffffh
          FINDCHAR3:
          mov ax,cx
          pop dx                
          pop cx                
          pop bx                
          RET      
                                             
compstring:
          push bx                
          push cx                
          push dx                
          push di                
          push si                
          mov cx,0                
          mov si,bx
          mov di,dx
          COMPSTRING1:
                    mov al,[si]
                    mov ah,[di]
                    cmp al,0                
                    JZ COMPSTRING2
                    cmp ah,0                
                    JZ COMPSTRING2
                    cmp al,ah
                    JNZ COMPSTRING2
                    inc di                
                    inc si                
                    inc cx                
                    cmp cx,0                
                    JNZ COMPSTRING1
          COMPSTRING2:
          cmp al,ah
          JZ COMPSTRING3
          JB COMPSTRING4
          mov ax,1                
          jmp COMPSTRING5
          COMPSTRING3:
          mov ax,0                
          jmp COMPSTRING5
          COMPSTRING4:
          mov ax,2                
          COMPSTRING5:
                    pop si                
                    pop di                
                    pop dx                
                    pop cx                
                    pop bx                
                    RET    
                    
findpos:                
          call findstring
          cmp ax,0ffffh
          JZ FINDPOS1
          sub ax,bx
          FINDPOS1:
          RET             
     
                
text1 db " cmd> ",0
string2 db "$",0
errors db "file not found",13,10,0
exch dd 0
spc db " ",0
str2 db 13,10,">"
endf db 0
endf2 db "                                                                                               "
