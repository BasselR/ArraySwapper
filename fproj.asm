%include "simple_io.inc"
global asm_main
extern rperm

section .data
        array: dq 1,2,3,4,5,6,7,8
        prompt1: db 'enter a,b to swap',10,0
        prompt2: db '0 to terminate ',0
        a1: db "The first value is not 1..8",10,0
        a2: db "No comma separates the values",10,0
        a3: db "Second value is not 1..8",10,0

        spaces: db "          ",0
	t1: db "     +    ",0
	t2: db "     ++   ",0
	t3: db "    +-+   ",0
	t4: db "    +--+  ",0
	t5: db "   +---+  ",0
	t6: db "   +----+ ",0
	t7: db "  +-----+ ",0
	t8: db "  +------+",0

	b1: db "     +    ",0
	b2: db "     ++   ",0
	b3: db "    + +   ",0
	b4: db "    +  +  ",0
	b5: db "   +   +  ",0
	b6: db "   +    + ",0
	b7: db "  +     + ",0
	b8: db "  +      +",0

        f1: db ".....+....",0
	f2: db ".....++...",0
	f3: db "....+-+...",0
	f4: db "....+--+..",0
	f5: db "...+---+..",0
	f6: db "...+----+.",0
	f7: db "..+-----+.",0
	f8: db "..+------+",0

	n1: db "     1    ",0
	n2: db "     2    ",0
	n3: db "     3    ",0
	n4: db "     4    ",0
	n5: db "     5    ",0
	n6: db "     6    ",0
	n7: db "     7    ",0
	n8: db "     8    ",0

	

section .text

;;
;;              Have to call displayLoop at somepoint
;;

display:
        enter 0,0
        saveregs

		mov r14, [rbp + 16] ; size / level
		mov r13, [rbp + 24] ; array

                jmp displayLoop

newLine:
        dec r14         ; drop down by 1 line
        sub r13, 64     ; reset array pointer to point at initial value
        mov rbx, qword 1
        call print_nl
        jmp displayLoop

displayLoop:
        cmp r14, qword 1
        je print_floors         ;this will print floors, print numbers, then terminate program
        ;otherwise, loop through levels

        innerLoop:

                cmp rbx, qword 8
                jg newLine

                mov r15, [r13] ; storing the current array position in r15 for use in print functions

                cmp r14, [r13]
                je print_tops

                cmp r14, [r13]
                jg print_spaces

                cmp r14, [r13]
                jl print_bodies

                shiftRight: 
                        add r13, 8
                        inc rbx
                        jmp innerLoop



print_spaces:
        mov rax, spaces
        call print_string
        jmp shiftRight

print_bodies:
        cmp r15, qword 1
        je pb1
        cmp r15, qword 2
        je pb2
        cmp r15, qword 3
        je pb3
        cmp r15, qword 4
        je pb4
        cmp r15, qword 5
        je pb5
        cmp r15, qword 6
        je pb6
        cmp r15, qword 7
        je pb7
        cmp r15, qword 8
        je pb8

        ;sub r15, 64 ;reset array to point to first element again

        ;jmp shiftRight

print_tops:
        cmp r15, qword 1
        je pt1
        cmp r15, qword 2
        je pt2
        cmp r15, qword 3
        je pt3
        cmp r15, qword 4
        je pt4
        cmp r15, qword 5
        je pt5
        cmp r15, qword 6
        je pt6
        cmp r15, qword 7
        je pt7
        cmp r15, qword 8
        je pt8

        ;sub r15, 64 ;reset array to point to first element again

        ;jmp shiftRight

print_floors:
        mov r15, [r13]

        cmp r15, qword 1
        je pf1
        cmp r15, qword 2
        je pf2
        cmp r15, qword 3
        je pf3
        cmp r15, qword 4
        je pf4
        cmp r15, qword 5
        je pf5
        cmp r15, qword 6
        je pf6
        cmp r15, qword 7
        je pf7
        cmp r15, qword 8
        je pf8

        sub r13, 64 ;reset array to point to first element again

        call print_nl

        jmp print_numbers    

print_numbers:
        mov r15, [r13]

        cmp r15, qword 1
        je pn1
        cmp r15, qword 2
        je pn2
        cmp r15, qword 3
        je pn3
        cmp r15, qword 4
        je pn4
        cmp r15, qword 5
        je pn5
        cmp r15, qword 6
        je pn6
        cmp r15, qword 7
        je pn7
        cmp r15, qword 8
        je pn8

        call print_nl
        jmp displaydone

displaydone:
        restoregs
        leave   
        ret

;tops
pt1:
        mov rax, t1
        call print_string
        jmp shiftRight

pt2:
        mov rax, t2
        call print_string
        jmp shiftRight

pt3:
        mov rax, t3
        call print_string
        jmp shiftRight

pt4:
        mov rax, t4
        call print_string
        jmp shiftRight

pt5:
        mov rax, t5
        call print_string
        jmp shiftRight

pt6:
        mov rax, t6
        call print_string
        jmp shiftRight

pt7:
        mov rax, t7
        call print_string
        jmp shiftRight

pt8:
        mov rax, t8
        call print_string
        jmp shiftRight

; BODIES

pb1:
        mov rax, b1
        call print_string
        jmp shiftRight

pb2:
        mov rax, b2
        call print_string
        jmp shiftRight

pb3:
        mov rax, b3
        call print_string
        jmp shiftRight

pb4:
        mov rax, b4
        call print_string
        jmp shiftRight

pb5:
        mov rax, b5
        call print_string
        jmp shiftRight

pb6:
        mov rax, b6
        call print_string
        jmp shiftRight

pb7:
        mov rax, b7
        call print_string
        jmp shiftRight

pb8:
        mov rax, b8
        call print_string
        jmp shiftRight

;floors
pf1:
        mov rax, f1
        call print_string
        add r13, 8
        jmp print_floors

pf2:
        mov rax, f2
        call print_string
        add r13, 8
        jmp print_floors

pf3:
        mov rax, f3
        call print_string
        add r13, 8
        jmp print_floors

pf4:
        mov rax, f4
        call print_string
        add r13, 8
        jmp print_floors

pf5:
        mov rax, f5
        call print_string
        add r13, 8
        jmp print_floors

pf6:
        mov rax, f6
        call print_string
        add r13, 8
        jmp print_floors

pf7:
        mov rax, f7
        call print_string
        add r13, 8
        jmp print_floors

pf8:
        mov rax, f8
        call print_string
        add r13, 8
        jmp print_floors

;numbers

pn1:
        mov rax, n1
        call print_string
        add r13, 8
        jmp print_numbers

pn2:
        mov rax, n2
        call print_string
        add r13, 8
        jmp print_numbers

pn3:
        mov rax, n3
        call print_string
        add r13, 8
        jmp print_numbers

pn4:
        mov rax, n4
        call print_string
        add r13, 8
        jmp print_numbers

pn5:
        mov rax, n5
        call print_string
        add r13, 8
        jmp print_numbers

pn6:
        mov rax, n6
        call print_string
        add r13, 8
        jmp print_numbers

pn7:
        mov rax, n7
        call print_string
        add r13, 8
        jmp print_numbers

pn8:
        mov rax, n8
        call print_string
        add r13, 8
        jmp print_numbers

asm_main:
    enter 0,0
        saveregs

        mov rdi, array
        mov rsi, 8
        call rperm ;random permutation

        mov rbx, qword 1

        mov r12, array; adress of array in r12
        push r12
        mov r13, qword 8; counter for levels
        push r13

        call display

prompt:
        mov rax, prompt1
        call print_string
        mov rax, prompt2
        call print_string

read:
        call read_char
        cmp al, '0'
        je asm_main_end
        cmp al, '1'
        jb error1
        cmp al, '8'
        ja error1

        mov r12, 0
        mov r12b, al
        sub r12b, '0'

        call read_char
        cmp al, ','
        jne error2

        call read_char
        cmp al, '1'
        jb error3
        cmp al, '8'
        ja error3

        mov r13, 0
        mov r13b, al
        sub r13b, '0'

        mov r14, array

LOOP1:
        cmp [r14], r12
        je LOOP2
        add r14, 8
        jmp LOOP1
LOOP2:
        mov r15, array
LOOP3:
        cmp [r15], r13
        je LOOP4
        add r15, 8
        jmp LOOP3
LOOP4:
        mov [r14], r13
        mov [r15], r12
        call display
        jmp L1

error1:
        call print_nl
        mov rax, a1
        call print_string
        ;;empty input buffer (new line has ASCII 10)

        mov r12, array; adress of array in r12
        push r12
        mov r13, qword 8; counter for levels
        push r13
        call display

        L1:
            cmp al,10
                je L2
                call read_char
                jmp L1
        L2:
            jmp prompt


error2:
        call print_nl
        mov rax, a2
        call print_string
        ;;empty input buffer

        mov r12, array; adress of array in r12
        push r12
        mov r13, qword 8; counter for levels
        push r13
        call display

        K1:
            cmp al,10
                je K2
                call read_char
                jmp K1
        K2:
            jmp prompt

error3:
        call print_nl
        mov rax, a3
        call print_string
        ;;empty input buffer

        mov r12, array; adress of array in r12
        push r12
        mov r13, qword 8; counter for levels
        push r13
        call display

        J1:
            cmp al,10
                je J2
                call read_char
                jmp J1
        J2:
            jmp prompt

asm_main_end:
    restoregs
    leave
    ret