section         .text

                cpu             x64

                global          long_int_add

long_int_add:
                clc
.adder_of_numbers:
                mov             r9, [rsi]
                adc             [rdi], r9
                lea             rdi, [rdi + 8] ;move pointer
                lea             rsi, [rsi + 8] ;move pointer
                dec             rdx
                jnz             .adder_of_numbers

                ret
