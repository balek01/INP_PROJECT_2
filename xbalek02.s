; Autor reseni: Miroslav Bálek xbalek02
; Pocet cyklu k serazeni puvodniho retezce: 3574
; Pocet cyklu razeni sestupne serazeneho retezce: 4447
; Pocet cyklu razeni vzestupne serazeneho retezce: 272
; Pocet cyklu razeni retezce s vasim loginem: 816
; Implementovany radici algoritmus: Bubble Sort
; ------------------------------------------------

; DATA SEGMENT
                .data
; login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
; login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
; login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
 login:          .asciiz "xbalek02"            ; SEM DOPLNTE VLASTNI LOGIN
                                                ; A POUZE S TIMTO ODEVZDEJTE

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize - "funkce" print_string)

; CODE SEGMENT
                .text
main:
        
        
outer_loop:

        dadd $t1, $zero, $zero ; reset inner loop 
        daddi $t2, $zero, 1
        daddi $t3, $zero, 2
        dadd $a1, $zero, $zero ;not swaped
inner_loop:

        lb $a2, login($t1) ;arr[j]
        lb $a3, login($t2) ;arr[j + 1]
        lb $a0, login($t3) ;arr[j + 2]
        

        sub $t4, $a3, $a2 ; if need to swap
        bgez $t4, end_if
;if
       
        daddi $a1, $a1, 1 ;; is  swaped
        sb $a3, login($t1) ;;swap 
        sb $a2, login($t2) ;;swap 
        
end_if:

        beqz $a0, inc_outer_loop
        
        daddi $t1, $t1, 1 ;;inc
        daddi $t2, $t2, 1
        daddi $t3, $t3, 1
       
        b inner_loop

inc_outer_loop: 
        beqz $a1, end
        daddi $t0, $t0, 1
        b outer_loop;

end:

        daddi   r4, r0, login   ; vozrovy vypis: adresa login: do r4
        jal     print_string    ; vypis pomoci print_string - viz nize

        syscall 0   ; halt
print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
