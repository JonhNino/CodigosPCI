;-----------------------------------------------------
;Universidad Pedagogica y Tecnologica de Colombia UPTC
;Facultad Seccional Sogamoso
;Escuela de Ingenieria Electronica
;-----------------------------------------------------
;Microprocessor's Course
;Description: Using ports through IN/OUT instructions
;Author:      Wilson Javier Perez Holguin
;Date:        17-09-2021
;-----------------------------------------------------
.MODEL SMALL 

.DATA    
		DATO_LEIDO 		DB 	1000 DUP (?)           
		
		PTO_SALIDA		DW	0700H 
		
		PTO_ENTRADA		DW	0710H
		
		PPI_PTOA        DW  0720H
		PPI_PTOB        DW  0722H
		PPI_PTOC        DW  0724H
		PPI_CTRL        DW  0726H
		
		TPI_CNT0        DW  0730H
		TPI_CNT1        DW  0732H
		TPI_CNT2        DW  0734H
		TPI_CTRL        DW  0736H
		
		CNT             DB  0	
   

.STACK  
        DB      64 DUP (?) 
        

.CODE
	             
MAIN	PROC NEAR  
    
START:
		MOV     AX,@DATA
		MOV     DS,AX
		              
	    ;CONFIGURACION DE LA PPI
		MOV     AL,81H			; PALABRA DE CONFIGURACIÓN DE LA PPI
		MOV     DX,PPI_CTRL
		OUT     DX,AL


		MOV 	DI,0
;		MOV		CX,5000
CICLO:

		MOV     DX,PTO_ENTRADA  ; DX = DIRECCION DEL PUERTO
		IN	    AL,DX           ; AL = DATO LEIDO DEL PUERTO
		                  
		MOV	    DATO_LEIDO[DI],AL 
		INC		DI
		CMP		DI, 1000
		JNE		SEGUIR
		MOV		DI,0
		
SEGUIR:		
		MOV     DX,PTO_SALIDA	
		OUT	    DX,AL
		  
		;SACANDO CONTEO POR PTOB DE LA PPI  
		MOV     DX,PPI_PTOB
		MOV     AL,CNT
		OUT     DX,AL
		INC     CNT
		           
		CALL    DELAY

		JMP		CICLO
;		LOOP    CICLO
		
		RET
MAIN	ENDP		
		
DELAY	PROC    NEAR USES CX
		MOV		CX,65535
L1:		LOOP 	L1
		RET
DELAY 	ENDP