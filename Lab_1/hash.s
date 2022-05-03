.globl   hash_function
.type    hash_function,%function

// r0:    hash_table memory address
//
// r1:    string starting memory address
//        and also current char memory pointer
//
// r2:    has result memory address
// r3:    string character, charachter int ascii
//        and char hash value
//
// r4:    hash value
hash_function:                  // Function hash_function start
	.fnstart
	push{r4}                    // Push to the stack the registers r4
	
	mov r4, #0                  // r4 = 0,  zero the has result
	
	loop: 
		
		ldrb r3, [r1]           // r3 = mem[r1]  c = string[i]
		
		
		cmp r3, #90             // r3 == 90
		bgt not_number          // if r3 > 90 branch to not_number because it can't 
								// be neither a number nor a capital letter
		
		cmp r3, #65             // r3 == 65      compare char with 65
		blt not_capital         // if r3 < 65 branch to not_capital 
	
		                        
								// r3 register is reused since there is no need
								// to save the char read from memory
								
		sub r3, r3, #65         // r3 = r3 - 65       c -= 65
		lsl r3, r3, #2          // r3 = r3 * 4        reading int from memory
		ldr r3, [r0, r3]        // r3 = mem[r0 + r3]  c = hash_value
		add r4, r4, r3          // r4 = r4 + r3       h += hash_table[c - 65]
		
		                        // Here r1 initial value is lost but for this
								// function this value is not needed
								
		add r1, #1              // r1 = r1 + 1    str pointer points to the next char
		b loop                  // There is no need to check if c == 0 because 
		                        // c was a capital english letter
		
		not_capital:
		
			cmp r3, #48         // r3 == 48      compare char with 48
			blt not_number      // if r3 < 48 branch to not_number
		
			cmp r3, #57         // r3 == 57
			bgt not_number      // if r3 > 57 branch to not_number
			
			                    // r3 register is reused since there is no need
								// to save the char read from memory
								
			sub r3, #48         // r3 = r3 - 48    converts the ascii char to int
			sub r4, r4, r3      // r4 = r4 - r3    h -= c - 48
			add r1, #1          // r1 = r1 + 1     str pointer points to the next char
			b loop              // There is no need to check if c == 0 because 
								// c was a number
			
		not_number:
		
			cmp r3, #0          // r3 == 0      if c == '\0'
			beq exit            // if c == '\0' exit
			
			                    // if c was not 0 add 1 to the counter and loop
			add r1, #1          // r1 = r1 + 1  str pointer points to the next char
			b loop              // There is no need to check if c == 0 because 
								// c was a number
	
	exit:
		
		str r4, [r2]            // Store the hash result to the memory
		mov r0, r2              // return the memory address the r4 was stored
		
		ldr r0, =string         // printf first argument (string)
		mov r1, r4              // printf second argument (hash value)
		
		push{lr}                // store the return address register

		bl printf               // branch and link printf
		
		pop{lr}                 // restore the return address register
		
	pop{r4}                     // Pop from the stack the registers r4
	bx     lr                   // Return by branching to the address in the link register.
    
	.fnend

.data
string:
	.asciz "Hash value: %d\n"