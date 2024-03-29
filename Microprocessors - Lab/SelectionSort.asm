;An array with 10 elements whose elements can be between 0-126 
;(Ex: vector DB 15,8,13,7,6,14,4,2,0,9)
;when given in the program

name "snt" 
org  256

.data

arr db 120,8,13,7,60,14,4,2,98,3
count  dw 10 

.code
mov di, 0h                      ;starter memory
mov bp, 200h
mov cx, count
memory:                         ;assign arr to memory
    mov ah, arr+di
    mov [bp][di], ah
    add di, 1h
    loop memory

mov di,0h
outer:
    mov si,di

    mov al, [bp][si]            ;take si.th element for starting
    mov bx, 200h                ;and take its address for use later.
    add bx, si                  ;when array ordered, program continuing to checking
                                ;so it won't use smaller module. so we need to
                                ;take address in here too.
    inner: 
        isSma:
          cmp si,9
          jge swap 
          inc si
          cmp [bp][si] , al 
          jnge smaller          ;al is min
          cmp si, 9 
          jge swap
          jmp isSma

        swap:
           mov dl, [bp][di]
           mov [bp][di], al     ;mov smallest to address of current element
           mov [bx], dl         ;mov element to address of smallest
           inc di 
           cmp di, 9
           je done              ;if di = 9 (all elements visited) finish program
           jmp outer

done:
    ret

smaller:
  mov al, [bp][si]               ;smallest
  mov bx, 200h
  add bx, si                     ;take address of smallest one
  jmp isSma
