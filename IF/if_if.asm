include number.asm
include macros2.asm

.MODEL LARGE
.386
.STACK 200h

;variables de la Tabla de Simbolos
.DATA
    _02      dd  2.0
    _03      dd  3.0
    _25      dd  25.0
    a        dd  20.0
    b        dd  4.0
    c        dd  10.0
    str_Var db  "Variables", '$', 3 dup (?)

    
;codigo
.CODE

start:
    MOV EAX,@DATA
    MOV DS,EAX
    MOV ES,EAX
 
    mov dx, OFFSET str_Var
    mov ah,9
    int 21h     
    newline 1
    DisplayFloat a,1
    newline 1
    DisplayFloat b,1
    newline 1
    DisplayFloat c,1
    newline 1
    
    FLD a
    FLD b
    FCOM
    FSTSW AX 
    SAHF
    JE et01Fin ; jump if equal
    FFREE
    
    FLD a ; S(0) = a
    FLD c ; s(0) = c ; s(1) = a
    FXCH
    FCOM
    FSTSW AX 
    SAHF
    JBE et01Fin ;  jump if below or equal
    FFREE

et01Ini: 

;suma
    FLD b
    FLD _02
    FADD

;asignacion
    FSTP a    

;multiplicacion
    FLD _03
    FLD _25
    FMUL

;asignacion
    FSTP c    
    
;muestro como quedan al final
    mov dx, OFFSET str_Var
    mov ah,9
    int 21h
    newline 1
    DisplayFloat a,1
    newline 1
    DisplayFloat b,1
    newline 1
    DisplayFloat c,1 
    newline 1   
    
et01Fin:
    
    MOV EAX, 4C00h
    INT 21h
 
    END start;
    
    