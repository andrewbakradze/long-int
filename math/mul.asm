section         .text
                extern          long_int_set_zero
                extern          long_int_add
                cpu             x64

                global          long_int_mul


long_int_mul:
                push            rbx
                push            r12
                push            r13
                push            r14
                push            r15

                mov             r12, rdi ;first operand
                mov             r13, rsi ;second operand
                mov             r14, rcx ;len
                mov             r15, rdx ; ans location

                mov             rdi, r15
                mov             rsi, r14
                shl             rsi, 1
                call            long_int_set_zero
                xor             rbx, rbx


.multiplier_of_numbers:
                cmp             rbx, r14
                je              .success

                mov             rdi, r12 ;set first opperand for function
                mov             rsi, [r13] ;set second opperand for function (part of long number)
                lea             r13, [r13 + 8] ;move pointer (becouse n + should be a bit faster then n *)
                lea             rdx, [r15] ;actual res part
                lea             r15, [r15 + 8] ;move pointer

                mov             rcx, r14 ;length of long number for function

                call            custom_long_int_mul_short

                add             QWORD [rdx + r14 * 8], rax ;add сarry from rax

                inc             rbx
                jmp             .multiplier_of_numbers



.success:
                pop             r15
                pop             r14
                pop             r13
                pop             r12
                pop             rbx

                ret


custom_long_int_mul_short:
                push            rdx ;save register value
                mov             r8, rdx
                xor             r11, r11 ;mov 0 to carry

.custom_multiplication:
                mov             rax, [rdi] ;actual part of muliplier
                mul             rsi ;rdx:rax = rax * rsi

                add             rax, r11 ;add carry from previus cycle step
                adc             rdx, 0 ; check carry from lower order digits

                add             [r8], rax;add old res
                adc             rdx, 0; renew carry
                mov             r11, rdx ;save carry for next cycle iteration

                add             r8, 8
                add             rdi, 8

                dec             rcx
                jnz             .custom_multiplication

                mov             rax, r11 ;return carry
                pop             rdx ;recover rdx
                ret
