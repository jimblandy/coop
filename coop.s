	.local initial_coop
        .comm initial_coop, 56, 8

	.global coop_current
        .data
        .align 8
        .type coop_current, @object
        .size coop_current, 8
coop_current:
        .quad initial_coop

        .text
        .p2align 4,,15
        .globl coop_start
        .type coop_start, @function
coop_start:
	# Save the creators's callee-saves registers in its coop struct.
	movq coop_current(%rip), %r11
        movq %rbp, 0(%r11)
	movq %rbx, 8(%r11)
	movq %r12, 16(%r11)
	movq %r13, 24(%r11)
	movq %r14, 32(%r11)
	movq %r15, 40(%r11)

	# Save the sending thread's stack pointer, and switch to the new
	# thread's stack.
	movq %rsp, 48(%r11)
        leaq (%rdi, %rsi), %rsp

        # Update the current coop thread pointer.
        movq %rdi, coop_current(%rip)

	# Call the start function.
        movq %r11, %rdi
        movq %rcx, %rsi
        call *%rdx

        # The start function should never return; die if it does.
        call abort

        .p2align 4,,15
        .globl coop_send
        .type coop_send, @function
coop_send:
	# Save the sender's callee-saves registers in its coop struct.
	movq coop_current(%rip), %r11
        movq %rbp, 0(%r11)
	movq %rbx, 8(%r11)
	movq %r12, 16(%r11)
	movq %r13, 24(%r11)
	movq %r14, 32(%r11)
	movq %r15, 40(%r11)

	# Save the sending thread's stack pointer.
	movq %rsp, 48(%r11)

        # Switch the current coop thread pointer.
        movq %rdi, coop_current(%rip)

	# Switch to the receiving thread's stack.
	movq 48(%rdi), %rsp

        # Load the recipient's callee-saves registers from its coop struct.
        movq 0(%rdi), %rbp
	movq 8(%rdi), %rbx
	movq 16(%rdi), %r12
	movq 24(%rdi), %r13
	movq 32(%rdi), %r14
	movq 40(%rdi), %r15

	# Return our pointer argument.
        movq %rsi, %rax
        retq

        .size coop_send, .-coop_send
