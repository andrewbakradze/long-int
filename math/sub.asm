section         .text

                cpu             x64

                global          long_int_sub


; subtracts two long numbers
;    rdi -- address of minuend (long number)
;    rsi -- address of subtrahend (long number)
;    rdx -- length of long numbers in qwords
; result:
;    difference is written to rdi
long_int_sub:
                clc


.differ_of_numbers:
                mov             r9, [rsi]
                sbb             [rdi], r9
                lea             rdi, [rdi + 8] ;move pointer
                lea             rsi, [rsi + 8] ;move pointer
                dec             rdx
                jnz             .differ_of_numbers

                ret

