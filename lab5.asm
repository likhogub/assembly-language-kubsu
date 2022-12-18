.MODEL SMALL

.386

.STACK 128

.DATA
    HSTATE  DW 1b           ; состояние датчика влажности (вкл/выкл)
    HCOUNT  DW 0            ; номер периода опроса датчика влажности
    HACCUM  DW 0            ; аккумулятор датчика влажности
    TSTATE  DW 00b          ; состояние тэна (активен, нагрев/охлаждение)
    DAC     DB 0            ; текущее состояние сигнала ЦАП
    INPORT  DW 63DDh        ; входящий порт
    OUTPORT DW 63DEh        ; исходящий порт

.CODE

HEATDELAY PROC FAR
    PUSH 	CX 			    ; 15 тактов
    MOV 	CX, 734		    ; 4 такта
L1:				            ;
    PUSH CX                 ; 15 тактов
    MOV CX, 1248		    ; 4 такта
L2:
    LOOP L2                 ; 5 тактов
    POP CX 			        ; 12 тактов
    LOOP L1                 ; 5 тактов

    POP CX 			        ; 12 тактов
    RET 				    ; 20 тактов
ENDP

COOLDELAY PROC FAR
    PUSH 	CX 			    ; 15 тактов
    MOV 	CX, 49		    ; 4 такта
L3:				            ;
    PUSH CX                 ; 15 тактов
    MOV CX, 11483		    ; 4 такта
L4:
    LOOP L4                 ; 5 тактов
    POP CX 			        ; 12 тактов
    LOOP L3                 ; 5 тактов

    MOV CX, 1   		    ; 4 такта
    MOV CX, 1   		    ; 4 такта
    MOV CX, 1   		    ; 4 такта
    MOV CX, 1   		    ; 4 такта

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
    MOV AL, DAC
    CMP AL, 0h
    JNE TWAIT
    MOV BX, 11b
    MOV TSTATE, BX
    JMP TENABLED
CENABLE:                    ; проверяем условия для включения охлаждения
    MOV AL, DAC
    CMP AL, 00D3h
    JNE TWAIT
    MOV BX, 10b
    MOV TSTATE, BX
TENABLED:                   ; записываем в ЦАП сигнал
    MOV AH, 01000000b       ; устанавливаем бит ЦАП ЗП
    MOV AL, DAC
    MOV DX, OUTPORT
    OUT DX, AX
    AND BX, 1b              ; проверяем бит направления изменения сигнала тэна
    JZ COOL
HEAT:                       ; увеличиваем сигнал в ЦАП
    CALL HEATDELAY
    ADD CX, 2Eh
    CMP AL, 00D3h
    JE TDISABLE
    INC AL
    MOV DAC, AL
    JMP TSKIP
COOL:                       ; уменьшаем сигнал в ЦАП
    CALL COOLDELAY
    ADD CX, 1Ch
    CMP AL, 0h
    JE TDISABLE
    DEC AL
    MOV DAC, AL
    JMP TSKIP
TDISABLE:                   ; выключаем тэн
    MOV TSTATE, 00b
    JMP TSKIP
TWAIT:
    CALL COOLDELAY
    ADD CX, 1Ch
TSKIP:
    MOV AX, HSTATE
    CMP AX, 0
    JE HSKIP
HENABLED:
    CMP CX, 0000FFDCh           ; периодов по X тактов
    JL HSKIP
    MOV CX, 0
    MOV AX, HCOUNT
    INC AX
    MOV HCOUNT, AX

HGRP2:                       ;  опрос первой группы датчиков
    MOV AX, 1000000000000000b 
    MOV DX, OUTPORT
    OUT DX, AX
    MOV DX, INPORT
HS1:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100000000000000b ; проверяем АЦП ГТ
    JZ HS1
    AND AX, 0000001111111111b
    ADD HACCUM, AX

    MOV AX, 1000110000000000b
HS3:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100000000000000b ; проверяем АЦП ГТ
    JZ HS3
    AND AX, 0000001111111111b
    ADD HACCUM, AX

    MOV AX, 1001110000000000b
HS5:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100000000000000b ; проверяем АЦП ГТ
    JZ HS5
    AND AX, 0000001111111111b
    ADD HACCUM, AX              ; AX = 3C + f1(h) + f2(h) + f3(h)

    MOV AX, HACCUM                                
    SUB AX, 2031                ; -3C
    CMP AX, 480                 ; 1 % влажности = 6
    JL HGRP4
    MOV HSTATE, 0
    JMP HSKIP
HGRP4:
    MOV AX, HCOUNT
    AND AX, 10b
    JZ HGRP8

    MOV AX, 1001110000000000b 
    MOV DX, OUTPORT
    OUT DX, AX
    MOV DX, INPORT
HS7:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100000000000000b   ; проверяем АЦП ГТ
    JZ HS7
    AND AX, 0000001111111111b
    MOV HACCUM, AX

    MOV AX, 1010010000000000b
HS9:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100000000000000b   ; проверяем АЦП ГТ
    JZ HS9
    AND AX, 0000001111111111b
    ADD HACCUM, AX

    MOV AX, 1010110000000000b
HS11:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100000000000000b   ; проверяем АЦП ГТ
    JZ HS11
    AND AX, 0000001111111111b
    ADD HACCUM, AX

    MOV AX, HACCUM              ; AX = 3C + f1(h) + f2(h) + f3(h)
    SUB AX, 2031                ; -3C
    CMP AX, 480                 ; 1 % влажности = 6
    JL HGRP8
    MOV HSTATE, 0
    JMP HSKIP

HGRP8:
    MOV AX, HCOUNT
    AND AX, 100b
    JZ HGRP6


    MOV AX, 1010000000000000b 
    MOV DX, OUTPORT
    OUT DX, AX
    MOV DX, INPORT
HS8:
    IN AX, DX
    MOV BX, AX
    AND BX, 0101110000000000b   ; проверяем АЦП ГТ
    JZ HS8
    AND AX, 0000001111111111b
    MOV HACCUM, AX

    MOV AX, 1010000000000000b
HS10:
    IN AX, DX
    MOV BX, AX
    AND BX, 0101001000000000b   ; проверяем АЦП ГТ
    JZ HS10
    AND AX, 0000001111111111b
    ADD HACCUM, AX

    MOV AX, 1011000000000000b
HS12:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100000000000000b   ; проверяем АЦП ГТ
    JZ HS12
    AND AX, 0000001111111111b
    ADD HACCUM, AX
    MOV AX, HACCUM              ; AX = 3C + f1(h) + f2(h) + f3(h)
    SUB AX, 2031                ; -3C
    CMP AX, 480                 ; 1 % влажности = 6
    JL HGRP6
    MOV HSTATE, 0
    JMP HSKIP

HGRP6:
    MOV AX, HCOUNT
    MOV BX, 3
    DIV BX
    OR DX, 0b
    JZ HSKIP

    MOV AX, 1010000000000000b 
    MOV DX, OUTPORT
    OUT DX, AX
    MOV DX, INPORT
HS2:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100100000000000b   ; проверяем АЦП ГТ
    JZ HS2
    AND AX, 0000001111111111b
    MOV HACCUM, AX

    MOV AX, 1010000000000000b
HS4:
    IN AX, DX
    MOV BX, AX
    AND BX, 0100100000000000b   ; проверяем АЦП ГТ
    JZ HS4
    AND AX, 0000001111111111b
    ADD HACCUM, AX

    MOV AX, 1001100000000000b
HS6:
    IN AX, DX
    MOV BX, AX
    AND BX, 0101100000000000b   ; проверяем АЦП ГТ
    JZ HS6
    AND AX, 0000001111111111b
    ADD HACCUM, AX
    MOV AX, HACCUM              ; AX = 3C + f1(h) + f2(h) + f3(h)
    SUB AX, 2031                ; -3C
    CMP AX, 480                 ; 1 % влажности = 6
    JL HSKIP
    MOV HSTATE, 0

HSKIP:
    JNE MAIN_LOOP

    MOV AX, 4c00h
    INT 21h
main ENDP
END main
