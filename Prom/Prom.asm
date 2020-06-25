include number.asm 
.MODEL LARGE
.386
.STACK 200h

;variables de la Tabla de Simbolos
.DATA
    _cte01      dd  9.0
    _cte02      dd  10.0
    _cte03      dd  8.0
    _cte04      dd  9.0
    _cte05      dd  4.0 ; cant de constantes a sumar
    a           dd  ?

;codigo
.CODE

start:
    MOV EAX,@DATA
        MOV DS,EAX
        MOV ES,EAX

        FLD _cte01 ;la cargo en la pila S(0) = _cte01 ; FLD SIEMPRE VA AL TOPE DE LA PILA
        FLD _cte02 ;la cargo en la pila S(0) = _cte02 ; S(1) = _cte01 


    ;suma
        FADD ;LA SUMA OPERA SOBRE EL REGISTRO S(1). 1 = 1 + 0 pop.S(0)=suma1; S(1)=suma1
        FLD _cte03 ; S(0) = _cte03; S(1) = suma1;S(2) = suma1

    ;suma
        FADD ; S(0) = suma2; S(1) = suma2; S(2) = suma1
        FLD _cte04 ; S(0) = _cte04; S(1) = suma2; S(2) = suma2; S(3) = suma1 

    ;suma
        FADD ; S(0) = suma3; S(1) = suma3; S(2) = suma2; S(3) = suma1 
        FLD _cte05 ; S(0) = _cte05; S(1) = suma3; S(2) = suma3; S(3) = suma2; S(4) = suma1

    ;division
        FDIV ; OJO! DIVIDE S(1) CON S(0), LA RESTA TAMBIEN;  
        ; S(0) = division; S(1) = division; S(2) = suma3; S(3) = suma2; S(4) = suma1
    ;asig
        FSTP a; SACA EL TOPE DE LA PILA S(0) y LO PONE EN a

        DisplayFloat a,2

    MOV EAX, 4C00h
    INT 21h

    END start;