.MODEL SMALL

.STACK 128

.DATA
    HSTATE  DW 1h           ; состояние датчика влажности (вкл/выкл)
    HCOUNT  DB 0h           ; номер периода опроса датчика влажности
    TSTATE  DW 00b          ; состояние тэна (активен, нагрев/охлаждение)
    DAC     DW 0            ; текущее состояние сигнала ЦАП
    INPORT  DW 8A5h         ; входящий порт
    OUTPORT DW 8A6h         ; исходящий порт
    TCOUNT  DQ 0h           ; счетчик тактов
    INPUT 	DB 256 DUP (0)  ; буффер для хранения ???
    OUTPUT 	DB 256 DUP (0)  ; буффер для хранения ???

.CODE

HEATDELAY PROC FAR
    PUSH 	CX 			    ; 15 тактов
    MOV 	CX, 13489		; 4 такта
L1:				            ;
    LOOP L1                 ; 5 тактов

    MOV CX, 1               ; 4 такта
    POP CX 			        ; 12 тактов
    RET 				    ; 20 тактов
ENDP

main PROC
    MOV AX, @DATA
    MOV DS, AX

MAIN_LOOP:
    MOV BX, TSTATE
    CMP BX, 10b             ; включен ли тэн
    JGE TENABLED
                            ; считываем данные с термодатчика
    MOV DX, INPORT
    IN AX, DX
    AND AX, 1000000000000000b
    JZ CENABLE
HENABLE:                    ; проверяем условия для включения нагрева
    MOV AX, DAC
    CMP AX, 0h
    JNE TSKIP
    MOV BX, 11b
    MOV TSTATE, BX
    JMP TENABLED
CENABLE:                    ; проверяем условия для включения охлаждения
    MOV AX, DAC
    CMP AX, 00D3h
    JNE TSKIP
    MOV BX, 10b
    MOV TSTATE, BX
TENABLED:                   ; записываем в ЦАП сигнал
    MOV AX, DAC
    MOV DX, OUTPORT
    OUT DX, AX
    AND BX, 1b              ; проверяем бит направления изменения сигнала тэна
    JZ COOL
HEAT:                       ; увеличиваем сигнал в ЦАП
    ; call HEATDELAY
    CMP AX, 00D3h
    JE TDISABLE
    INC AX
    MOV DAC, AX
    JMP TSKIP
COOL:                       ; уменьшаем сигнал в ЦАП
    ; call COOLDELAY
    CMP AX, 0h
    JE TDISABLE
    DEC AX
    MOV DAC, AX
    JMP TSKIP
TDISABLE:                   ; выключаем тэн
    MOV TSTATE, 00b
TSKIP:
    MOV AX, HSTATE
    CMP AX, 0
    JE HSKIP
HENABLED:
    CMP TCOUNT, 108000000   ; тактов в 2 секундах 
    JL HSKIP


HSKIP:
    JMP MAIN_LOOP



; ; считываем данные из порта, пока бит
; RLOOP:
;     MOV DX, INPORT
;     IN AX, DX
;     AND AX, 0000000100000000b
;     JZ RLOOP

;     MOV DX, OUTPORT
;     MOV AL, U
;     TEST AL, 1
;     JNZ ODD

;     AND AL, 10111101b ; сбрасываем SR 2, 7
;     OR  AL, 00001001b ; устанавливаем RS 1, 4
;     JMP AFTERODD
; ODD:
;     OR  AL, 01000010b ; устанавливаем SR 2, 7
;     AND AL, 11110110b ; сбрасываем RS 1, 4
; AFTERODD:
;     OUT DX, AL

;     CALL DELAY

;     MOV BX, N
;     SUB BX, CX
;     MOV OUTPUT[BX], AL

;     MOV DX, INPORT
;     IN AL, DX
;     MOV INPUT[BX], AL

;     MOV AL, U
;     ADD AL, DELTAU
;     MOV U, AL
;     LOOP LMAIN

    MOV AX, 4c00h
    INT 21h
main ENDP
END main
