; HASSAN SAMADI    &   ALI FAZELNYA


ORG 100h


PUTC    MACRO   char
        PUSH    AX
        MOV     AL, char
        MOV     AH, 0Eh
        INT     10h     
        POP     AX
ENDM

.model small
.data

buflen equ 10  
maxlena db 5
actlena db ?
numa db 5 dup(?)
messagea db 0DH,0AH, 'Enter your decimal number: ',0AH,0DH,'$', 0
numc db buflen dup(' '), '$'
messagec db 0dh,0ah, 'Binary form: ',0dh,0ah,'$', 0

choice_message db 0dh,0ah, 'Choose 1 for Binary to Decimal , 2 for Decimal to Binary: $', 0
binary_prompt db 0dh,0ah, "Enter binary number : $", 0  

sum DW 0  
flag DB 0
choice DB 0

.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, choice_message
    call print_string

    mov ah, 01h
    int 21h
    sub al, '0'
    mov choice, al

    cmp choice, 1
    je inputBinary
    cmp choice, 2
    je inputDecimal
    jmp stop_program

inputBinary:
    lea dx, binary_prompt
    call print_string

    mov dx, buflen   
    lea di, numc
    call GET_STRING

    
    mov sum, 0

    mov cx, 8
    mov si, OFFSET numc

check_s:
        cmp [si], 0 
        jne ok0         
        mov flag, 1     
        jmp convert
    ok0:
        cmp [si], 'b' 
        jne ok1         
        mov flag, 1     
        jmp convert        
    ok1:    
        cmp [si], 31h
        jna ok2
        jmp error_not_valid     
    ok2:
        inc si
    loop check_s

convert:
    mov bl, 1   
    mov cx, si
    sub cx, OFFSET numc
    dec si
    jcxz stop_program

next_digit:
    mov al, [si]  
    sub al, 30h
    mul bl        
    add sum, ax
    shl bl, 1
    dec si        
    loop next_digit

print_unsigned:
    call print
    db 0dh, 0ah, "Decimal: $", 0
    mov  ax, sum
    call PRINT_NUM_UNS
    jmp stop_program

inputDecimal:
    lea dx, messagea
    call print_string
    lea dx, maxlena
    call get_decimal_input
    lea si, numa
    call asctobin
    lea si, numc
    call bintoasc
    lea dx, messagec 
    call print_string
    lea dx, numc
    call print_string
    jmp stop_program

error_not_valid:
    call print
    db 0dh, 0ah, "Error: Only zeros and ones are allowed!$", 0

stop_program:
    call print
    db 0dh, 0ah, "Press any key...$", 0
    mov ah, 0
    int 16h
    mov ah, 4ch
    int 21h
    ret

print_string proc
    mov ah, 9h
    int 21h
    ret
print_string endp

get_decimal_input proc
    mov ah, 0Ah
    lea dx, maxlena
    int 21h
    ret
get_decimal_input endp

asctobin proc
    mov ax, 0
count:
    mov bl, [si]
    cmp bl, 0dh
    je end_convert
    mov dx, 10
    mul dx
    sub bl, '0'
    mov bh, 0 
    add ax, bx
    inc si
    jmp count
end_convert:
    ret
asctobin endp

bintoasc proc
    mov bx, 2
    add si, buflen-1
conti:
    mov dx, 0
    div bx
    add dl, '0'
    mov [si], dl
    cmp ax, 0
    je end_convert2
    dec si 
    jmp conti
end_convert2:
    ret
bintoasc endp

GET_STRING PROC NEAR
    PUSH AX
    PUSH CX
    PUSH DI
    PUSH DX
    MOV CX, 0
    CMP DX, 1
    JBE empty_buffer
    DEC DX
wait_for_key:
    MOV AH, 0
    INT 16h
    CMP AL, 13
    JZ end_convert3
    CMP AL, 8
    JNE add_to_buffer
    JCXZ wait_for_key
    DEC CX
    DEC DI
    PUTC 8
    PUTC ' '
    PUTC 8
    JMP wait_for_key
add_to_buffer:
    CMP CX, 8  
    JAE wait_for_key
    MOV [DI], AL
    INC DI
    INC CX
    MOV AH, 0Eh
    INT 10h
    JMP wait_for_key
end_convert3:
    MOV [DI], 0
empty_buffer:
    POP DX
    POP DI
    POP CX
    POP AX
    RET
GET_STRING ENDP

PRINT_NUM PROC NEAR
    PUSH DX
    PUSH AX
    CMP AX, 0
    JNZ not_zero
    PUTC '0'
    JMP printed_pn
not_zero:
    CMP AX, 0
    JNS positive
    NEG AX
    PUTC '-'
positive:
    CALL PRINT_NUM_UNS
printed_pn:
    POP AX
    POP DX
    RET
PRINT_NUM ENDP

PRINT_NUM_UNS PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV CX, 1
    MOV BX, 10000
    CMP AX, 0
    JZ print_zero
begin_print:
    CMP BX, 0
    JZ end_print
    CMP CX, 0
    JE calc
    CMP AX, BX
    JB skip
calc:
    MOV CX, 0
    MOV DX, 0
    DIV BX
    ADD AL, 30h
    PUTC AL
    MOV AX, DX
skip:
    PUSH AX
    MOV DX, 0
    MOV AX, BX
    DIV CS:ten
    MOV BX, AX
    POP AX
    JMP begin_print
print_zero:
    PUTC '0'
end_print:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
ten DW 10
PRINT_NUM_UNS ENDP

print PROC
    MOV CS:temp1, SI
    POP SI
    PUSH AX
next_char:      
    MOV AL, CS:[SI]
    INC SI
    CMP AL, 0
    JZ printed_ok
    MOV AH, 0Eh
    INT 10h
    JMP next_char
printed_ok:
    POP AX
    PUSH SI
    MOV SI, CS:temp1
    RET
temp1 DW ?
print ENDP

end main
