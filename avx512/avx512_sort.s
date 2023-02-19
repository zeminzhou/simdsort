	.file	"avx512_sort.cpp"
	.intel_syntax noprefix
	.text
	.p2align 4
	.type	_ZL12do_partitionPmS_llm, @function
_ZL12do_partitionPmS_llm:
	push	rbp
	vpbroadcastq	zmm0, r8
	lea	r10, 1[rcx]
	lea	r8, 15[rdx]
	lea	rax, 0[0+rdx*8]
	sub	rcx, 7
	lea	r9, 8[rdx]
	lea	r11, [rsi+rax]
	vmovdqu64	zmm3, ZMMWORD PTR [rdi+rcx*8]
	vmovdqu64	zmm5, ZMMWORD PTR [rsi+rcx*8]
	mov	rbp, rsp
	push	r14
	lea	r14, [rdi+rax]
	push	r13
	push	r12
	push	rbx
	vmovdqu64	zmm4, ZMMWORD PTR [r14]
	vmovdqu64	zmm6, ZMMWORD PTR [r11]
	cmp	rcx, r8
	jle	.L11
	.p2align 4,,10
	.p2align 3
.L3:
	mov	r14, r9
	mov	r12, r10
	lea	r8, 0[0+r9*8]
	sub	r14, rdx
	lea	rbx, [rdi+r8]
	lea	r13, [rsi+r8]
	sub	r12, rcx
	lea	rax, 0[0+rdx*8]
	lea	r11, [rdi+rax]
	add	rax, rsi
	cmp	r14, r12
	jg	.L5
	vmovdqu64	zmm1, ZMMWORD PTR [rbx]
	vmovdqu64	zmm2, ZMMWORD PTR 0[r13]
	add	r8, 64
	lea	r12, 8[r9]
	add	r9, 15
	lea	r13, [rsi+r8]
	vpcmpuq	k1, zmm1, zmm0, 1
	kmovw	ebx, k1
	movzx	ebx, bl
	vpcompressq	ZMMWORD PTR [r11]{k1}, zmm1
	popcnt	ebx, ebx
	movsx	rbx, ebx
	vpcompressq	ZMMWORD PTR [rax]{k1}, zmm2
	kmovw	eax, k1
	lea	r10, -8[r10+rbx]
	not	eax
	add	rdx, rbx
	kmovw	k1, eax
	lea	rax, 0[0+r10*8]
	lea	rbx, [rdi+r8]
	vpcompressq	ZMMWORD PTR [rdi+rax]{k1}, zmm1
	vpcompressq	ZMMWORD PTR [rsi+rax]{k1}, zmm2
	cmp	r9, rcx
	jge	.L6
	mov	r9, r12
	jmp	.L3
	.p2align 4,,10
	.p2align 3
.L5:
	sub	rcx, 8
	vmovdqu64	zmm1, ZMMWORD PTR [rdi+rcx*8]
	vmovdqu64	zmm2, ZMMWORD PTR [rsi+rcx*8]
	vpcmpuq	k1, zmm1, zmm0, 2
	kmovw	r14d, k1
	movzx	r8d, r14b
	vpcompressq	ZMMWORD PTR [r11]{k1}, zmm1
	popcnt	r8d, r8d
	movsx	r8, r8d
	vpcompressq	ZMMWORD PTR [rax]{k1}, zmm2
	kmovw	eax, k1
	lea	r10, -8[r10+r8]
	not	eax
	add	rdx, r8
	kmovw	k1, eax
	lea	rax, 0[0+r10*8]
	vpcompressq	ZMMWORD PTR [rdi+rax]{k1}, zmm1
	vpcompressq	ZMMWORD PTR [rsi+rax]{k1}, zmm2
	lea	rax, 7[r9]
	cmp	rcx, rax
	jg	.L3
	mov	r12, r9
.L6:
	lea	r11, 0[0+rdx*8]
	lea	r14, [rdi+r11]
	add	r11, rsi
.L4:
	vmovdqu64	zmm1, ZMMWORD PTR [rbx]
	sub	rcx, r12
	mov	r8d, 255
	vmovdqu64	zmm2, ZMMWORD PTR 0[r13]
	sal	r8d, cl
	vpcmpuq	k1, zmm4, zmm0, 1
	vpcmpuq	k0, zmm1, zmm0, 2
	mov	r9d, r8d
	mov	ecx, r8d
	not	r9d
	kmovw	eax, k0
	and	r9d, eax
	or	ecx, eax
	not	ecx
	movzx	eax, r9b
	kmovw	k2, r9d
	vpcompressq	ZMMWORD PTR [r14]{k2}, zmm1
	movzx	r8d, cl
	popcnt	eax, eax
	cdqe
	kmovw	k4, ecx
	add	rdx, rax
	popcnt	r8d, r8d
	movsx	rax, r8d
	vpcompressq	ZMMWORD PTR [r11]{k2}, zmm2
	sub	r10, rax
	lea	rcx, 0[0+rdx*8]
	lea	rax, 0[0+r10*8]
	vpcompressq	ZMMWORD PTR [rdi+rax]{k4}, zmm1
	vpcompressq	ZMMWORD PTR [rsi+rax]{k4}, zmm2
	kmovw	eax, k1
	movzx	eax, al
	popcnt	eax, eax
	cdqe
	vpcompressq	ZMMWORD PTR [rdi+rcx]{k1}, zmm4
	add	rdx, rax
	lea	r8, -8[rax+r10]
	kmovw	eax, k1
	not	eax
	vpcompressq	ZMMWORD PTR [rsi+rcx]{k1}, zmm6
	kmovw	k1, eax
	lea	rax, 0[0+r8*8]
	lea	rcx, 0[0+rdx*8]
	vpcompressq	ZMMWORD PTR [rdi+rax]{k1}, zmm4
	vpcompressq	ZMMWORD PTR [rsi+rax]{k1}, zmm6
	vpcmpuq	k1, zmm3, zmm0, 2
	kmovw	eax, k1
	movzx	eax, al
	vpcompressq	ZMMWORD PTR [rdi+rcx]{k1}, zmm3
	kmovw	ebx, k1
	popcnt	eax, eax
	cdqe
	vpcompressq	ZMMWORD PTR [rsi+rcx]{k1}, zmm5
	not	ebx
	lea	rcx, -8[rax+r8]
	kmovw	k1, ebx
	add	rax, rdx
	sal	rcx, 3
	vpcompressq	ZMMWORD PTR [rdi+rcx]{k1}, zmm3
	vpcompressq	ZMMWORD PTR [rsi+rcx]{k1}, zmm5
	vzeroupper
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	rbp
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	add	rax, 64
	mov	r12, r9
	lea	rbx, [rdi+rax]
	lea	r13, [rsi+rax]
	jmp	.L4
	.size	_ZL12do_partitionPmS_llm, .-_ZL12do_partitionPmS_llm
	.section	.text._Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_,"axG",@progbits,_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_,comdat
	.p2align 4
	.weak	_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	.type	_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_, @function
_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_:
	endbr64
	push	rbp
	vmovdqa64	zmm7, ZMMWORD PTR [rdx]
	mov	r11d, -16
	vpminuq	zmm3, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm2, ZMMWORD PTR [r8]
	kmovw	k4, r11d
	mov	r11d, -52
	vpmaxuq	zmm1, zmm7, ZMMWORD PTR [rdi]
	kmovw	k3, r11d
	mov	r11d, -86
	mov	rbp, rsp
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rdi], 0
	kmovw	k2, r11d
	mov	r10, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 24[rbp]
	vmovdqa64	zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r8], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [rdx], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm1
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vpminuq	zmm3, zmm6, ZMMWORD PTR [rsi]
	vmovdqa64	zmm2, ZMMWORD PTR [r9]
	vmovdqa64	zmm0, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rsi], 0
	vpmaxuq	zmm1, zmm6, ZMMWORD PTR [rsi]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r9], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm2
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm1
	vmovdqa64	zmm6, ZMMWORD PTR [rsi]
	vpminuq	zmm3, zmm6, ZMMWORD PTR [rdi]
	vpmaxuq	zmm1, zmm6, ZMMWORD PTR [rdi]
	vmovdqa64	zmm2, ZMMWORD PTR [r8]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r8], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm2
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm1
	vmovdqa64	zmm1, ZMMWORD PTR [rdi]
	vpermq	zmm3, zmm2, zmm1
	vpminuq	zmm0, zmm3, zmm1
	vpmaxuq	zmm0{k4}, zmm3, zmm1
	vpcmpuq	k1, zmm0, zmm1, 0
	vpermq	zmm1, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm1
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm0
	vpermq	zmm4, zmm1, zmm0
	vpminuq	zmm3, zmm4, zmm0
	vpmaxuq	zmm3{k3}, zmm4, zmm0
	vpcmpuq	k1, zmm3, zmm0, 0
	vpermq	zmm0, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpermq	zmm5, zmm0, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vpminuq	zmm6, zmm6, ZMMWORD PTR [rdx]
	vmovdqa64	zmm5, ZMMWORD PTR [r10]
	vmovdqa64	zmm3, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rdx], 0
	vmovdqa64	zmm7, ZMMWORD PTR [rcx]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r10]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r10]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm2, zmm4
	vpermq	zmm2, zmm2, ZMMWORD PTR [rax]
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k4}, zmm5, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rax]
	vpermq	zmm4, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [rax], zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k3}, zmm4, zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpermq	zmm1, zmm1, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [rax]
	vpermq	zmm3, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rax], zmm1
	vpminuq	zmm1, zmm3, zmm2
	vpmaxuq	zmm1{k2}, zmm3, zmm2
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vpermq	zmm0, zmm0, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm0
	vmovdqa64	ZMMWORD PTR [rcx], zmm1
	vzeroupper
	pop	rbp
	ret
	.size	_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_, .-_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	.section	.text._Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_,"axG",@progbits,_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_,comdat
	.p2align 4
	.weak	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	.type	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_, @function
_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r15
	mov	r15, r8
	push	r14
	push	r13
	push	r12
	push	rbx
	mov	rbx, rdx
	and	rsp, -64
	mov	r11, QWORD PTR 32[rbp]
	vmovdqa64	zmm7, ZMMWORD PTR [r15]
	vpminuq	zmm3, zmm7, ZMMWORD PTR [rdi]
	vpmaxuq	zmm1, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm2, ZMMWORD PTR [r11]
	mov	r11, QWORD PTR 64[rbp]
	mov	rax, QWORD PTR 88[rbp]
	mov	r10, QWORD PTR 56[rbp]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm0, ZMMWORD PTR [r11]
	mov	r11, QWORD PTR 32[rbp]
	mov	r8, QWORD PTR 72[rbp]
	mov	rdx, QWORD PTR 80[rbp]
	mov	r13, QWORD PTR 40[rbp]
	mov	r12, QWORD PTR 48[rbp]
	vmovdqa64	zmm0{k1}, zmm2
	mov	r14, QWORD PTR 16[rbp]
	vmovdqa64	ZMMWORD PTR [r11], zmm0
	mov	r11, QWORD PTR 64[rbp]
	vpcmpuq	k1, zmm1, ZMMWORD PTR [r15], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r11]
	vmovdqa64	ZMMWORD PTR [r11], zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm1
	vmovdqa64	zmm7, ZMMWORD PTR [r9]
	vpminuq	zmm3, zmm7, ZMMWORD PTR [rsi]
	vmovdqa64	zmm2, ZMMWORD PTR 0[r13]
	vmovdqa64	zmm0, ZMMWORD PTR [r8]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rsi], 0
	vpmaxuq	zmm1, zmm7, ZMMWORD PTR [rsi]
	mov	r11, QWORD PTR 24[rbp]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR 0[r13], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [r9], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm2
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm1
	vmovdqa64	zmm7, ZMMWORD PTR [r14]
	vpminuq	zmm3, zmm7, ZMMWORD PTR [rbx]
	vmovdqa64	zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm0, ZMMWORD PTR [rdx]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rbx], 0
	vpmaxuq	zmm1, zmm7, ZMMWORD PTR [rbx]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r12], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [r14], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rdx]
	vmovdqa64	ZMMWORD PTR [rdx], zmm2
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm1
	vmovdqa64	zmm7, ZMMWORD PTR [r11]
	vpminuq	zmm3, zmm7, ZMMWORD PTR [rcx]
	vmovdqa64	zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm0, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rcx], 0
	vpmaxuq	zmm1, zmm7, ZMMWORD PTR [rcx]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r10], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [r11], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm2
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vmovdqa64	ZMMWORD PTR [r11], zmm1
	vmovdqa64	zmm6, ZMMWORD PTR [rbx]
	vpminuq	zmm3, zmm6, ZMMWORD PTR [rdi]
	mov	r11, QWORD PTR 32[rbp]
	vmovdqa64	zmm0, ZMMWORD PTR [r12]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rdi], 0
	vpmaxuq	zmm1, zmm6, ZMMWORD PTR [rdi]
	vmovdqa64	zmm2, ZMMWORD PTR [r11]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r11], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [rbx], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm1
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vpminuq	zmm3, zmm6, ZMMWORD PTR [rsi]
	vmovdqa64	zmm2, ZMMWORD PTR 0[r13]
	vmovdqa64	zmm0, ZMMWORD PTR [r10]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rsi], 0
	vpmaxuq	zmm1, zmm6, ZMMWORD PTR [rsi]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR 0[r13], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm2
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm1
	vmovdqa64	zmm6, ZMMWORD PTR [rsi]
	vpminuq	zmm3, zmm6, ZMMWORD PTR [rdi]
	vpmaxuq	zmm1, zmm6, ZMMWORD PTR [rdi]
	vmovdqa64	zmm2, ZMMWORD PTR [r11]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm0, ZMMWORD PTR 0[r13]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r11], zmm0
	mov	r11d, -16
	vpcmpuq	k1, zmm1, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR 0[r13]
	kmovw	k4, r11d
	mov	r11, QWORD PTR 32[rbp]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm2
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm1
	vmovdqa64	zmm1, ZMMWORD PTR [rdi]
	vmovdqa64	zmm6, ZMMWORD PTR [r11]
	vpermq	zmm3, zmm2, zmm1
	vpminuq	zmm0, zmm3, zmm1
	vpmaxuq	zmm0{k4}, zmm3, zmm1
	vpcmpuq	k1, zmm0, zmm1, 0
	vpermq	zmm1, zmm2, zmm6
	vmovdqa64	zmm1{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [r11], zmm1
	mov	r11d, -52
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	kmovw	k3, r11d
	mov	r11, QWORD PTR 32[rbp]
	vmovdqa64	ZMMWORD PTR [rdi], zmm0
	vpermq	zmm4, zmm1, zmm0
	vpminuq	zmm3, zmm4, zmm0
	vmovdqa64	zmm6, ZMMWORD PTR [r11]
	vpmaxuq	zmm3{k3}, zmm4, zmm0
	vpcmpuq	k1, zmm3, zmm0, 0
	vpermq	zmm0, zmm1, zmm6
	vmovdqa64	zmm0{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [r11], zmm0
	mov	r11d, -86
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	kmovw	k2, r11d
	mov	r11, QWORD PTR 32[rbp]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpermq	zmm5, zmm0, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vmovdqa64	zmm6, ZMMWORD PTR [r11]
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, zmm6
	vmovdqa64	zmm3{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [r11], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR 0[r13]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR 0[r13]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR 0[r13]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR 0[r13]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR 0[r13]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR 0[r13]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vpminuq	zmm6, zmm6, ZMMWORD PTR [rbx]
	vmovdqa64	zmm5, ZMMWORD PTR [r12]
	vmovdqa64	zmm3, ZMMWORD PTR [r10]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rbx], 0
	vmovdqa64	zmm7, ZMMWORD PTR [rcx]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm5
	vmovdqa64	ZMMWORD PTR [rbx], zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r10]
	vpermq	zmm5, zmm1, zmm4
	mov	rbx, QWORD PTR 64[rbp]
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r10]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [r14]
	vpminuq	zmm6, zmm6, ZMMWORD PTR [r15]
	vmovdqa64	zmm5, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3, ZMMWORD PTR [rdx]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [r15], 0
	vmovdqa64	zmm7, ZMMWORD PTR [r14]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [r15]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	mov	rbx, QWORD PTR 24[rbp]
	vpcmpuq	k1, zmm4, ZMMWORD PTR [r14], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rdx]
	vmovdqa64	ZMMWORD PTR [rdx], zmm5
	vmovdqa64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [rbx]
	vpminuq	zmm6, zmm6, ZMMWORD PTR [r9]
	vmovdqa64	zmm7, ZMMWORD PTR [rbx]
	vmovdqa64	zmm5, ZMMWORD PTR [r8]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [r9]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [r9], 0
	vmovdqa64	zmm3, ZMMWORD PTR [rax]
	mov	rcx, QWORD PTR 64[rbp]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rbx], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	ZMMWORD PTR [r9], zmm6
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [r9]
	vpminuq	zmm6, zmm6, ZMMWORD PTR [r15]
	vmovdqa64	zmm5, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3, ZMMWORD PTR [r8]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [r15], 0
	vmovdqa64	zmm7, ZMMWORD PTR [r9]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [r15]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [r9], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm5
	vmovdqa64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r15]
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, zmm6
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	zmm3{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm5, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm6
	vmovdqa64	zmm4{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm3
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, zmm6
	vmovdqa64	ZMMWORD PTR -64[rsp], zmm6
	vmovdqa64	zmm3{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r9]
	mov	rsi, QWORD PTR 24[rbp]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [rsi]
	vpminuq	zmm6, zmm6, ZMMWORD PTR [r14]
	vmovdqa64	zmm5, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [r14], 0
	vmovdqa64	zmm7, ZMMWORD PTR [rsi]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [r14]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	ZMMWORD PTR [r14], zmm6
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r14]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rdx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rdx]
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm2, zmm4
	vpermq	zmm2, zmm2, ZMMWORD PTR [rax]
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k4}, zmm5, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rax]
	vpermq	zmm4, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [rax], zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k3}, zmm4, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpermq	zmm1, zmm1, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [rax]
	vpermq	zmm3, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rax], zmm1
	vpminuq	zmm1, zmm3, zmm2
	vpmaxuq	zmm1{k2}, zmm3, zmm2
	vmovdqa64	ZMMWORD PTR [rsi], zmm2
	vpermq	zmm0, zmm0, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm0
	vmovdqa64	ZMMWORD PTR [rsi], zmm1
	vzeroupper
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_, .-_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	.section	.text._Z15bitonic_sort_2vRDv8_xS0_S0_S0_,"axG",@progbits,_Z15bitonic_sort_2vRDv8_xS0_S0_S0_,comdat
	.p2align 4
	.weak	_Z15bitonic_sort_2vRDv8_xS0_S0_S0_
	.type	_Z15bitonic_sort_2vRDv8_xS0_S0_S0_, @function
_Z15bitonic_sort_2vRDv8_xS0_S0_S0_:
	endbr64
	vmovdqa64	zmm1, ZMMWORD PTR [rdi]
	mov	eax, 102
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	kmovw	k7, eax
	mov	eax, 60
	vpermq	zmm3, zmm0, zmm1
	kmovw	k6, eax
	mov	eax, 90
	vpminuq	zmm2, zmm3, zmm1
	kmovw	k5, eax
	mov	eax, -16
	vpmaxuq	zmm2{k7}, zmm3, zmm1
	kmovw	k4, eax
	mov	eax, -52
	vpcmpuq	k1, zmm2, zmm1, 0
	vpermq	zmm1, zmm0, ZMMWORD PTR [rdx]
	kmovw	k3, eax
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [rdx]
	mov	eax, -86
	vmovdqa64	ZMMWORD PTR [rdx], zmm1
	kmovw	k2, eax
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm2
	vpermq	zmm4, zmm1, zmm2
	vpminuq	zmm3, zmm4, zmm2
	vpmaxuq	zmm3{k6}, zmm4, zmm2
	vpcmpuq	k1, zmm3, zmm2, 0
	vpermq	zmm2, zmm1, ZMMWORD PTR [rdx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rdx]
	vpermq	zmm4, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k5}, zmm4, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpcmpuq	k1, zmm2, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rdx]
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vmovdqa64	zmm3, ZMMWORD PTR .LC0[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm2
	vpermq	zmm5, zmm3, zmm2
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k4}, zmm5, zmm2
	vpcmpuq	k1, zmm4, zmm2, 0
	vpermq	zmm2, zmm3, ZMMWORD PTR [rdx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm2
	vpminuq	zmm2, zmm5, zmm4
	vpmaxuq	zmm2{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm2, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rdx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k2}, zmm5, zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm2
	vpcmpuq	k1, zmm4, zmm2, 0
	vpermq	zmm2, zmm0, ZMMWORD PTR [rdx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rdx]
	vmovdqa64	ZMMWORD PTR [rdx], zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm2, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm0, zmm2
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k7}, zmm5, zmm2
	vpcmpuq	k1, zmm4, zmm2, 0
	vpermq	zmm2, zmm0, ZMMWORD PTR [rcx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vpminuq	zmm2, zmm5, zmm4
	vpmaxuq	zmm2{k6}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm2, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rcx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k5}, zmm5, zmm2
	vmovdqa64	ZMMWORD PTR [rsi], zmm2
	vpcmpuq	k1, zmm4, zmm2, 0
	vpermq	zmm2, zmm0, ZMMWORD PTR [rcx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm3, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vpminuq	zmm2, zmm5, zmm4
	vpmaxuq	zmm2{k4}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm2, zmm4, 0
	vpermq	zmm4, zmm3, ZMMWORD PTR [rcx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm1, zmm2
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k3}, zmm5, zmm2
	vmovdqa64	ZMMWORD PTR [rsi], zmm2
	vpcmpuq	k1, zmm4, zmm2, 0
	vpermq	zmm2, zmm1, ZMMWORD PTR [rcx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vpminuq	zmm2, zmm5, zmm4
	vpmaxuq	zmm2{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm2, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [rcx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rcx]
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR .LC3[rip]
	vmovdqa64	ZMMWORD PTR [rsi], zmm2
	vpermq	zmm2, zmm4, zmm2
	vpmaxuq	zmm5, zmm2, ZMMWORD PTR [rdi]
	vpminuq	zmm6, zmm2, ZMMWORD PTR [rdi]
	vpermq	zmm4, zmm4, ZMMWORD PTR [rcx]
	vpcmpuq	k1, zmm5, zmm2, 0
	vmovdqa64	zmm2, ZMMWORD PTR [rdx]
	vmovdqa64	zmm2{k1}, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rdx]
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm6
	vmovdqa64	ZMMWORD PTR [rsi], zmm5
	vmovdqa64	zmm2, ZMMWORD PTR [rdi]
	vpermq	zmm5, zmm3, zmm2
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k4}, zmm5, zmm2
	vpcmpuq	k1, zmm4, zmm2, 0
	vpermq	zmm2, zmm3, ZMMWORD PTR [rdx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm2
	vpminuq	zmm2, zmm5, zmm4
	vpmaxuq	zmm2{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm2, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rdx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k2}, zmm5, zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm2
	vpcmpuq	k1, zmm4, zmm2, 0
	vpermq	zmm2, zmm0, ZMMWORD PTR [rdx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rdx]
	vmovdqa64	ZMMWORD PTR [rdx], zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm2, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm3, zmm2
	vpermq	zmm3, zmm3, ZMMWORD PTR [rcx]
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k4}, zmm5, zmm2
	vpcmpuq	k1, zmm4, zmm2, 0
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rcx]
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpermq	zmm3, zmm1, zmm4
	vpminuq	zmm2, zmm3, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpermq	zmm1, zmm1, ZMMWORD PTR [rcx]
	vpmaxuq	zmm2{k3}, zmm3, zmm4
	vpcmpuq	k1, zmm2, zmm4, 0
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm3, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rcx], zmm1
	vpminuq	zmm1, zmm3, zmm2
	vpmaxuq	zmm1{k2}, zmm3, zmm2
	vmovdqa64	ZMMWORD PTR [rsi], zmm2
	vpermq	zmm0, zmm0, ZMMWORD PTR [rcx]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [rcx]
	vmovdqa64	ZMMWORD PTR [rcx], zmm0
	vmovdqa64	ZMMWORD PTR [rsi], zmm1
	vzeroupper
	ret
	.size	_Z15bitonic_sort_2vRDv8_xS0_S0_S0_, .-_Z15bitonic_sort_2vRDv8_xS0_S0_S0_
	.section	.text._Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_,"axG",@progbits,_Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_,comdat
	.p2align 4
	.weak	_Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_
	.type	_Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_, @function
_Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_:
	endbr64
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vmovdqa64	zmm1, ZMMWORD PTR [rdi]
	mov	eax, 102
	kmovw	k7, eax
	mov	eax, 60
	vpermq	zmm2, zmm0, zmm1
	kmovw	k6, eax
	mov	eax, 90
	vpminuq	zmm3, zmm2, zmm1
	kmovw	k5, eax
	mov	eax, -16
	vpmaxuq	zmm3{k7}, zmm2, zmm1
	kmovw	k4, eax
	mov	eax, -52
	vpcmpuq	k1, zmm3, zmm1, 0
	vpermq	zmm1, zmm0, ZMMWORD PTR [rcx]
	kmovw	k3, eax
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [rcx]
	mov	eax, -86
	vmovdqa64	ZMMWORD PTR [rcx], zmm1
	kmovw	k2, eax
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpermq	zmm4, zmm1, zmm3
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k6}, zmm4, zmm3
	vpcmpuq	k1, zmm2, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm4, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpminuq	zmm3, zmm4, zmm2
	vpmaxuq	zmm3{k5}, zmm4, zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm2
	vpcmpuq	k1, zmm3, zmm2, 0
	vpermq	zmm2, zmm0, ZMMWORD PTR [rcx]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rcx]
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rcx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rcx]
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm0, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k7}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k6}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k5}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm2, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k4}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm5, ZMMWORD PTR .LC3[rip]
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpermq	zmm3, zmm5, zmm3
	vpmaxuq	zmm4, zmm3, ZMMWORD PTR [rdi]
	vpminuq	zmm7, zmm3, ZMMWORD PTR [rdi]
	vpermq	zmm6, zmm5, ZMMWORD PTR [r8]
	vpcmpuq	k1, zmm4, zmm3, 0
	vmovdqa64	zmm3, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k1, zmm7, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm6{k1}, ZMMWORD PTR [rcx]
	vmovdqa64	ZMMWORD PTR [rcx], zmm6
	vmovdqa64	ZMMWORD PTR [rdi], zmm7
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdi]
	vpermq	zmm6, zmm2, zmm3
	vpminuq	zmm4, zmm6, zmm3
	vpmaxuq	zmm4{k4}, zmm6, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm6, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpminuq	zmm3, zmm6, zmm4
	vpmaxuq	zmm3{k3}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rcx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm6, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpminuq	zmm4, zmm6, zmm3
	vpmaxuq	zmm4{k2}, zmm6, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rcx]
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm6, zmm2, zmm3
	vpminuq	zmm4, zmm6, zmm3
	vpmaxuq	zmm4{k4}, zmm6, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm6, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm6, zmm4
	vpmaxuq	zmm3{k3}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm6, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm6, zmm3
	vpmaxuq	zmm4{k2}, zmm6, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdx]
	vpermq	zmm6, zmm0, zmm3
	vpminuq	zmm4, zmm6, zmm3
	vpmaxuq	zmm4{k7}, zmm6, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vpermq	zmm6, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm6, zmm4
	vpmaxuq	zmm3{k6}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm6, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm6, zmm3
	vpmaxuq	zmm4{k5}, zmm6, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vpermq	zmm6, zmm2, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm6, zmm4
	vpmaxuq	zmm3{k4}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm6, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm6, zmm3
	vpmaxuq	zmm4{k3}, zmm6, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm6, zmm4
	vpmaxuq	zmm3{k2}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpermq	zmm3, zmm5, zmm3
	vpmaxuq	zmm4, zmm3, ZMMWORD PTR [rsi]
	vpminuq	zmm6, zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm5, ZMMWORD PTR [r9]
	vpcmpuq	k1, zmm4, zmm3, 0
	vmovdqa64	zmm3, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm5
	vmovdqa64	ZMMWORD PTR [rsi], zmm6
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rsi]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdi]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm5, ZMMWORD PTR [rcx]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm3, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm5
	vmovdqa64	ZMMWORD PTR [rdi], zmm6
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rcx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rcx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rcx]
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm2, zmm4
	vpermq	zmm2, zmm2, ZMMWORD PTR [r9]
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k4}, zmm5, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r9]
	vpermq	zmm4, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k3}, zmm4, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpermq	zmm1, zmm1, ZMMWORD PTR [r9]
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [r9]
	vpermq	zmm3, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [r9], zmm1
	vpminuq	zmm1, zmm3, zmm2
	vpmaxuq	zmm1{k2}, zmm3, zmm2
	vmovdqa64	ZMMWORD PTR [rdx], zmm2
	vpermq	zmm0, zmm0, ZMMWORD PTR [r9]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm0
	vmovdqa64	ZMMWORD PTR [rdx], zmm1
	vzeroupper
	ret
	.size	_Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_, .-_Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_
	.section	.text._Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_,"axG",@progbits,_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_,comdat
	.p2align 4
	.weak	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	.type	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_, @function
_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_:
	endbr64
	vmovdqa64	zmm1, ZMMWORD PTR [rdi]
	mov	r11d, 102
	push	rbp
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	kmovw	k7, r11d
	mov	r11d, 60
	kmovw	k6, r11d
	mov	r11d, 90
	vpermq	zmm2, zmm0, zmm1
	kmovw	k5, r11d
	mov	r11d, -16
	mov	rbp, rsp
	vpminuq	zmm3, zmm2, zmm1
	kmovw	k4, r11d
	mov	r10, QWORD PTR 16[rbp]
	mov	rax, QWORD PTR 24[rbp]
	vpmaxuq	zmm3{k7}, zmm2, zmm1
	mov	r11d, -52
	vpcmpuq	k1, zmm3, zmm1, 0
	vpermq	zmm1, zmm0, ZMMWORD PTR [r8]
	kmovw	k3, r11d
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [r8]
	mov	r11d, -86
	vmovdqa64	ZMMWORD PTR [r8], zmm1
	kmovw	k2, r11d
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpermq	zmm4, zmm1, zmm3
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k6}, zmm4, zmm3
	vpcmpuq	k1, zmm2, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm4, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm4, zmm2
	vpmaxuq	zmm3{k5}, zmm4, zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm2
	vpcmpuq	k1, zmm3, zmm2, 0
	vpermq	zmm2, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm2
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm0, zmm4
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k7}, zmm5, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k6}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k5}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm2, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vmovdqa64	zmm3, ZMMWORD PTR .LC3[rip]
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpermq	zmm6, zmm3, ZMMWORD PTR [r9]
	vpermq	zmm4, zmm3, zmm4
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR [rdi]
	vpminuq	zmm7, zmm4, ZMMWORD PTR [rdi]
	vpcmpuq	k1, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpcmpuq	k1, zmm7, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm6{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm6
	vmovdqa64	ZMMWORD PTR [rdi], zmm7
	vmovdqa64	ZMMWORD PTR [rsi], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR [rdi]
	vpermq	zmm6, zmm2, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k4}, zmm6, zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k3}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rdi], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r8]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k2}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR [rsi]
	vpermq	zmm6, zmm2, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k4}, zmm6, zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k3}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rsi], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r9]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k2}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR [rdx]
	vpermq	zmm6, zmm0, zmm5
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k7}, zmm6, zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r10]
	vpermq	zmm6, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r10], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k6}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r10]
	vpermq	zmm6, zmm0, zmm5
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k5}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r10]
	vpermq	zmm6, zmm2, zmm4
	vmovdqa64	ZMMWORD PTR [r10], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k4}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r10]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k3}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r10]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r10], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k2}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR [rcx]
	vpermq	zmm6, zmm0, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k7}, zmm6, zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [rax]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k6}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rcx], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [rax]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k5}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [rax]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm2, zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k4}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rcx], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm2, ZMMWORD PTR [rax]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k3}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rax]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm0, zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k2}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rcx], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm0, ZMMWORD PTR [rax]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpermq	zmm4, zmm3, zmm4
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR [rdx]
	vpminuq	zmm7, zmm4, ZMMWORD PTR [rdx]
	vpermq	zmm6, zmm3, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpcmpuq	k1, zmm7, ZMMWORD PTR [rdx], 0
	vmovdqa64	zmm6{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm6
	vmovdqa64	ZMMWORD PTR [rdx], zmm7
	vmovdqa64	ZMMWORD PTR [rcx], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR [rdx]
	vpermq	zmm6, zmm2, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k4}, zmm6, zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r10]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k3}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r10]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r10], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k2}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR [rcx]
	vpermq	zmm6, zmm2, zmm5
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k4}, zmm6, zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm2, ZMMWORD PTR [rax]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k3}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rax]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm0, zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k2}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rcx], zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm0, ZMMWORD PTR [rax]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpermq	zmm4, zmm3, zmm4
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR [rdi]
	vpminuq	zmm7, zmm4, ZMMWORD PTR [rdi]
	vpermq	zmm6, zmm3, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpcmpuq	k1, zmm7, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm6{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm6
	vmovdqa64	ZMMWORD PTR [rdi], zmm7
	vmovdqa64	ZMMWORD PTR [rcx], zmm5
	vpermq	zmm4, zmm3, ZMMWORD PTR [rdx]
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR [rsi]
	vpminuq	zmm6, zmm4, ZMMWORD PTR [rsi]
	vpermq	zmm3, zmm3, ZMMWORD PTR [r10]
	vpcmpuq	k1, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, zmm3
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm6
	vmovdqa64	ZMMWORD PTR [rdx], zmm5
	vmovdqa64	zmm7, ZMMWORD PTR [rsi]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm5, ZMMWORD PTR [r8]
	vmovdqa64	zmm3, ZMMWORD PTR [r9]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rdi], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm5
	vmovdqa64	ZMMWORD PTR [rdi], zmm6
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rcx]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdx]
	vmovdqa64	zmm5, ZMMWORD PTR [r10]
	vmovdqa64	zmm3, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rdx], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r10]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r10]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm2, zmm4
	vpermq	zmm2, zmm2, ZMMWORD PTR [rax]
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k4}, zmm5, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rax]
	vpermq	zmm4, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [rax], zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k3}, zmm4, zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpermq	zmm1, zmm1, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [rax]
	vpermq	zmm3, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rax], zmm1
	vpminuq	zmm1, zmm3, zmm2
	vpmaxuq	zmm1{k2}, zmm3, zmm2
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vpermq	zmm0, zmm0, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm0
	vmovdqa64	ZMMWORD PTR [rcx], zmm1
	vzeroupper
	pop	rbp
	ret
	.size	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_, .-_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	.section	.text._Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_,"axG",@progbits,_Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_,comdat
	.p2align 4
	.weak	_Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	.type	_Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_, @function
_Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_:
	endbr64
	lea	r10, 8[rsp]
	and	rsp, -64
	push	QWORD PTR -8[r10]
	push	rbp
	mov	rbp, rsp
	push	r15
	mov	r15, rcx
	push	r14
	mov	r14, r9
	push	r13
	mov	r13, r8
	push	r12
	push	r10
	push	rbx
	sub	rsp, 64
	mov	r11, QWORD PTR 16[r10]
	mov	rax, QWORD PTR 24[r10]
	mov	QWORD PTR -72[rbp], rdx
	mov	r12, QWORD PTR 32[r10]
	mov	rbx, QWORD PTR 40[r10]
	mov	QWORD PTR -64[rbp], rsi
	mov	r8, QWORD PTR [r10]
	mov	r9, QWORD PTR 8[r10]
	push	rax
	push	r11
	mov	QWORD PTR -104[rbp], rax
	mov	QWORD PTR -96[rbp], r11
	mov	QWORD PTR -88[rbp], r9
	mov	QWORD PTR -80[rbp], r8
	mov	QWORD PTR -56[rbp], rdi
	call	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	vmovdqa64	zmm1, ZMMWORD PTR 0[r13]
	mov	eax, 102
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	kmovw	k7, eax
	mov	eax, 60
	vpermq	zmm2, zmm0, zmm1
	kmovw	k6, eax
	mov	eax, 90
	vpminuq	zmm3, zmm2, zmm1
	kmovw	k5, eax
	mov	eax, -16
	vpmaxuq	zmm3{k7}, zmm2, zmm1
	kmovw	k4, eax
	mov	eax, -52
	vpcmpuq	k1, zmm3, zmm1, 0
	vpermq	zmm1, zmm0, ZMMWORD PTR [r12]
	kmovw	k3, eax
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [r12]
	mov	eax, -86
	vmovdqa64	ZMMWORD PTR [r12], zmm1
	kmovw	k2, eax
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpermq	zmm4, zmm1, zmm3
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k6}, zmm4, zmm3
	vpcmpuq	k1, zmm2, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vpermq	zmm4, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm4, zmm2
	vpmaxuq	zmm3{k5}, zmm4, zmm2
	vmovdqa64	ZMMWORD PTR 0[r13], zmm2
	vpcmpuq	k1, zmm3, zmm2, 0
	vpermq	zmm2, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm2
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r14]
	vpermq	zmm5, zmm0, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k7}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k6}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k5}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm2, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k4}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR .LC3[rip]
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpermq	zmm6, zmm4, ZMMWORD PTR [rbx]
	vpermq	zmm3, zmm4, zmm3
	vpmaxuq	zmm5, zmm3, ZMMWORD PTR 0[r13]
	vpminuq	zmm7, zmm3, ZMMWORD PTR 0[r13]
	vpcmpuq	k1, zmm5, zmm3, 0
	vmovdqa64	zmm3, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpcmpuq	k1, zmm7, ZMMWORD PTR 0[r13], 0
	vmovdqa64	zmm6{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm6
	vmovdqa64	ZMMWORD PTR 0[r13], zmm7
	vmovdqa64	ZMMWORD PTR [r14], zmm5
	vmovdqa64	zmm3, ZMMWORD PTR 0[r13]
	vpermq	zmm6, zmm2, zmm3
	vpminuq	zmm5, zmm6, zmm3
	vpmaxuq	zmm5{k4}, zmm6, zmm3
	vpcmpuq	k1, zmm5, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vpermq	zmm6, zmm1, zmm5
	mov	rdx, QWORD PTR -72[rbp]
	mov	r11, QWORD PTR -96[rbp]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm6, zmm5
	vpmaxuq	zmm3{k3}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vpcmpuq	k1, zmm3, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r12]
	vpermq	zmm6, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r12], zmm5
	vpminuq	zmm5, zmm6, zmm3
	vpmaxuq	zmm5{k2}, zmm6, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpcmpuq	k1, zmm5, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR [r14]
	vpermq	zmm6, zmm2, zmm5
	vpminuq	zmm3, zmm6, zmm5
	vpmaxuq	zmm3{k4}, zmm6, zmm5
	vpcmpuq	k1, zmm3, zmm5, 0
	vpermq	zmm5, zmm2, ZMMWORD PTR [rbx]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm6, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm5
	vpminuq	zmm5, zmm6, zmm3
	vpmaxuq	zmm5{k3}, zmm6, zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpcmpuq	k1, zmm5, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm6, zmm0, zmm5
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpminuq	zmm3, zmm6, zmm5
	vpmaxuq	zmm3{k2}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [r14], zmm5
	vpcmpuq	k1, zmm3, zmm5, 0
	vpermq	zmm5, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm5
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpermq	zmm3, zmm4, zmm3
	vpmaxuq	zmm5, zmm3, ZMMWORD PTR [rdx]
	vpminuq	zmm7, zmm3, ZMMWORD PTR [rdx]
	vpermq	zmm6, zmm4, ZMMWORD PTR [rbx]
	vpcmpuq	k1, zmm5, zmm3, 0
	vmovdqa64	zmm3, ZMMWORD PTR [r11]
	vmovdqa64	zmm3{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpcmpuq	k1, zmm7, ZMMWORD PTR [rdx], 0
	mov	rax, QWORD PTR -104[rbp]
	mov	rdi, QWORD PTR -56[rbp]
	vmovdqa64	zmm6{k1}, ZMMWORD PTR [r11]
	mov	r8, QWORD PTR -80[rbp]
	vmovdqa64	ZMMWORD PTR [r11], zmm6
	vmovdqa64	ZMMWORD PTR [rdx], zmm7
	vmovdqa64	ZMMWORD PTR [r14], zmm5
	vpermq	zmm3, zmm4, ZMMWORD PTR 0[r13]
	vpmaxuq	zmm5, zmm3, ZMMWORD PTR [r15]
	vpminuq	zmm6, zmm3, ZMMWORD PTR [r15]
	vpermq	zmm4, zmm4, ZMMWORD PTR [r12]
	vpcmpuq	k1, zmm5, zmm3, 0
	vmovdqa64	zmm3, ZMMWORD PTR [rax]
	vmovdqa64	zmm3{k1}, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpcmpuq	k1, zmm6, ZMMWORD PTR [r15], 0
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vmovdqa64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vmovdqa64	zmm7, ZMMWORD PTR [rdx]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm5, ZMMWORD PTR [r8]
	vmovdqa64	zmm3, ZMMWORD PTR [r11]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rdi], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rdx], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r11]
	vmovdqa64	ZMMWORD PTR [r11], zmm5
	vmovdqa64	ZMMWORD PTR [rdi], zmm6
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [r15]
	mov	rsi, QWORD PTR -64[rbp]
	mov	r9, QWORD PTR -88[rbp]
	vmovdqa64	zmm3, ZMMWORD PTR [rax]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rsi]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rsi]
	vmovdqa64	zmm5, ZMMWORD PTR [r9]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [r15], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	ZMMWORD PTR [rsi], zmm6
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rsi]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm5, ZMMWORD PTR [r8]
	vmovdqa64	zmm3, ZMMWORD PTR [r9]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rdi], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm5
	vmovdqa64	ZMMWORD PTR [rdi], zmm6
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [r15]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdx]
	vmovdqa64	zmm5, ZMMWORD PTR [r11]
	vmovdqa64	zmm3, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [rdx], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r11], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [r15], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm6
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r11]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r11]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r11], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r11]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r11]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r11], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r11]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r11]
	vmovdqa64	ZMMWORD PTR [r11], zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r15]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [rax]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rax]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rax]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rax]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rax]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [r14]
	vpminuq	zmm6, zmm7, ZMMWORD PTR 0[r13]
	vmovdqa64	zmm5, ZMMWORD PTR [r12]
	vmovdqa64	zmm3, ZMMWORD PTR [rbx]
	vpcmpuq	k1, zmm6, ZMMWORD PTR 0[r13], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR 0[r13]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [r14], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm5
	vmovdqa64	ZMMWORD PTR 0[r13], zmm6
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR 0[r13]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR [r14]
	vpermq	zmm5, zmm2, zmm4
	vpermq	zmm2, zmm2, ZMMWORD PTR [rbx]
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k4}, zmm5, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm4, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k3}, zmm4, zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpermq	zmm1, zmm1, ZMMWORD PTR [rbx]
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [rbx]
	vpermq	zmm3, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [rbx], zmm1
	vpminuq	zmm1, zmm3, zmm2
	vpmaxuq	zmm1{k2}, zmm3, zmm2
	vmovdqa64	ZMMWORD PTR [r14], zmm2
	vpermq	zmm0, zmm0, ZMMWORD PTR [rbx]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm0
	pop	rax
	pop	rdx
	vmovdqa64	ZMMWORD PTR [r14], zmm1
	vzeroupper
	lea	rsp, -48[rbp]
	pop	rbx
	pop	r10
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	lea	rsp, -8[r10]
	ret
	.size	_Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_, .-_Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	.section	.text._Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_,"axG",@progbits,_Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_,comdat
	.p2align 4
	.weak	_Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	.type	_Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_, @function
_Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_:
	endbr64
	lea	r10, 8[rsp]
	and	rsp, -64
	push	QWORD PTR -8[r10]
	push	rbp
	mov	rbp, rsp
	push	r15
	mov	r15, r10
	push	r14
	mov	r14, r8
	push	r13
	mov	r13, r9
	push	r12
	push	r10
	push	rbx
	add	rsp, -128
	mov	rax, QWORD PTR [r10]
	mov	r8, QWORD PTR 8[r10]
	mov	QWORD PTR -80[rbp], rcx
	mov	r9, QWORD PTR 16[r10]
	mov	r11, QWORD PTR 32[r15]
	mov	QWORD PTR -72[rbp], rdx
	mov	r10, QWORD PTR 24[r10]
	mov	rbx, QWORD PTR 48[r15]
	mov	QWORD PTR -120[rbp], rax
	mov	r12, QWORD PTR 40[r15]
	mov	r15, QWORD PTR 56[r15]
	push	r11
	push	r10
	mov	QWORD PTR -112[rbp], r11
	mov	QWORD PTR -104[rbp], r10
	mov	QWORD PTR -96[rbp], r9
	mov	QWORD PTR -88[rbp], r8
	mov	QWORD PTR -64[rbp], rsi
	mov	QWORD PTR -56[rbp], rdi
	call	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	vmovdqa64	zmm1, ZMMWORD PTR [r14]
	mov	eax, 102
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	kmovw	k7, eax
	mov	eax, 60
	vpermq	zmm2, zmm0, zmm1
	kmovw	k6, eax
	mov	eax, 90
	vpminuq	zmm3, zmm2, zmm1
	kmovw	k5, eax
	mov	eax, -16
	vpmaxuq	zmm3{k7}, zmm2, zmm1
	kmovw	k3, eax
	mov	eax, -52
	vpcmpuq	k1, zmm3, zmm1, 0
	vpermq	zmm1, zmm0, ZMMWORD PTR [r12]
	kmovw	k2, eax
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [r12]
	mov	eax, -86
	vmovdqa64	ZMMWORD PTR [r12], zmm1
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpermq	zmm4, zmm1, zmm3
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k6}, zmm4, zmm3
	vpcmpuq	k1, zmm2, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vpermq	zmm4, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm4, zmm2
	vpmaxuq	zmm3{k5}, zmm4, zmm2
	vmovdqa64	ZMMWORD PTR [r14], zmm2
	vpcmpuq	k1, zmm3, zmm2, 0
	vpermq	zmm2, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm2
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm0, zmm3
	kmovw	k1, eax
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k1}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR 0[r13]
	vpermq	zmm5, zmm0, zmm4
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k7}, zmm5, zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k6}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm1, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k5}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm2, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k1}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vmovdqa64	zmm3, ZMMWORD PTR .LC3[rip]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpermq	zmm6, zmm3, ZMMWORD PTR [rbx]
	vpermq	zmm4, zmm3, zmm4
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR [r14]
	vpminuq	zmm7, zmm4, ZMMWORD PTR [r14]
	vpcmpuq	k4, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k4}, zmm6
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpcmpuq	k4, zmm7, ZMMWORD PTR [r14], 0
	vmovdqa64	zmm6{k4}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm6
	vmovdqa64	ZMMWORD PTR [r14], zmm7
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR [r14]
	vpermq	zmm6, zmm2, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k3}, zmm6, zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r12]
	vpermq	zmm6, zmm1, zmm5
	mov	rax, QWORD PTR -120[rbp]
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k2}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [r14], zmm5
	vpcmpuq	k4, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r12]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k1}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR 0[r13]
	vpermq	zmm6, zmm2, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k3}, zmm6, zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k2}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vpcmpuq	k4, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [rbx]
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k1}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm0, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k7}, zmm6, zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r15]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r15]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k6}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vpcmpuq	k4, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r15]
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r15]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r15], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k5}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r15]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r15]
	vpermq	zmm6, zmm2, zmm5
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k3}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vpcmpuq	k4, zmm4, zmm5, 0
	vpermq	zmm5, zmm2, ZMMWORD PTR [r15]
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r15]
	vpermq	zmm6, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r15], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k2}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r15]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r15]
	vpermq	zmm6, zmm0, zmm5
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k1}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vpcmpuq	k4, zmm4, zmm5, 0
	vpermq	zmm5, zmm0, ZMMWORD PTR [r15]
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r15]
	vmovdqa64	ZMMWORD PTR [r15], zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpermq	zmm4, zmm3, zmm4
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR 0[r13]
	vpminuq	zmm7, zmm4, ZMMWORD PTR 0[r13]
	vpermq	zmm6, zmm3, ZMMWORD PTR [r15]
	vpcmpuq	k4, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, zmm6
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vpcmpuq	k4, zmm7, ZMMWORD PTR 0[r13], 0
	vmovdqa64	zmm6{k4}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm6
	vmovdqa64	ZMMWORD PTR 0[r13], zmm7
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	zmm7, ZMMWORD PTR 0[r13]
	vpminuq	zmm7, zmm7, ZMMWORD PTR [r14]
	vmovdqa64	zmm6, ZMMWORD PTR 0[r13]
	vpmaxuq	zmm5, zmm6, ZMMWORD PTR [r14]
	vpcmpuq	k4, zmm7, ZMMWORD PTR [r14], 0
	vmovdqa64	zmm6, ZMMWORD PTR [r12]
	vmovdqa64	zmm4, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, zmm6
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpcmpuq	k4, zmm5, ZMMWORD PTR 0[r13], 0
	vmovdqa64	zmm6{k4}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm6
	vmovdqa64	ZMMWORD PTR [r14], zmm7
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR [r14]
	vpermq	zmm6, zmm2, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k3}, zmm6, zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r12]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k2}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [r14], zmm5
	vpcmpuq	k4, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r12]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k1}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR 0[r13]
	vpermq	zmm6, zmm2, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k3}, zmm6, zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k2}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vpcmpuq	k4, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [rbx]
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k1}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [rbx]
	mov	rcx, QWORD PTR -80[rbp]
	mov	r11, QWORD PTR -112[rbp]
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	mov	rdx, QWORD PTR -72[rbp]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vmovdqa64	zmm4, ZMMWORD PTR [rax]
	vpermq	zmm6, zmm2, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k3}, zmm6, zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR [r15]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r15]
	vpermq	zmm6, zmm1, zmm5
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vpminuq	zmm4, zmm6, zmm5
	vpmaxuq	zmm4{k2}, zmm6, zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vpcmpuq	k4, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, ZMMWORD PTR [r15]
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r15]
	vpermq	zmm6, zmm0, zmm4
	vmovdqa64	ZMMWORD PTR [r15], zmm5
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k1}, zmm6, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpcmpuq	k4, zmm5, zmm4, 0
	vpermq	zmm4, zmm0, ZMMWORD PTR [r15]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r15]
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vpermq	zmm4, zmm3, ZMMWORD PTR [r14]
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR [rcx]
	vpermq	zmm6, zmm3, ZMMWORD PTR [r12]
	vpminuq	zmm7, zmm4, ZMMWORD PTR [rcx]
	vpcmpuq	k4, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [r11]
	vmovdqa64	zmm4{k4}, zmm6
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpcmpuq	k4, zmm7, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm6{k4}, ZMMWORD PTR [r11]
	vmovdqa64	ZMMWORD PTR [r11], zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm7
	vmovdqa64	ZMMWORD PTR [r14], zmm5
	vpermq	zmm4, zmm3, ZMMWORD PTR 0[r13]
	vpminuq	zmm7, zmm4, ZMMWORD PTR [rdx]
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR [rdx]
	mov	r10, QWORD PTR -104[rbp]
	vpermq	zmm6, zmm3, ZMMWORD PTR [rbx]
	mov	rsi, QWORD PTR -64[rbp]
	vpcmpuq	k4, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [r10]
	mov	r9, QWORD PTR -96[rbp]
	mov	rdi, QWORD PTR -56[rbp]
	mov	r8, QWORD PTR -88[rbp]
	vmovdqa64	zmm4{k4}, zmm6
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpcmpuq	k4, zmm7, ZMMWORD PTR [rdx], 0
	vmovdqa64	zmm6{k4}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm6
	vmovdqa64	ZMMWORD PTR [rdx], zmm7
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vpermq	zmm4, zmm3, ZMMWORD PTR [rax]
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR [rsi]
	vpminuq	zmm6, zmm4, ZMMWORD PTR [rsi]
	vpermq	zmm3, zmm3, ZMMWORD PTR [r15]
	vpcmpuq	k4, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k4}, zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vpcmpuq	k4, zmm6, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm6
	vmovdqa64	ZMMWORD PTR [rax], zmm5
	vmovdqa64	zmm7, ZMMWORD PTR [rdx]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm5, ZMMWORD PTR [r8]
	vmovdqa64	zmm3, ZMMWORD PTR [r10]
	vpcmpuq	k4, zmm6, ZMMWORD PTR [rdi], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm3{k4}, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k4, zmm4, ZMMWORD PTR [rdx], 0
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm5
	vmovdqa64	ZMMWORD PTR [rdi], zmm6
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rcx]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rsi]
	vmovdqa64	zmm5, ZMMWORD PTR [r9]
	vmovdqa64	zmm3, ZMMWORD PTR [r11]
	vpcmpuq	k4, zmm6, ZMMWORD PTR [rsi], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rsi]
	vmovdqa64	zmm3{k4}, zmm5
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpcmpuq	k4, zmm4, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r11]
	vmovdqa64	ZMMWORD PTR [r11], zmm5
	vmovdqa64	ZMMWORD PTR [rsi], zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rsi]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm5, ZMMWORD PTR [r8]
	vmovdqa64	zmm3, ZMMWORD PTR [r9]
	vpcmpuq	k4, zmm6, ZMMWORD PTR [rdi], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdi]
	vmovdqa64	zmm3{k4}, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k4, zmm4, ZMMWORD PTR [rsi], 0
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm5
	vmovdqa64	ZMMWORD PTR [rdi], zmm6
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r8]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k1}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r8]
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r9]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r9]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k1}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r9]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r9]
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rcx]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [rdx]
	vmovdqa64	zmm5, ZMMWORD PTR [r10]
	vmovdqa64	zmm3, ZMMWORD PTR [r11]
	vpcmpuq	k4, zmm6, ZMMWORD PTR [rdx], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3{k4}, zmm5
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vpcmpuq	k4, zmm4, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r11]
	vmovdqa64	ZMMWORD PTR [r11], zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r10]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r10]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r10], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k1}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r11]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r11]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r11], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r11]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r11]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r11], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k1}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r11]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r11]
	vmovdqa64	ZMMWORD PTR [r11], zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rax]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [r14]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [r14]
	vmovdqa64	zmm5, ZMMWORD PTR [r12]
	vpcmpuq	k4, zmm6, ZMMWORD PTR [r14], 0
	vmovdqa64	zmm3, ZMMWORD PTR [r15]
	vmovdqa64	zmm3{k4}, zmm5
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpcmpuq	k4, zmm4, ZMMWORD PTR [rax], 0
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [r15]
	vmovdqa64	ZMMWORD PTR [r15], zmm5
	vmovdqa64	ZMMWORD PTR [r14], zmm6
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR 0[r13]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [r14]
	vmovdqa64	zmm5, ZMMWORD PTR [r12]
	vmovdqa64	zmm3, ZMMWORD PTR [rbx]
	vpcmpuq	k4, zmm6, ZMMWORD PTR [r14], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [r14]
	vmovdqa64	zmm3{k4}, zmm5
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpcmpuq	k4, zmm4, ZMMWORD PTR 0[r13], 0
	vmovdqa64	zmm5{k4}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm5
	vmovdqa64	ZMMWORD PTR [r14], zmm6
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r14]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k1}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR 0[r13]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k3}, zmm5, zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k2}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vpcmpuq	k4, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rbx]
	vmovdqa64	zmm4{k4}, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k1}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm3
	vpcmpuq	k4, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rbx]
	vmovdqa64	zmm3{k4}, ZMMWORD PTR [rbx]
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR [rax]
	vpermq	zmm5, zmm2, zmm4
	vpermq	zmm2, zmm2, ZMMWORD PTR [r15]
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vpcmpuq	k3, zmm3, zmm4, 0
	vmovdqa64	zmm2{k3}, ZMMWORD PTR [r15]
	vpermq	zmm4, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k2}, zmm4, zmm3
	vmovdqa64	ZMMWORD PTR [rax], zmm3
	vpermq	zmm1, zmm1, ZMMWORD PTR [r15]
	vpcmpuq	k2, zmm2, zmm3, 0
	vmovdqa64	zmm1{k2}, ZMMWORD PTR [r15]
	vpermq	zmm3, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR [r15], zmm1
	vpminuq	zmm1, zmm3, zmm2
	vpmaxuq	zmm1{k1}, zmm3, zmm2
	vmovdqa64	ZMMWORD PTR [rax], zmm2
	vpermq	zmm0, zmm0, ZMMWORD PTR [r15]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [r15]
	vmovdqa64	ZMMWORD PTR [r15], zmm0
	vmovdqa64	ZMMWORD PTR [rax], zmm1
	pop	rax
	pop	rdx
	vzeroupper
	lea	rsp, -48[rbp]
	pop	rbx
	pop	r10
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	lea	rsp, -8[r10]
	ret
	.size	_Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_, .-_Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	.section	.text._Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_,"axG",@progbits,_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_,comdat
	.p2align 4
	.weak	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	.type	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_, @function
_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_:
	endbr64
	lea	r10, 8[rsp]
	and	rsp, -64
	mov	r11, rdx
	push	QWORD PTR -8[r10]
	push	rbp
	mov	rbp, rsp
	push	r15
	mov	r15, rsi
	push	r14
	push	r13
	mov	r13, r10
	push	r12
	push	r10
	push	rbx
	mov	rbx, rcx
	sub	rsp, 256
	mov	r12, QWORD PTR 40[r13]
	mov	r14, QWORD PTR 32[r13]
	mov	QWORD PTR -176[rbp], r8
	mov	rax, QWORD PTR [r10]
	mov	rdx, QWORD PTR 48[r13]
	mov	QWORD PTR -184[rbp], r9
	mov	rcx, QWORD PTR 8[r10]
	mov	rsi, QWORD PTR 56[r13]
	mov	QWORD PTR -232[rbp], r11
	mov	r10, QWORD PTR 16[r10]
	mov	QWORD PTR -192[rbp], rax
	mov	QWORD PTR -208[rbp], rdx
	mov	rax, QWORD PTR 24[r13]
	mov	rdx, QWORD PTR 64[r13]
	mov	r13, QWORD PTR 72[r13]
	push	r12
	mov	r8, r10
	push	r14
	mov	r9, rax
	mov	QWORD PTR -200[rbp], rcx
	mov	rcx, rbx
	mov	QWORD PTR -216[rbp], rsi
	mov	rsi, r15
	mov	QWORD PTR -224[rbp], rdx
	mov	rdx, r11
	mov	QWORD PTR -248[rbp], rax
	mov	QWORD PTR -240[rbp], r10
	mov	QWORD PTR -112[rbp], rdi
	call	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	push	r13
	mov	r9, QWORD PTR -216[rbp]
	push	QWORD PTR -224[rbp]
	mov	r8, QWORD PTR -208[rbp]
	mov	rcx, QWORD PTR -200[rbp]
	mov	rdx, QWORD PTR -192[rbp]
	mov	rsi, QWORD PTR -184[rbp]
	mov	rdi, QWORD PTR -176[rbp]
	call	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	mov	r11, QWORD PTR -176[rbp]
	add	rsp, 32
	vmovdqa64	zmm0, ZMMWORD PTR .LC3[rip]
	mov	r8, QWORD PTR -208[rbp]
	mov	rax, QWORD PTR -184[rbp]
	vpermq	zmm1, zmm0, ZMMWORD PTR [r11]
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR [rbx]
	vpminuq	zmm4, zmm1, ZMMWORD PTR [rbx]
	vpermq	zmm3, zmm0, ZMMWORD PTR [r8]
	vpcmpuq	k1, zmm2, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR [r12]
	mov	rsi, QWORD PTR -216[rbp]
	mov	r9, QWORD PTR -192[rbp]
	vmovdqa64	zmm1{k1}, zmm3
	vmovdqa64	ZMMWORD PTR [r8], zmm1
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rbx], 0
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vmovdqa64	ZMMWORD PTR [r11], zmm2
	mov	r11, QWORD PTR -232[rbp]
	vpermq	zmm1, zmm0, ZMMWORD PTR [rax]
	vpermq	zmm3, zmm0, ZMMWORD PTR [rsi]
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR [r11]
	vpminuq	zmm4, zmm1, ZMMWORD PTR [r11]
	vpcmpuq	k1, zmm2, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR [r14]
	vmovdqa64	zmm1{k1}, zmm3
	vmovdqa64	ZMMWORD PTR [rsi], zmm1
	vpcmpuq	k1, zmm4, ZMMWORD PTR [r11], 0
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vmovdqa64	ZMMWORD PTR [r11], zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm2
	vpermq	zmm1, zmm0, ZMMWORD PTR [r9]
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR [r15]
	vpminuq	zmm4, zmm1, ZMMWORD PTR [r15]
	mov	rdx, QWORD PTR -224[rbp]
	mov	rax, QWORD PTR -248[rbp]
	vpcmpuq	k1, zmm2, zmm1, 0
	mov	rdi, QWORD PTR -112[rbp]
	vpermq	zmm3, zmm0, ZMMWORD PTR [rdx]
	mov	rcx, QWORD PTR -200[rbp]
	vmovdqa64	zmm1, ZMMWORD PTR [rax]
	mov	r10, QWORD PTR -240[rbp]
	vmovdqa64	zmm1{k1}, zmm3
	vmovdqa64	ZMMWORD PTR [rdx], zmm1
	vpcmpuq	k1, zmm4, ZMMWORD PTR [r15], 0
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm2
	vpermq	zmm1, zmm0, ZMMWORD PTR [rcx]
	vmovdqa64	zmm7, ZMMWORD PTR [rdi]
	vpermq	zmm0, zmm0, ZMMWORD PTR 0[r13]
	vpmaxuq	zmm2, zmm1, zmm7
	vpminuq	zmm3, zmm1, zmm7
	vpcmpuq	k1, zmm2, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm1{k1}, zmm0
	vmovdqa64	ZMMWORD PTR 0[r13], zmm1
	vpcmpuq	k1, zmm3, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm0
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vmovdqa64	zmm7, ZMMWORD PTR [rdi]
	vpminuq	zmm3, zmm7, ZMMWORD PTR [r11]
	vmovdqa64	zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm0, ZMMWORD PTR [r14]
	vpcmpuq	k1, zmm3, zmm7, 0
	vpmaxuq	zmm1, zmm7, ZMMWORD PTR [r11]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r10], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [r11], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR [r14], zmm2
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	ZMMWORD PTR [r11], zmm1
	vmovdqa64	zmm7, ZMMWORD PTR [rbx]
	vpminuq	zmm3, zmm7, ZMMWORD PTR [r15]
	vmovdqa64	zmm2, ZMMWORD PTR [rax]
	vmovdqa64	zmm0, ZMMWORD PTR [r12]
	vpcmpuq	k1, zmm3, ZMMWORD PTR [r15], 0
	vpmaxuq	zmm1, zmm7, ZMMWORD PTR [r15]
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [rax], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [rbx], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm2
	vmovdqa64	ZMMWORD PTR [r15], zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm1
	vmovdqa64	zmm7, ZMMWORD PTR [rdi]
	vpminuq	zmm3, zmm7, ZMMWORD PTR [r15]
	vmovdqa64	zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm0, ZMMWORD PTR [rax]
	vpcmpuq	k1, zmm3, zmm7, 0
	vpmaxuq	zmm1, zmm7, ZMMWORD PTR [r15]
	vmovdqa64	ZMMWORD PTR -112[rbp], zmm7
	mov	QWORD PTR -112[rbp], rdi
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	ZMMWORD PTR [r10], zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR [r15], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm2
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm1
	vmovdqa64	zmm1, ZMMWORD PTR [rdi]
	mov	edi, -16
	kmovw	k4, edi
	mov	rdi, QWORD PTR -112[rbp]
	vpermq	zmm3, zmm2, zmm1
	vpminuq	zmm0, zmm3, zmm1
	vpmaxuq	zmm0{k4}, zmm3, zmm1
	vpcmpuq	k1, zmm0, zmm1, 0
	vpermq	zmm1, zmm2, ZMMWORD PTR [r10]
	vmovdqa64	zmm1{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm1
	vmovdqa64	ZMMWORD PTR [rdi], zmm0
	mov	edi, -52
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	kmovw	k3, edi
	mov	rdi, QWORD PTR -112[rbp]
	vpermq	zmm4, zmm1, zmm0
	vpminuq	zmm3, zmm4, zmm0
	vpmaxuq	zmm3{k3}, zmm4, zmm0
	vpcmpuq	k1, zmm3, zmm0, 0
	vpermq	zmm0, zmm1, ZMMWORD PTR [r10]
	vmovdqa64	zmm0{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	mov	edi, -86
	vpermq	zmm5, zmm0, zmm3
	kmovw	k2, edi
	mov	rdi, QWORD PTR -112[rbp]
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r10]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r10]
	vmovdqa64	ZMMWORD PTR [r10], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r15]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [rax]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rax]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [rax]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [rax]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [rax]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR [rax], zmm3
	vmovdqa64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rbx]
	vpminuq	zmm6, zmm7, ZMMWORD PTR [r11]
	vmovdqa64	zmm5, ZMMWORD PTR [r14]
	vmovdqa64	zmm3, ZMMWORD PTR [r12]
	vpcmpuq	k1, zmm6, ZMMWORD PTR [r11], 0
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR [r11]
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rbx], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [r12]
	mov	rax, QWORD PTR -176[rbp]
	vmovdqa64	ZMMWORD PTR [r12], zmm5
	vmovdqa64	ZMMWORD PTR [r11], zmm6
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r11]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r14]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r14]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r11], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r14]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r14]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r14], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r11], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r14]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR [r14], zmm3
	vmovdqa64	ZMMWORD PTR [r11], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rbx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, ZMMWORD PTR [r12]
	vmovdqa64	zmm4{k1}, ZMMWORD PTR [r12]
	vpermq	zmm5, zmm0, zmm3
	vmovdqa64	ZMMWORD PTR [r12], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, ZMMWORD PTR [r12]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR [r12]
	vmovdqa64	ZMMWORD PTR [r12], zmm3
	vmovdqa64	ZMMWORD PTR [rbx], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [rax]
	vmovdqa64	zmm5, ZMMWORD PTR [r8]
	vmovdqa64	zmm3, ZMMWORD PTR [rdx]
	mov	rdi, QWORD PTR -184[rbp]
	vmovdqa64	ZMMWORD PTR -112[rbp], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR [r9]
	vmovdqa64	zmm7, ZMMWORD PTR -112[rbp]
	vmovdqa64	ZMMWORD PTR -176[rbp], zmm6
	vpminuq	zmm6, zmm6, ZMMWORD PTR -112[rbp]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR -176[rbp]
	vpcmpuq	k1, zmm6, zmm7, 0
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [r9], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rdx]
	vmovdqa64	ZMMWORD PTR [rdx], zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm6
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [rdi]
	vmovdqa64	zmm5, ZMMWORD PTR [rsi]
	vmovdqa64	zmm3, ZMMWORD PTR 0[r13]
	vmovdqa64	ZMMWORD PTR -112[rbp], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vmovdqa64	zmm7, ZMMWORD PTR -112[rbp]
	vmovdqa64	ZMMWORD PTR -176[rbp], zmm6
	vpminuq	zmm6, zmm6, ZMMWORD PTR -112[rbp]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR -176[rbp]
	vpcmpuq	k1, zmm6, zmm7, 0
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR 0[r13]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vmovdqa64	ZMMWORD PTR [rdi], zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm6, ZMMWORD PTR [rax]
	vmovdqa64	ZMMWORD PTR -112[rbp], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR [rdi]
	vmovdqa64	zmm7, ZMMWORD PTR -112[rbp]
	vmovdqa64	zmm5, ZMMWORD PTR [r8]
	vmovdqa64	zmm3, ZMMWORD PTR [rsi]
	vmovdqa64	ZMMWORD PTR -176[rbp], zmm6
	vpminuq	zmm6, zmm6, ZMMWORD PTR -112[rbp]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR -176[rbp]
	vpcmpuq	k1, zmm6, zmm7, 0
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rdi], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR [rsi]
	vmovdqa64	ZMMWORD PTR [rsi], zmm5
	vmovdqa64	ZMMWORD PTR [rax], zmm6
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rax]
	vmovdqa64	zmm6, ZMMWORD PTR [r8]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, zmm6
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	zmm3{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [r8]
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm5, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm7
	vmovdqa64	zmm4{k1}, zmm7
	vmovdqa64	ZMMWORD PTR [r8], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rax], zmm3
	vmovdqa64	zmm7, ZMMWORD PTR [r8]
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, zmm7
	vmovdqa64	zmm3{k1}, zmm7
	vmovdqa64	ZMMWORD PTR [r8], zmm3
	vmovdqa64	ZMMWORD PTR [rax], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [rdi]
	vmovdqa64	zmm7, ZMMWORD PTR [rsi]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, zmm7
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	zmm3{k1}, zmm7
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rsi]
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm5, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm7
	vmovdqa64	zmm4{k1}, zmm7
	vmovdqa64	ZMMWORD PTR [rsi], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm3
	vmovdqa64	zmm7, ZMMWORD PTR [rsi]
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, zmm7
	vmovdqa64	zmm3{k1}, zmm7
	vmovdqa64	ZMMWORD PTR [rsi], zmm3
	vmovdqa64	ZMMWORD PTR [rdi], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [r9]
	vmovdqa64	zmm6, ZMMWORD PTR [rcx]
	vmovdqa64	zmm5, ZMMWORD PTR [rdx]
	vmovdqa64	zmm3, ZMMWORD PTR 0[r13]
	vmovdqa64	ZMMWORD PTR -112[rbp], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -112[rbp]
	vmovdqa64	ZMMWORD PTR -176[rbp], zmm6
	vpminuq	zmm6, zmm6, ZMMWORD PTR -112[rbp]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR -176[rbp]
	vpcmpuq	k1, zmm6, zmm7, 0
	vmovdqa64	zmm3{k1}, zmm5
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpcmpuq	k1, zmm4, ZMMWORD PTR [rcx], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR 0[r13]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm5
	vmovdqa64	ZMMWORD PTR [r9], zmm6
	vmovdqa64	ZMMWORD PTR [rcx], zmm4
	vmovdqa64	zmm3, ZMMWORD PTR [r9]
	vmovdqa64	zmm6, ZMMWORD PTR [rdx]
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm2, zmm6
	vpermq	zmm5, zmm1, zmm4
	vmovdqa64	zmm3{k1}, zmm6
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k3}, zmm5, zmm4
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vmovdqa64	zmm7, ZMMWORD PTR [rdx]
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm5, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm7
	vmovdqa64	zmm4{k1}, zmm7
	vmovdqa64	ZMMWORD PTR [rdx], zmm4
	vpminuq	zmm4, zmm5, zmm3
	vpmaxuq	zmm4{k2}, zmm5, zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm3
	vmovdqa64	zmm7, ZMMWORD PTR [rdx]
	vpcmpuq	k1, zmm4, zmm3, 0
	vpermq	zmm3, zmm0, zmm7
	vmovdqa64	ZMMWORD PTR -112[rbp], zmm7
	vmovdqa64	zmm3{k1}, zmm7
	vmovdqa64	ZMMWORD PTR [rdx], zmm3
	vmovdqa64	ZMMWORD PTR [r9], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR [rcx]
	vpermq	zmm5, zmm2, zmm4
	vpermq	zmm2, zmm2, ZMMWORD PTR 0[r13]
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k4}, zmm5, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR 0[r13]
	vpermq	zmm4, zmm1, zmm3
	vmovdqa64	ZMMWORD PTR 0[r13], zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k3}, zmm4, zmm3
	vmovdqa64	ZMMWORD PTR [rcx], zmm3
	vpermq	zmm1, zmm1, ZMMWORD PTR 0[r13]
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm1{k1}, ZMMWORD PTR 0[r13]
	vpermq	zmm3, zmm0, zmm2
	vmovdqa64	ZMMWORD PTR 0[r13], zmm1
	vpminuq	zmm1, zmm3, zmm2
	vpmaxuq	zmm1{k2}, zmm3, zmm2
	vmovdqa64	ZMMWORD PTR [rcx], zmm2
	vpermq	zmm0, zmm0, ZMMWORD PTR 0[r13]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR 0[r13]
	vmovdqa64	ZMMWORD PTR 0[r13], zmm0
	vmovdqa64	ZMMWORD PTR [rcx], zmm1
	vzeroupper
	lea	rsp, -48[rbp]
	pop	rbx
	pop	r10
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	lea	rsp, -8[r10]
	ret
	.size	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_, .-_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	.section	.text._Z12bitonic_sortPmS_l,"axG",@progbits,_Z12bitonic_sortPmS_l,comdat
	.p2align 4
	.weak	_Z12bitonic_sortPmS_l
	.type	_Z12bitonic_sortPmS_l, @function
_Z12bitonic_sortPmS_l:
	endbr64
	lea	r10, 8[rsp]
	and	rsp, -64
	mov	rcx, rdx
	push	QWORD PTR -8[r10]
	push	rbp
	mov	rbp, rsp
	push	r15
	mov	r15, rdi
	mov	rdi, -1
	push	r14
	mov	r14, rsi
	push	r13
	push	r12
	push	r10
	push	rbx
	sub	rsp, 2368
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -56[rbp], rax
	xor	eax, eax
	add	rcx, 7
	lea	rax, 14[rdx]
	cmovns	rax, rcx
	mov	ecx, 8
	sar	rax, 3
	lea	esi, 0[0+rax*8]
	sub	esi, edx
	mov	edx, 255
	sub	ecx, esi
	mov	ebx, edx
	sal	ebx, cl
	mov	ecx, esi
	sar	edx, cl
	kmovw	k5, ebx
	vpbroadcastq	zmm0{k5}{z}, rdi
	movzx	r13d, dl
	cmp	eax, 15
	ja	.L27
	lea	rdx, .L29[rip]
	mov	eax, eax
	movsx	rax, DWORD PTR [rdx+rax*4]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata._Z12bitonic_sortPmS_l,"aG",@progbits,_Z12bitonic_sortPmS_l,comdat
	.align 4
	.align 4
.L29:
	.long	.L27-.L29
	.long	.L43-.L29
	.long	.L42-.L29
	.long	.L41-.L29
	.long	.L40-.L29
	.long	.L39-.L29
	.long	.L38-.L29
	.long	.L37-.L29
	.long	.L36-.L29
	.long	.L35-.L29
	.long	.L34-.L29
	.long	.L33-.L29
	.long	.L32-.L29
	.long	.L31-.L29
	.long	.L30-.L29
	.long	.L28-.L29
	.section	.text._Z12bitonic_sortPmS_l,"axG",@progbits,_Z12bitonic_sortPmS_l,comdat
	.p2align 4,,10
	.p2align 3
.L28:
	vmovdqu64	zmm7, ZMMWORD PTR [r15]
	vmovdqu64	zmm6, ZMMWORD PTR [r14]
	kmovw	k2, r13d
	lea	rsi, -688[rbp]
	lea	rcx, -752[rbp]
	lea	rdx, -816[rbp]
	vmovdqu64	zmm5, ZMMWORD PTR 832[r15]
	lea	r9, -880[rbp]
	lea	r8, -944[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	lea	rax, 896[r15]
	lea	rbx, 896[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm6
	lea	rdi, -1968[rbp]
	lea	r11, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 128[r15]
	lea	r10, -2160[rbp]
	lea	r12, -2096[rbp]
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r15]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 256[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 320[r15]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 448[r15]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 512[r15]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 576[r15]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 640[r15]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 704[r15]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 768[r15]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm7
	vmovdqu64	zmm5, ZMMWORD PTR 128[r14]
	vmovdqu64	zmm2, ZMMWORD PTR 192[r14]
	vmovdqu64	zmm6, ZMMWORD PTR 256[r14]
	push	rsi
	vmovdqu64	zmm7, ZMMWORD PTR 320[r14]
	vmovdqu64	zmm1{k2}{z}, ZMMWORD PTR 896[r15]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm2
	vmovdqu64	zmm5, ZMMWORD PTR 384[r14]
	vmovdqu64	zmm2, ZMMWORD PTR 448[r14]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm6
	vpord	zmm1, zmm0, zmm1
	vmovdqu64	zmm6, ZMMWORD PTR 512[r14]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 576[r14]
	vmovdqa64	ZMMWORD PTR -1264[rbp], zmm1
	vmovdqu64	zmm1{k2}{z}, ZMMWORD PTR 896[r14]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 640[r14]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm2
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm2, ZMMWORD PTR 704[r14]
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 768[r14]
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 832[r14]
	mov	QWORD PTR -2248[rbp], rax
	lea	rax, -1840[rbp]
	mov	QWORD PTR -2256[rbp], rbx
	lea	rbx, -1904[rbp]
	mov	QWORD PTR -2168[rbp], rsi
	lea	rsi, -1008[rbp]
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -240[rbp], zmm0
	mov	QWORD PTR -2176[rbp], rcx
	push	rcx
	lea	rcx, -1072[rbp]
	push	rdx
	mov	QWORD PTR -2184[rbp], rdx
	lea	rdx, -1136[rbp]
	push	r9
	mov	QWORD PTR -2192[rbp], r9
	lea	r9, -1712[rbp]
	push	r8
	mov	QWORD PTR -2200[rbp], r8
	lea	r8, -1776[rbp]
	push	rsi
	push	rcx
	push	rdx
	push	r9
	push	r8
	mov	QWORD PTR -2208[rbp], rsi
	mov	rsi, r12
	mov	QWORD PTR -2216[rbp], rcx
	mov	rcx, rdi
	mov	QWORD PTR -2224[rbp], rdx
	mov	rdx, r11
	mov	QWORD PTR -2232[rbp], r9
	mov	r9, rax
	mov	QWORD PTR -2240[rbp], r8
	mov	r8, rbx
	mov	QWORD PTR -2264[rbp], rdi
	mov	rdi, r10
	mov	QWORD PTR -2288[rbp], rax
	mov	QWORD PTR -2280[rbp], r11
	mov	QWORD PTR -2272[rbp], r10
	vzeroupper
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	lea	r8, -240[rbp]
	lea	rcx, -1456[rbp]
	push	r8
	lea	r8, -304[rbp]
	lea	rdx, -1520[rbp]
	push	r8
	lea	r8, -368[rbp]
	lea	rsi, -1584[rbp]
	push	r8
	lea	r8, -432[rbp]
	lea	rdi, -1648[rbp]
	push	r8
	lea	r8, -496[rbp]
	lea	r9, -1328[rbp]
	push	r8
	lea	r8, -560[rbp]
	push	r8
	lea	r8, -624[rbp]
	push	r8
	lea	r8, -1264[rbp]
	push	r8
	lea	r8, -1392[rbp]
	call	_Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 64
	mov	r8, rbx
	mov	rsi, r12
	vmovdqa64	zmm0, ZMMWORD PTR .LC3[rip]
	vpermq	zmm1, zmm0, ZMMWORD PTR -1648[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1712[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1712[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -624[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1712[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1776[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1776[rbp]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1776[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1520[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1840[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1840[rbp]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -496[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -816[rbp]
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1840[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -816[rbp]
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm4
	vpermq	zmm1, zmm0, ZMMWORD PTR -1456[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -432[rbp]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm3
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1904[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1904[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -880[rbp]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1904[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -880[rbp]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1392[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1968[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1968[rbp]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -368[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1968[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1328[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -2032[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -2032[rbp]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -304[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -1008[rbp]
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -2032[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -1008[rbp]
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm4
	vpermq	zmm1, zmm0, ZMMWORD PTR -1264[rbp]
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR -2096[rbp]
	vpermq	zmm0, zmm0, ZMMWORD PTR -240[rbp]
	push	QWORD PTR -2168[rbp]
	vpcmpuq	k1, zmm2, zmm1, 0
	push	QWORD PTR -2176[rbp]
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm3
	vpminuq	zmm3, zmm1, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm1, ZMMWORD PTR -1072[rbp]
	push	QWORD PTR -2184[rbp]
	vmovdqa64	ZMMWORD PTR -1264[rbp], zmm2
	vmovdqa64	zmm1{k1}, zmm0
	push	QWORD PTR -2192[rbp]
	vpcmpuq	k1, zmm3, ZMMWORD PTR -2096[rbp], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR -1072[rbp]
	push	QWORD PTR -2200[rbp]
	vmovdqa64	ZMMWORD PTR -240[rbp], zmm1
	push	QWORD PTR -2208[rbp]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm0
	push	QWORD PTR -2216[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm3
	push	QWORD PTR -2224[rbp]
	push	QWORD PTR -2232[rbp]
	push	QWORD PTR -2240[rbp]
	mov	rax, QWORD PTR -2288[rbp]
	mov	r11, QWORD PTR -2280[rbp]
	mov	r10, QWORD PTR -2272[rbp]
	mov	rcx, QWORD PTR -2264[rbp]
	mov	r9, rax
	mov	rdx, r11
	mov	rdi, r10
	vzeroupper
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	mov	edi, -16
	add	rsp, 80
	vmovdqa64	zmm0, ZMMWORD PTR -1392[rbp]
	kmovw	k4, edi
	vpminuq	zmm3, zmm0, ZMMWORD PTR -1648[rbp]
	mov	edi, -52
	vpmaxuq	zmm16, zmm0, ZMMWORD PTR -1648[rbp]
	kmovw	k3, edi
	vmovdqa64	zmm10, ZMMWORD PTR -368[rbp]
	mov	edi, -86
	vpcmpuq	k1, zmm3, ZMMWORD PTR -1648[rbp], 0
	kmovw	k2, edi
	vmovdqa64	zmm10{k1}, ZMMWORD PTR -624[rbp]
	vmovdqa64	zmm9, ZMMWORD PTR -624[rbp]
	vpcmpuq	k1, zmm16, zmm0, 0
	vmovdqa64	zmm0, ZMMWORD PTR -1328[rbp]
	vpminuq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	vpmaxuq	zmm12, zmm0, ZMMWORD PTR -1584[rbp]
	vmovdqa64	zmm9{k1}, ZMMWORD PTR -368[rbp]
	vmovdqa64	zmm19, ZMMWORD PTR -304[rbp]
	vpcmpuq	k1, zmm1, ZMMWORD PTR -1584[rbp], 0
	vmovdqa64	zmm19{k1}, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm12, zmm0, 0
	vmovdqa64	zmm0, ZMMWORD PTR -1264[rbp]
	vpminuq	zmm0, zmm0, ZMMWORD PTR -1520[rbp]
	vmovdqa64	zmm5, ZMMWORD PTR -1264[rbp]
	vpmaxuq	zmm13, zmm5, ZMMWORD PTR -1520[rbp]
	vpminuq	zmm2, zmm0, zmm3
	vpmaxuq	zmm11, zmm0, zmm3
	vmovdqa64	zmm17, ZMMWORD PTR -560[rbp]
	vmovdqa64	zmm4, ZMMWORD PTR -240[rbp]
	vmovdqa64	zmm17{k1}, ZMMWORD PTR -304[rbp]
	vmovdqa64	zmm18, ZMMWORD PTR -496[rbp]
	vpcmpuq	k1, zmm0, ZMMWORD PTR -1520[rbp], 0
	vmovdqa64	zmm4{k1}, ZMMWORD PTR -496[rbp]
	vpcmpuq	k1, zmm13, zmm5, 0
	vmovdqa64	zmm18{k1}, ZMMWORD PTR -240[rbp]
	vpcmpuq	k1, zmm2, zmm3, 0
	vpmaxuq	zmm15, zmm1, ZMMWORD PTR -1456[rbp]
	vmovdqa64	zmm7, zmm4
	vmovdqa64	zmm7{k1}, zmm10
	vpcmpuq	k1, zmm11, zmm0, 0
	vpminuq	zmm0, zmm1, ZMMWORD PTR -1456[rbp]
	vpmaxuq	zmm14, zmm15, zmm11
	vpmaxuq	zmm5, zmm0, zmm2
	vmovdqa64	zmm10{k1}, zmm4
	vpcmpuq	k1, zmm0, zmm1, 0
	vmovdqa64	zmm4, ZMMWORD PTR -432[rbp]
	vpminuq	zmm1, zmm0, zmm2
	vmovdqa64	zmm4{k1}, zmm19
	vpcmpuq	k1, zmm15, ZMMWORD PTR -1456[rbp], 0
	vmovdqa64	zmm19{k1}, ZMMWORD PTR -432[rbp]
	vpcmpuq	k1, zmm1, zmm2, 0
	vmovdqa64	zmm3, zmm4
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vmovdqa64	zmm20, zmm19
	vmovdqa64	zmm3{k1}, zmm7
	vpcmpuq	k1, zmm5, zmm0, 0
	vpermq	zmm6, zmm2, zmm3
	vmovdqa64	zmm7{k1}, zmm4
	vpermq	zmm4, zmm2, zmm1
	vpminuq	zmm0, zmm4, zmm1
	vpmaxuq	zmm0{k4}, zmm4, zmm1
	vpcmpuq	k1, zmm0, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vpermq	zmm4, zmm1, zmm0
	vmovdqa64	zmm6{k1}, zmm3
	vpminuq	zmm3, zmm4, zmm0
	vpmaxuq	zmm3{k3}, zmm4, zmm0
	vpermq	zmm4, zmm1, zmm6
	vpcmpuq	k1, zmm3, zmm0, 0
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vpermq	zmm8, zmm0, zmm3
	vmovdqa64	zmm4{k1}, zmm6
	vpminuq	zmm6, zmm8, zmm3
	vpmaxuq	zmm6{k2}, zmm8, zmm3
	vpermq	zmm8, zmm0, zmm4
	vpcmpuq	k1, zmm6, zmm3, 0
	vpermq	zmm3, zmm2, zmm5
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm6
	vmovdqu64	ZMMWORD PTR 512[r15], zmm6
	vmovdqa64	zmm8{k1}, zmm4
	vpminuq	zmm4, zmm3, zmm5
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm8
	vpmaxuq	zmm4{k4}, zmm3, zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm2, zmm7
	vmovdqa64	zmm5{k1}, zmm7
	vpermq	zmm7, zmm1, zmm4
	vpminuq	zmm3, zmm7, zmm4
	vpmaxuq	zmm3{k3}, zmm7, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm7, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm5
	vmovdqa64	zmm4{k1}, zmm5
	vpminuq	zmm5, zmm7, zmm3
	vpmaxuq	zmm5{k2}, zmm7, zmm3
	vpermq	zmm7, zmm0, zmm4
	vpcmpuq	k1, zmm5, zmm3, 0
	vpminuq	zmm3, zmm15, zmm11
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm5
	vmovdqa64	zmm7{k1}, zmm4
	vpcmpuq	k1, zmm3, zmm11, 0
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm7
	vmovdqa64	zmm20{k1}, zmm10
	vpcmpuq	k1, zmm14, zmm15, 0
	vmovdqa64	zmm15, zmm10
	vpermq	zmm10, zmm2, zmm3
	vpermq	zmm11, zmm2, zmm20
	vpminuq	zmm4, zmm10, zmm3
	vpmaxuq	zmm4{k4}, zmm10, zmm3
	vmovdqa64	zmm15{k1}, zmm19
	vpmaxuq	zmm19, zmm13, zmm16
	vpermq	zmm10, zmm1, zmm4
	vpcmpuq	k1, zmm4, zmm3, 0
	vpminuq	zmm3, zmm10, zmm4
	vpmaxuq	zmm3{k3}, zmm10, zmm4
	vmovdqa64	zmm11{k1}, zmm20
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, zmm11
	vmovdqa64	zmm4{k1}, zmm11
	vpermq	zmm11, zmm0, zmm3
	vpminuq	zmm10, zmm11, zmm3
	vpmaxuq	zmm10{k2}, zmm11, zmm3
	vpermq	zmm11, zmm0, zmm4
	vpcmpuq	k1, zmm10, zmm3, 0
	vpermq	zmm3, zmm2, zmm14
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm10
	vmovdqa64	zmm11{k1}, zmm4
	vpminuq	zmm4, zmm3, zmm14
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm11
	vpmaxuq	zmm4{k4}, zmm3, zmm14
	vpcmpuq	k1, zmm4, zmm14, 0
	vpermq	zmm14, zmm2, zmm15
	vmovdqa64	zmm14{k1}, zmm15
	vpermq	zmm15, zmm1, zmm4
	vpminuq	zmm3, zmm15, zmm4
	vpmaxuq	zmm3{k3}, zmm15, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm15, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm14
	vmovdqa64	zmm4{k1}, zmm14
	vpminuq	zmm14, zmm15, zmm3
	vpmaxuq	zmm14{k2}, zmm15, zmm3
	vpermq	zmm15, zmm0, zmm4
	vpcmpuq	k1, zmm14, zmm3, 0
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm14
	vmovdqa64	zmm15{k1}, zmm4
	vpminuq	zmm4, zmm13, zmm16
	vpcmpuq	k1, zmm4, zmm16, 0
	vmovdqa64	zmm16, zmm18
	vpminuq	zmm3, zmm12, zmm4
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm15
	vmovdqa64	zmm16{k1}, zmm9
	vpcmpuq	k1, zmm19, zmm13, 0
	vpmaxuq	zmm13, zmm12, zmm4
	vmovdqa64	zmm9{k1}, zmm18
	vpcmpuq	k1, zmm3, zmm4, 0
	vmovdqa64	zmm18, zmm17
	vmovdqa64	zmm18{k1}, zmm16
	vpcmpuq	k1, zmm13, zmm12, 0
	vmovdqa64	zmm12, zmm16
	vpermq	zmm16, zmm2, zmm3
	vpminuq	zmm4, zmm16, zmm3
	vpmaxuq	zmm4{k4}, zmm16, zmm3
	vmovdqa64	zmm12{k1}, zmm17
	vpermq	zmm16, zmm2, zmm18
	vpermq	zmm17, zmm1, zmm4
	vpcmpuq	k1, zmm4, zmm3, 0
	vpminuq	zmm3, zmm17, zmm4
	vpmaxuq	zmm3{k3}, zmm17, zmm4
	vmovdqa64	zmm16{k1}, zmm18
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm17, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm16
	vmovdqa64	zmm4{k1}, zmm16
	vpminuq	zmm16, zmm17, zmm3
	vpmaxuq	zmm16{k2}, zmm17, zmm3
	vpermq	zmm17, zmm0, zmm4
	vpcmpuq	k1, zmm16, zmm3, 0
	vpermq	zmm3, zmm2, zmm13
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm16
	vmovdqa64	zmm17{k1}, zmm4
	vpminuq	zmm4, zmm3, zmm13
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm17
	vpmaxuq	zmm4{k4}, zmm3, zmm13
	vpermq	zmm3, zmm2, zmm12
	vpcmpuq	k1, zmm4, zmm13, 0
	vpermq	zmm13, zmm1, zmm4
	vmovdqa64	zmm3{k1}, zmm12
	vmovdqa64	zmm12, zmm3
	vpminuq	zmm3, zmm13, zmm4
	vpmaxuq	zmm3{k3}, zmm13, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm13, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm12
	vmovdqa64	zmm4{k1}, zmm12
	vpminuq	zmm12, zmm13, zmm3
	vpmaxuq	zmm12{k2}, zmm13, zmm3
	vpermq	zmm13, zmm0, zmm4
	vpcmpuq	k1, zmm12, zmm3, 0
	vpermq	zmm3, zmm2, zmm19
	vpermq	zmm2, zmm2, zmm9
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm12
	vmovdqa64	zmm13{k1}, zmm4
	vpminuq	zmm4, zmm3, zmm19
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm13
	vpmaxuq	zmm4{k4}, zmm3, zmm19
	kmovw	k4, r13d
	vpcmpuq	k1, zmm4, zmm19, 0
	vmovdqa64	zmm2{k1}, zmm9
	vpermq	zmm9, zmm1, zmm4
	vpminuq	zmm3, zmm9, zmm4
	vpermq	zmm1, zmm1, zmm2
	vpmaxuq	zmm3{k3}, zmm9, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpminuq	zmm2, zmm4, zmm3
	vpmaxuq	zmm2{k2}, zmm4, zmm3
	vpermq	zmm0, zmm0, zmm1
	vmovdqa64	zmm4, ZMMWORD PTR -2160[rbp]
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	ZMMWORD PTR -1264[rbp], zmm2
	vmovdqu64	ZMMWORD PTR [r15], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR -2096[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm4
	vmovdqa64	zmm0{k1}, zmm1
	vmovdqa64	zmm4, ZMMWORD PTR -2032[rbp]
	vmovdqa64	ZMMWORD PTR -240[rbp], zmm0
	vmovdqu64	ZMMWORD PTR 128[r15], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR -1968[rbp]
	vmovdqu64	ZMMWORD PTR 192[r15], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR 256[r15], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR -1840[rbp]
	vmovdqu64	ZMMWORD PTR 320[r15], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR -1776[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm4
	vmovdqa64	zmm4, ZMMWORD PTR -1712[rbp]
	vmovdqu64	ZMMWORD PTR 448[r15], zmm4
	vmovdqu64	ZMMWORD PTR 576[r15], zmm5
	vmovdqa64	zmm6, ZMMWORD PTR -1136[rbp]
	vmovdqa64	zmm5, ZMMWORD PTR -1072[rbp]
	mov	rax, QWORD PTR -2248[rbp]
	vmovdqu64	ZMMWORD PTR 640[r15], zmm10
	vmovdqu64	ZMMWORD PTR [r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -816[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -752[rbp]
	vmovdqu64	ZMMWORD PTR 320[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -688[rbp]
	vmovdqu64	ZMMWORD PTR 704[r15], zmm14
	vmovdqu64	ZMMWORD PTR 768[r15], zmm16
	vmovdqu64	ZMMWORD PTR 832[r15], zmm12
	vmovdqu64	ZMMWORD PTR 384[r14], zmm6
	vmovdqu64	ZMMWORD PTR 448[r14], zmm5
	vmovdqu64	ZMMWORD PTR 512[r14], zmm8
	vmovdqu64	ZMMWORD PTR 576[r14], zmm7
	vmovdqu64	ZMMWORD PTR 640[r14], zmm11
	vmovdqu64	ZMMWORD PTR 704[r14], zmm15
	vmovdqu64	ZMMWORD PTR 768[r14], zmm17
	vmovdqu64	ZMMWORD PTR 832[r14], zmm13
	vpcompressq	ZMMWORD PTR [rax]{k4}, zmm2
	mov	rax, QWORD PTR -2256[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k4}, zmm0
	.p2align 4,,10
	.p2align 3
.L26:
	mov	rax, QWORD PTR -56[rbp]
	xor	rax, QWORD PTR fs:40
	jne	.L48
	vzeroupper
	lea	rsp, -48[rbp]
	pop	rbx
	pop	r10
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	lea	rsp, -8[r10]
	ret
	.p2align 4,,10
	.p2align 3
.L43:
	kmovw	k6, r13d
	vmovdqu64	zmm2{k6}{z}, ZMMWORD PTR [r15]
	vmovdqu64	zmm5{k6}{z}, ZMMWORD PTR [r14]
	mov	eax, 102
	vmovdqa64	zmm1, ZMMWORD PTR .LC2[rip]
	kmovw	k6, eax
	mov	eax, 60
	vpord	zmm2, zmm0, zmm2
	vpord	zmm5, zmm0, zmm5
	kmovw	k7, eax
	mov	eax, 90
	vpermq	zmm0, zmm1, zmm2
	vpminuq	zmm4, zmm0, zmm2
	vpmaxuq	zmm4{k6}, zmm0, zmm2
	vpermq	zmm0, zmm1, zmm5
	kmovw	k6, eax
	mov	eax, -16
	vpcmpuq	k1, zmm4, zmm2, 0
	vmovdqa64	zmm2, ZMMWORD PTR .LC1[rip]
	vmovdqa64	zmm0{k1}, zmm5
	vpermq	zmm5, zmm2, zmm4
	vpminuq	zmm3, zmm5, zmm4
	vpmaxuq	zmm3{k7}, zmm5, zmm4
	kmovw	k7, eax
	mov	eax, -52
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm5, zmm1, zmm3
	vpermq	zmm4, zmm2, zmm0
	vmovdqa64	zmm4{k1}, zmm0
	vpminuq	zmm0, zmm5, zmm3
	vpmaxuq	zmm0{k6}, zmm5, zmm3
	vpermq	zmm5, zmm1, zmm4
	kmovw	k6, eax
	mov	eax, -86
	vpcmpuq	k1, zmm0, zmm3, 0
	vmovdqa64	zmm5{k1}, zmm4
	vmovdqa64	zmm4, ZMMWORD PTR .LC0[rip]
	vpermq	zmm6, zmm4, zmm0
	vpermq	zmm4, zmm4, zmm5
	vpminuq	zmm3, zmm6, zmm0
	vpmaxuq	zmm3{k7}, zmm6, zmm0
	kmovw	k7, eax
	vpcmpuq	k1, zmm3, zmm0, 0
	vmovdqa64	zmm4{k1}, zmm5
	vpermq	zmm5, zmm2, zmm3
	vpminuq	zmm0, zmm5, zmm3
	vpermq	zmm2, zmm2, zmm4
	vpmaxuq	zmm0{k6}, zmm5, zmm3
	kmovw	k6, r13d
	vpcmpuq	k1, zmm0, zmm3, 0
	vmovdqa64	zmm2{k1}, zmm4
	vpermq	zmm4, zmm1, zmm0
	vpminuq	zmm3, zmm4, zmm0
	vpermq	zmm1, zmm1, zmm2
	vpmaxuq	zmm3{k7}, zmm4, zmm0
	vpcmpuq	k1, zmm3, zmm0, 0
	vpcompressq	ZMMWORD PTR [r15]{k6}, zmm3
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm1
	vpcompressq	ZMMWORD PTR [r14]{k6}, zmm1
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L42:
	kmovw	k6, r13d
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 64[r15]
	lea	r12, 64[r15]
	vmovdqu64	zmm7, ZMMWORD PTR [r15]
	lea	rbx, 64[r14]
	lea	rcx, -1072[rbp]
	vpord	zmm1, zmm0, zmm1
	lea	rdx, -1136[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR [r14]
	lea	rsi, -2096[rbp]
	lea	rdi, -2160[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm1
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm7
	vpord	zmm0, zmm0, zmm1
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm0
	vzeroupper
	call	_Z15bitonic_sort_2vRDv8_xS0_S0_S0_
	kmovw	k6, r13d
	vmovdqa64	zmm7, ZMMWORD PTR -2160[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -2096[rbp]
	vpcompressq	ZMMWORD PTR [r12]{k6}, zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1072[rbp]
	vpcompressq	ZMMWORD PTR [rbx]{k6}, zmm7
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L41:
	kmovw	k6, r13d
	vmovdqu64	zmm6, ZMMWORD PTR [r15]
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 128[r15]
	lea	r12, 128[r15]
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	lea	rbx, 128[r14]
	lea	rcx, -1136[rbp]
	vpord	zmm1, zmm0, zmm1
	lea	rdx, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR [r14]
	lea	rsi, -2096[rbp]
	lea	rdi, -2160[rbp]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm1
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 128[r14]
	lea	r9, -1008[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 64[r14]
	lea	r8, -1072[rbp]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm6
	vpord	zmm0, zmm0, zmm1
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm0
	vzeroupper
	call	_Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_
	kmovw	k6, r13d
	vmovdqa64	zmm7, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -2032[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm6
	vpcompressq	ZMMWORD PTR [r12]{k6}, zmm7
	vmovdqa64	zmm6, ZMMWORD PTR -1008[rbp]
	vpcompressq	ZMMWORD PTR [rbx]{k6}, zmm6
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L40:
	vmovdqu64	zmm6, ZMMWORD PTR [r15]
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	kmovw	k6, r13d
	lea	rax, -944[rbp]
	push	rax
	lea	rax, -1008[rbp]
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 192[r15]
	lea	r12, 192[r15]
	push	rax
	lea	rbx, 192[r14]
	lea	rcx, -1968[rbp]
	vpord	zmm1, zmm0, zmm1
	lea	rdx, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r15]
	lea	rsi, -2096[rbp]
	lea	rdi, -2160[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR [r14]
	lea	r9, -1072[rbp]
	lea	r8, -1136[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm1
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm7
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm7, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm0
	vzeroupper
	call	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	kmovw	k6, r13d
	vmovdqa64	zmm7, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -2032[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR 128[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1968[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm6
	vpcompressq	ZMMWORD PTR [r12]{k6}, zmm7
	vmovdqa64	zmm6, ZMMWORD PTR -944[rbp]
	vpcompressq	ZMMWORD PTR [rbx]{k6}, zmm6
	pop	r9
	pop	r10
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L39:
	vmovdqu64	zmm6, ZMMWORD PTR [r15]
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	kmovw	k6, r13d
	lea	rax, -944[rbp]
	lea	r11, -1008[rbp]
	push	rax
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 256[r15]
	lea	r10, -2160[rbp]
	push	r11
	lea	r9, -1072[rbp]
	lea	r8, -1136[rbp]
	mov	rdi, r10
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm6
	vpord	zmm1, zmm0, zmm1
	vmovdqu64	zmm6, ZMMWORD PTR 128[r15]
	lea	rcx, -1968[rbp]
	lea	rdx, -2032[rbp]
	lea	rsi, -2096[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r15]
	lea	r12, 256[r15]
	lea	rbx, 256[r14]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm1
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm7
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm7, ZMMWORD PTR 192[r14]
	mov	QWORD PTR -2224[rbp], rax
	mov	QWORD PTR -2216[rbp], r11
	mov	QWORD PTR -2208[rbp], r9
	mov	QWORD PTR -2200[rbp], r8
	mov	QWORD PTR -2192[rbp], rcx
	mov	QWORD PTR -2184[rbp], rdx
	mov	QWORD PTR -2176[rbp], rsi
	mov	QWORD PTR -2168[rbp], r10
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm0
	vzeroupper
	call	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	mov	edi, 102
	vmovdqa64	zmm1, ZMMWORD PTR -1904[rbp]
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	kmovw	k6, edi
	mov	edi, 60
	vpermq	zmm5, zmm0, ZMMWORD PTR -880[rbp]
	mov	eax, -16
	vpermq	zmm2, zmm0, zmm1
	kmovw	k7, edi
	mov	edi, 90
	kmovw	k4, eax
	vpminuq	zmm3, zmm2, zmm1
	mov	eax, -52
	vmovdqa64	zmm7, ZMMWORD PTR .LC3[rip]
	mov	r11, QWORD PTR -2216[rbp]
	vpmaxuq	zmm3{k6}, zmm2, zmm1
	kmovw	k6, edi
	kmovw	k3, eax
	mov	eax, -86
	vpcmpuq	k1, zmm3, zmm1, 0
	kmovw	k2, eax
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR -880[rbp]
	mov	rax, QWORD PTR -2224[rbp]
	mov	r10, QWORD PTR -2168[rbp]
	vpermq	zmm4, zmm1, zmm3
	mov	r9, QWORD PTR -2208[rbp]
	mov	r8, QWORD PTR -2200[rbp]
	vpminuq	zmm2, zmm4, zmm3
	push	rax
	mov	rcx, QWORD PTR -2192[rbp]
	mov	rdi, r10
	vpmaxuq	zmm2{k7}, zmm4, zmm3
	vpermq	zmm4, zmm1, zmm5
	push	r11
	mov	rdx, QWORD PTR -2184[rbp]
	vpcmpuq	k1, zmm2, zmm3, 0
	mov	rsi, QWORD PTR -2176[rbp]
	vmovdqa64	zmm4{k1}, zmm5
	vpermq	zmm5, zmm0, zmm2
	vpminuq	zmm3, zmm5, zmm2
	vpmaxuq	zmm3{k6}, zmm5, zmm2
	vpermq	zmm5, zmm0, zmm4
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqa64	zmm5{k1}, zmm4
	vmovdqa64	zmm4, ZMMWORD PTR .LC0[rip]
	vpermq	zmm6, zmm4, zmm3
	vpminuq	zmm2, zmm6, zmm3
	vpmaxuq	zmm2{k4}, zmm6, zmm3
	vpermq	zmm6, zmm4, zmm5
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm6{k1}, zmm5
	vpermq	zmm5, zmm1, zmm2
	vpminuq	zmm3, zmm5, zmm2
	vpmaxuq	zmm3{k3}, zmm5, zmm2
	vpermq	zmm5, zmm1, zmm6
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqa64	zmm5{k1}, zmm6
	vpermq	zmm6, zmm0, zmm3
	vpminuq	zmm2, zmm6, zmm3
	vpmaxuq	zmm2{k2}, zmm6, zmm3
	vpcmpuq	k1, zmm2, zmm3, 0
	vpermq	zmm3, zmm0, zmm5
	vpermq	zmm2, zmm7, zmm2
	vpminuq	zmm6, zmm2, ZMMWORD PTR -1968[rbp]
	vmovdqa64	zmm3{k1}, zmm5
	vpmaxuq	zmm5, zmm2, ZMMWORD PTR -1968[rbp]
	vpermq	zmm3, zmm7, zmm3
	vpcmpuq	k1, zmm5, zmm2, 0
	vmovdqa64	zmm2, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm5
	vmovdqa64	zmm2{k1}, zmm3
	vpcmpuq	k1, zmm6, ZMMWORD PTR -1968[rbp], 0
	vmovdqa64	zmm3{k1}, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm3
	vzeroupper
	call	_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	kmovw	k7, r13d
	add	rsp, 32
	vmovdqa64	zmm2, ZMMWORD PTR -1904[rbp]
	mov	eax, -16
	vmovdqa64	zmm4, ZMMWORD PTR .LC0[rip]
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	kmovw	k4, eax
	mov	eax, -52
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vpermq	zmm5, zmm4, zmm2
	kmovw	k3, eax
	vpermq	zmm4, zmm4, ZMMWORD PTR -880[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vpminuq	zmm3, zmm5, zmm2
	mov	eax, -86
	vmovdqa64	zmm7, ZMMWORD PTR -2096[rbp]
	vpmaxuq	zmm3{k4}, zmm5, zmm2
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	kmovw	k2, eax
	vmovdqa64	zmm6, ZMMWORD PTR -2032[rbp]
	vpermq	zmm5, zmm1, zmm3
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqa64	zmm4{k1}, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1968[rbp]
	vpminuq	zmm2, zmm5, zmm3
	vmovdqu64	ZMMWORD PTR 128[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1136[rbp]
	vpmaxuq	zmm2{k3}, zmm5, zmm3
	vpermq	zmm1, zmm1, zmm4
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqu64	ZMMWORD PTR [r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR 192[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm6
	vmovdqa64	zmm1{k1}, zmm4
	vpermq	zmm4, zmm0, zmm2
	vmovdqu64	ZMMWORD PTR 64[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -944[rbp]
	vpminuq	zmm3, zmm4, zmm2
	vpermq	zmm0, zmm0, zmm1
	vmovdqu64	ZMMWORD PTR 192[r14], zmm7
	vpmaxuq	zmm3{k2}, zmm4, zmm2
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm3
	vmovdqa64	zmm0{k1}, zmm1
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm0
	vpcompressq	ZMMWORD PTR [r12]{k7}, zmm3
	vpcompressq	ZMMWORD PTR [rbx]{k7}, zmm0
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L38:
	vmovdqu64	zmm6, ZMMWORD PTR [r15]
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	kmovw	k3, r13d
	lea	rax, -816[rbp]
	push	rax
	lea	rax, -880[rbp]
	vmovdqu64	zmm1{k3}{z}, ZMMWORD PTR 320[r15]
	lea	r12, 320[r15]
	push	rax
	lea	rax, -944[rbp]
	lea	rbx, 320[r14]
	push	rax
	lea	rax, -1008[rbp]
	vpord	zmm1, zmm0, zmm1
	lea	rcx, -1968[rbp]
	push	rax
	lea	rax, -1072[rbp]
	lea	rdx, -2032[rbp]
	push	rax
	lea	rax, -1136[rbp]
	lea	rsi, -2096[rbp]
	push	rax
	lea	rdi, -2160[rbp]
	lea	r9, -1840[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm6
	lea	r8, -1904[rbp]
	vmovdqu64	zmm6, ZMMWORD PTR 128[r15]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r15]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 256[r15]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm1
	vmovdqu64	zmm1{k3}{z}, ZMMWORD PTR 320[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm7
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm7, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm0
	vzeroupper
	call	_Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	kmovw	k6, r13d
	add	rsp, 48
	vmovdqa64	zmm7, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1968[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -2032[rbp]
	vmovdqu64	ZMMWORD PTR 192[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR 128[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR 256[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1840[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm6
	vpcompressq	ZMMWORD PTR [r12]{k6}, zmm7
	vmovdqa64	zmm6, ZMMWORD PTR -816[rbp]
	vpcompressq	ZMMWORD PTR [rbx]{k6}, zmm6
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L37:
	vmovdqu64	zmm6, ZMMWORD PTR [r15]
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	kmovw	k2, r13d
	lea	rax, -752[rbp]
	push	rax
	lea	rax, -816[rbp]
	vmovdqu64	zmm1{k2}{z}, ZMMWORD PTR 384[r15]
	lea	r12, 384[r15]
	push	rax
	lea	rax, -880[rbp]
	lea	rbx, 384[r14]
	vpord	zmm1, zmm0, zmm1
	push	rax
	lea	rax, -944[rbp]
	lea	rcx, -1968[rbp]
	push	rax
	lea	rax, -1008[rbp]
	lea	rdx, -2032[rbp]
	lea	rsi, -2096[rbp]
	lea	rdi, -2160[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r15]
	lea	r9, -1840[rbp]
	lea	r8, -1904[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r15]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 256[r15]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 320[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm1
	vmovdqu64	zmm1{k2}{z}, ZMMWORD PTR 384[r14]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm7
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm7, ZMMWORD PTR 320[r14]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm0
	push	rax
	lea	rax, -1072[rbp]
	push	rax
	lea	rax, -1136[rbp]
	push	rax
	lea	rax, -1776[rbp]
	push	rax
	vzeroupper
	call	_Z15bitonic_sort_7vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	kmovw	k4, r13d
	add	rsp, 64
	vmovdqa64	zmm7, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vmovdqa64	zmm5, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1968[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -2032[rbp]
	vmovdqu64	ZMMWORD PTR 192[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1840[rbp]
	vmovdqu64	ZMMWORD PTR 128[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR 320[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR 256[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -816[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1776[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm6
	vmovdqu64	ZMMWORD PTR 320[r14], zmm5
	vpcompressq	ZMMWORD PTR [r12]{k4}, zmm7
	vmovdqa64	zmm6, ZMMWORD PTR -752[rbp]
	vpcompressq	ZMMWORD PTR [rbx]{k4}, zmm6
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L36:
	vmovdqu64	zmm6, ZMMWORD PTR [r15]
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	kmovw	k7, r13d
	lea	rax, -688[rbp]
	lea	r12, 448[r15]
	lea	rbx, 448[r14]
	vmovdqu64	zmm5, ZMMWORD PTR 128[r15]
	vmovdqu64	zmm1{k7}{z}, ZMMWORD PTR 448[r15]
	lea	rcx, -1968[rbp]
	lea	rdx, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 192[r15]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vpord	zmm1, zmm0, zmm1
	vmovdqu64	zmm7, ZMMWORD PTR 256[r15]
	lea	rsi, -2096[rbp]
	lea	rdi, -2160[rbp]
	lea	r9, -1840[rbp]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 320[r15]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm6
	lea	r8, -1904[rbp]
	vmovdqu64	zmm6, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm1
	vmovdqu64	zmm1{k7}{z}, ZMMWORD PTR 448[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm6
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm6, ZMMWORD PTR 320[r14]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 384[r14]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm0
	push	rax
	lea	rax, -752[rbp]
	push	rax
	lea	rax, -816[rbp]
	push	rax
	lea	rax, -880[rbp]
	push	rax
	lea	rax, -944[rbp]
	push	rax
	lea	rax, -1008[rbp]
	push	rax
	lea	rax, -1072[rbp]
	push	rax
	lea	rax, -1136[rbp]
	push	rax
	lea	rax, -1712[rbp]
	push	rax
	lea	rax, -1776[rbp]
	push	rax
	vzeroupper
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	kmovw	k3, r13d
	add	rsp, 80
	vmovdqa64	zmm5, ZMMWORD PTR -2160[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm7, ZMMWORD PTR -2032[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1968[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR 128[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1840[rbp]
	vmovdqu64	ZMMWORD PTR 192[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1776[rbp]
	vmovdqu64	ZMMWORD PTR 256[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR 320[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -816[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -752[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1712[rbp]
	vmovdqu64	ZMMWORD PTR 384[r14], zmm6
	vmovdqu64	ZMMWORD PTR 320[r14], zmm5
	vpcompressq	ZMMWORD PTR [r12]{k3}, zmm7
	vmovdqa64	zmm6, ZMMWORD PTR -688[rbp]
	vpcompressq	ZMMWORD PTR [rbx]{k3}, zmm6
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L35:
	vmovdqu64	zmm7, ZMMWORD PTR [r15]
	vmovdqu64	zmm5, ZMMWORD PTR 64[r15]
	lea	rax, 512[r15]
	lea	rdi, -752[rbp]
	vmovdqu64	zmm6, ZMMWORD PTR 128[r15]
	lea	r10, -816[rbp]
	kmovw	k6, r13d
	lea	r11, -1008[rbp]
	lea	r8, -1136[rbp]
	lea	rbx, 512[r14]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r15]
	lea	r12, -2160[rbp]
	lea	r9, -1840[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 256[r15]
	lea	rcx, -1968[rbp]
	lea	rdx, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 320[r15]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	lea	rsi, -2096[rbp]
	vmovdqu64	zmm7, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 448[r15]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 320[r14]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 384[r14]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 448[r14]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm7
	mov	QWORD PTR -2224[rbp], rax
	lea	rax, -688[rbp]
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 512[r15]
	push	rax
	mov	QWORD PTR -2168[rbp], rax
	lea	rax, -880[rbp]
	vpord	zmm1, zmm0, zmm1
	push	rdi
	mov	QWORD PTR -2184[rbp], r10
	push	r10
	lea	r10, -944[rbp]
	push	rax
	mov	QWORD PTR -2176[rbp], rdi
	lea	rdi, -1776[rbp]
	push	r10
	mov	QWORD PTR -2288[rbp], rax
	lea	rax, -1712[rbp]
	push	r11
	mov	QWORD PTR -2272[rbp], r11
	lea	r11, -1072[rbp]
	push	r11
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm1
	vmovdqu64	zmm1{k6}{z}, ZMMWORD PTR 512[r14]
	push	r8
	push	rax
	vpord	zmm0, zmm0, zmm1
	push	rdi
	mov	QWORD PTR -2232[rbp], rbx
	lea	rbx, -1904[rbp]
	mov	QWORD PTR -2200[rbp], r8
	mov	r8, rbx
	mov	QWORD PTR -2216[rbp], rdi
	mov	rdi, r12
	mov	QWORD PTR -2280[rbp], r10
	mov	QWORD PTR -2192[rbp], r11
	mov	QWORD PTR -2208[rbp], rax
	mov	QWORD PTR -2264[rbp], r9
	mov	QWORD PTR -2256[rbp], rcx
	mov	QWORD PTR -2248[rbp], rdx
	mov	QWORD PTR -2240[rbp], rsi
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm0
	vzeroupper
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	mov	edi, 102
	add	rsp, 80
	vmovdqa64	zmm1, ZMMWORD PTR -1648[rbp]
	kmovw	k5, edi
	mov	edi, 60
	mov	r8, rbx
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	kmovw	k2, edi
	mov	edi, 90
	vpermq	zmm5, zmm0, ZMMWORD PTR -624[rbp]
	mov	esi, -16
	vpermq	zmm2, zmm0, zmm1
	kmovw	k3, edi
	kmovw	k4, esi
	mov	esi, -52
	vpminuq	zmm3, zmm2, zmm1
	push	QWORD PTR -2168[rbp]
	mov	rdi, r12
	vmovdqa64	zmm7, ZMMWORD PTR .LC3[rip]
	vpmaxuq	zmm3{k5}, zmm2, zmm1
	mov	rax, QWORD PTR -2288[rbp]
	push	QWORD PTR -2176[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	mov	r10, QWORD PTR -2280[rbp]
	push	QWORD PTR -2184[rbp]
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	push	rax
	vmovdqa64	zmm5{k1}, ZMMWORD PTR -624[rbp]
	mov	r11, QWORD PTR -2272[rbp]
	push	r10
	vpermq	zmm4, zmm1, zmm3
	vpminuq	zmm2, zmm4, zmm3
	push	r11
	vpmaxuq	zmm2{k2}, zmm4, zmm3
	vpermq	zmm4, zmm1, zmm5
	push	QWORD PTR -2192[rbp]
	vpcmpuq	k1, zmm2, zmm3, 0
	push	QWORD PTR -2200[rbp]
	vmovdqa64	zmm4{k1}, zmm5
	vpermq	zmm5, zmm0, zmm2
	vpminuq	zmm3, zmm5, zmm2
	vpmaxuq	zmm3{k3}, zmm5, zmm2
	vpermq	zmm5, zmm0, zmm4
	kmovw	k3, esi
	mov	esi, -86
	vpcmpuq	k1, zmm3, zmm2, 0
	kmovw	k2, esi
	vmovdqa64	zmm5{k1}, zmm4
	vmovdqa64	zmm4, ZMMWORD PTR .LC0[rip]
	vpermq	zmm6, zmm4, zmm3
	vpminuq	zmm2, zmm6, zmm3
	vpmaxuq	zmm2{k4}, zmm6, zmm3
	vpermq	zmm6, zmm4, zmm5
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm6{k1}, zmm5
	vpermq	zmm5, zmm1, zmm2
	vpminuq	zmm3, zmm5, zmm2
	vpmaxuq	zmm3{k3}, zmm5, zmm2
	vpermq	zmm5, zmm1, zmm6
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqa64	zmm5{k1}, zmm6
	vpermq	zmm6, zmm0, zmm3
	vpminuq	zmm2, zmm6, zmm3
	vpmaxuq	zmm2{k2}, zmm6, zmm3
	vpcmpuq	k1, zmm2, zmm3, 0
	vpermq	zmm3, zmm0, zmm5
	vpermq	zmm2, zmm7, zmm2
	vpminuq	zmm6, zmm2, ZMMWORD PTR -1712[rbp]
	vmovdqa64	zmm3{k1}, zmm5
	vpmaxuq	zmm5, zmm2, ZMMWORD PTR -1712[rbp]
	vpermq	zmm3, zmm7, zmm3
	vpcmpuq	k1, zmm5, zmm2, 0
	vmovdqa64	zmm2, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm5
	vmovdqa64	zmm2{k1}, zmm3
	vpcmpuq	k1, zmm6, ZMMWORD PTR -1712[rbp], 0
	vmovdqa64	zmm3{k1}, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm3
	push	QWORD PTR -2208[rbp]
	mov	r9, QWORD PTR -2264[rbp]
	mov	rcx, QWORD PTR -2256[rbp]
	push	QWORD PTR -2216[rbp]
	mov	rdx, QWORD PTR -2248[rbp]
	mov	rsi, QWORD PTR -2240[rbp]
	vzeroupper
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	mov	eax, -16
	add	rsp, 80
	vmovdqa64	zmm2, ZMMWORD PTR -1648[rbp]
	kmovw	k4, eax
	mov	eax, -52
	vmovdqa64	zmm4, ZMMWORD PTR .LC0[rip]
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	kmovw	k3, eax
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	mov	eax, -86
	vpermq	zmm5, zmm4, zmm2
	kmovw	k2, eax
	vpermq	zmm4, zmm4, ZMMWORD PTR -624[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm7, ZMMWORD PTR -2032[rbp]
	vpminuq	zmm3, zmm5, zmm2
	vpmaxuq	zmm3{k4}, zmm5, zmm2
	vmovdqu64	ZMMWORD PTR 64[r15], zmm6
	kmovw	k4, r13d
	vmovdqa64	zmm6, ZMMWORD PTR -1904[rbp]
	vpermq	zmm5, zmm1, zmm3
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqa64	zmm4{k1}, ZMMWORD PTR -624[rbp]
	vmovdqu64	ZMMWORD PTR 128[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1840[rbp]
	vpminuq	zmm2, zmm5, zmm3
	vmovdqu64	ZMMWORD PTR 256[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1712[rbp]
	vpmaxuq	zmm2{k3}, zmm5, zmm3
	vpermq	zmm1, zmm1, zmm4
	vmovdqa64	zmm5, ZMMWORD PTR -2160[rbp]
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqu64	ZMMWORD PTR 320[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1968[rbp]
	vmovdqu64	ZMMWORD PTR 448[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1008[rbp]
	vmovdqa64	zmm1{k1}, zmm4
	vpermq	zmm4, zmm0, zmm2
	vmovdqu64	ZMMWORD PTR 192[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1776[rbp]
	vpminuq	zmm3, zmm4, zmm2
	vmovdqu64	ZMMWORD PTR [r14], zmm7
	vpermq	zmm0, zmm0, zmm1
	vmovdqa64	zmm7, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm5
	vpmaxuq	zmm3{k2}, zmm4, zmm2
	vmovdqa64	zmm5, ZMMWORD PTR -1072[rbp]
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqu64	ZMMWORD PTR 128[r14], zmm6
	vmovdqu64	ZMMWORD PTR 192[r14], zmm7
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm3
	vmovdqa64	zmm0{k1}, zmm1
	vmovdqu64	ZMMWORD PTR 64[r14], zmm5
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm0
	vmovdqa64	zmm5, ZMMWORD PTR -880[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -816[rbp]
	vmovdqa64	zmm7, ZMMWORD PTR -752[rbp]
	mov	rax, QWORD PTR -2224[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -688[rbp]
	vmovdqu64	ZMMWORD PTR 320[r14], zmm6
	vmovdqu64	ZMMWORD PTR 384[r14], zmm7
	vmovdqu64	ZMMWORD PTR 448[r14], zmm5
	vpcompressq	ZMMWORD PTR [rax]{k4}, zmm3
	mov	rax, QWORD PTR -2232[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k4}, zmm0
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L34:
	vmovdqu64	zmm6, ZMMWORD PTR [r15]
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	lea	rbx, 576[r14]
	kmovw	k7, r13d
	lea	rdi, -752[rbp]
	lea	rsi, -816[rbp]
	vmovdqu64	zmm5, ZMMWORD PTR 128[r15]
	lea	rcx, -880[rbp]
	lea	rdx, -944[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 192[r15]
	lea	rax, 576[r15]
	lea	r11, -2096[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 256[r15]
	lea	r10, -2160[rbp]
	lea	r12, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 320[r15]
	lea	r9, -1840[rbp]
	lea	r8, -1904[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 448[r15]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 512[r15]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 320[r14]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 384[r14]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm6
	vmovdqu64	zmm7, ZMMWORD PTR 448[r14]
	vmovdqu64	zmm1{k7}{z}, ZMMWORD PTR 576[r15]
	mov	QWORD PTR -2248[rbp], rbx
	lea	rbx, -688[rbp]
	vmovdqu64	zmm5, ZMMWORD PTR 512[r14]
	push	rbx
	vpord	zmm1, zmm0, zmm1
	mov	QWORD PTR -2168[rbp], rbx
	lea	rbx, -1008[rbp]
	push	rdi
	mov	QWORD PTR -2176[rbp], rdi
	lea	rdi, -1072[rbp]
	push	rsi
	mov	QWORD PTR -2184[rbp], rsi
	lea	rsi, -1136[rbp]
	push	rcx
	mov	QWORD PTR -2192[rbp], rcx
	lea	rcx, -1712[rbp]
	push	rdx
	mov	QWORD PTR -2208[rbp], rbx
	push	rbx
	lea	rbx, -1776[rbp]
	push	rdi
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm1
	vmovdqu64	zmm1{k7}{z}, ZMMWORD PTR 576[r14]
	push	rsi
	push	rcx
	vpord	zmm0, zmm0, zmm1
	push	rbx
	mov	QWORD PTR -2240[rbp], rax
	lea	rax, -1968[rbp]
	mov	QWORD PTR -2200[rbp], rdx
	mov	rdx, r12
	mov	QWORD PTR -2216[rbp], rdi
	mov	rdi, r10
	mov	QWORD PTR -2224[rbp], rsi
	mov	rsi, r11
	mov	QWORD PTR -2232[rbp], rcx
	mov	rcx, rax
	mov	QWORD PTR -2288[rbp], r9
	mov	QWORD PTR -2280[rbp], r8
	mov	QWORD PTR -2272[rbp], rax
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm0
	mov	QWORD PTR -2264[rbp], r11
	mov	QWORD PTR -2256[rbp], r10
	vzeroupper
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	lea	rcx, -560[rbp]
	lea	rdx, -624[rbp]
	lea	rsi, -1584[rbp]
	lea	rdi, -1648[rbp]
	call	_Z15bitonic_sort_2vRDv8_xS0_S0_S0_
	push	QWORD PTR -2168[rbp]
	mov	rdx, r12
	vmovdqa64	zmm0, ZMMWORD PTR .LC3[rip]
	vpermq	zmm1, zmm0, ZMMWORD PTR -1648[rbp]
	push	QWORD PTR -2176[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1712[rbp]
	push	QWORD PTR -2184[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -624[rbp]
	push	QWORD PTR -2192[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1712[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm3
	vmovdqa64	zmm1, ZMMWORD PTR -688[rbp]
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1712[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	vpermq	zmm0, zmm0, ZMMWORD PTR -560[rbp]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm2
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR -1776[rbp]
	vpminuq	zmm3, zmm1, ZMMWORD PTR -1776[rbp]
	vpcmpuq	k1, zmm2, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm2
	vmovdqa64	zmm1{k1}, zmm0
	vpcmpuq	k1, zmm3, ZMMWORD PTR -1776[rbp], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm3
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm0
	push	QWORD PTR -2200[rbp]
	mov	rax, QWORD PTR -2272[rbp]
	mov	r11, QWORD PTR -2264[rbp]
	push	QWORD PTR -2208[rbp]
	mov	r10, QWORD PTR -2256[rbp]
	push	QWORD PTR -2216[rbp]
	mov	rcx, rax
	mov	r9, QWORD PTR -2288[rbp]
	push	QWORD PTR -2224[rbp]
	mov	rsi, r11
	mov	r8, QWORD PTR -2280[rbp]
	push	QWORD PTR -2232[rbp]
	mov	rdi, r10
	push	rbx
	vzeroupper
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	mov	edi, -16
	add	rsp, 80
	vmovdqa64	zmm6, ZMMWORD PTR -1584[rbp]
	kmovw	k4, edi
	vpminuq	zmm2, zmm6, ZMMWORD PTR -1648[rbp]
	mov	edi, -52
	vmovdqa64	zmm1, ZMMWORD PTR .LC0[rip]
	kmovw	k3, edi
	mov	edi, -86
	vpmaxuq	zmm4, zmm6, ZMMWORD PTR -1648[rbp]
	vpcmpuq	k1, zmm2, ZMMWORD PTR -1648[rbp], 0
	kmovw	k2, edi
	vmovdqa64	zmm3, ZMMWORD PTR -560[rbp]
	vmovdqa64	zmm3{k1}, ZMMWORD PTR -624[rbp]
	vpermq	zmm5, zmm1, zmm2
	vpcmpuq	k1, zmm4, zmm6, 0
	vmovdqa64	zmm6, ZMMWORD PTR -624[rbp]
	vmovdqa64	zmm6{k1}, ZMMWORD PTR -560[rbp]
	vpminuq	zmm0, zmm5, zmm2
	vpmaxuq	zmm0{k4}, zmm5, zmm2
	vpermq	zmm5, zmm1, zmm3
	vpcmpuq	k1, zmm0, zmm2, 0
	vmovdqa64	zmm2, ZMMWORD PTR .LC1[rip]
	vpermq	zmm7, zmm2, zmm0
	vmovdqa64	zmm5{k1}, zmm3
	vpminuq	zmm3, zmm7, zmm0
	vpmaxuq	zmm3{k3}, zmm7, zmm0
	vpermq	zmm8, zmm2, zmm5
	vpcmpuq	k1, zmm3, zmm0, 0
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vpermq	zmm7, zmm0, zmm3
	vmovdqa64	zmm8{k1}, zmm5
	vpminuq	zmm5, zmm7, zmm3
	vpmaxuq	zmm5{k2}, zmm7, zmm3
	vpermq	zmm7, zmm0, zmm8
	vpcmpuq	k1, zmm5, zmm3, 0
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm5
	vmovdqu64	ZMMWORD PTR 512[r15], zmm5
	vmovdqa64	zmm7{k1}, zmm8
	vpermq	zmm8, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm7
	vpminuq	zmm3, zmm8, zmm4
	vpmaxuq	zmm3{k4}, zmm8, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, zmm6
	vmovdqa64	zmm4{k1}, zmm6
	vpermq	zmm6, zmm2, zmm3
	vpminuq	zmm1, zmm6, zmm3
	vpermq	zmm2, zmm2, zmm4
	vpmaxuq	zmm1{k3}, zmm6, zmm3
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vpcmpuq	k1, zmm1, zmm3, 0
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -2096[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm6
	vmovdqa64	zmm2{k1}, zmm4
	vmovdqa64	zmm6, ZMMWORD PTR -2032[rbp]
	vpermq	zmm4, zmm0, zmm1
	vpminuq	zmm3, zmm4, zmm1
	vpermq	zmm0, zmm0, zmm2
	vmovdqu64	ZMMWORD PTR 128[r15], zmm6
	vpmaxuq	zmm3{k2}, zmm4, zmm1
	vmovdqa64	zmm6, ZMMWORD PTR -1968[rbp]
	kmovw	k2, r13d
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm3
	vmovdqu64	ZMMWORD PTR 192[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR 256[r15], zmm6
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	zmm6, ZMMWORD PTR -1840[rbp]
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm0
	vmovdqu64	ZMMWORD PTR 320[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1776[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1712[rbp]
	vmovdqu64	ZMMWORD PTR 448[r15], zmm6
	vmovdqa64	zmm5, ZMMWORD PTR -1136[rbp]
	mov	rax, QWORD PTR -2240[rbp]
	vmovdqu64	ZMMWORD PTR 512[r14], zmm7
	vmovdqu64	ZMMWORD PTR [r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -816[rbp]
	vmovdqu64	ZMMWORD PTR 320[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -752[rbp]
	vmovdqu64	ZMMWORD PTR 384[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -688[rbp]
	vmovdqu64	ZMMWORD PTR 448[r14], zmm5
	vpcompressq	ZMMWORD PTR [rax]{k2}, zmm3
	mov	rax, QWORD PTR -2248[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k2}, zmm0
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L33:
	vmovdqu64	zmm7, ZMMWORD PTR [r15]
	kmovw	k4, r13d
	vmovdqu64	zmm5, ZMMWORD PTR 512[r15]
	lea	rsi, -688[rbp]
	lea	rcx, -752[rbp]
	lea	rdx, -816[rbp]
	vmovdqu64	zmm6, ZMMWORD PTR 576[r15]
	lea	r9, -880[rbp]
	lea	r8, -944[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	lea	rax, 640[r15]
	lea	rbx, 640[r14]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 64[r14]
	lea	rdi, -1968[rbp]
	lea	r11, -2096[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 128[r15]
	lea	r10, -2160[rbp]
	lea	r12, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r15]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 256[r15]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 320[r14]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 320[r15]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 448[r15]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 384[r14]
	vmovdqu64	zmm1{k4}{z}, ZMMWORD PTR 640[r15]
	vmovdqu64	zmm5, ZMMWORD PTR 448[r14]
	push	rsi
	vmovdqu64	zmm6, ZMMWORD PTR 512[r14]
	vpord	zmm1, zmm0, zmm1
	push	rcx
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm1
	vmovdqu64	zmm1{k4}{z}, ZMMWORD PTR 640[r14]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 576[r14]
	push	rdx
	vpord	zmm0, zmm0, zmm1
	push	r9
	mov	QWORD PTR -2168[rbp], rsi
	lea	rsi, -1008[rbp]
	push	r8
	mov	QWORD PTR -2176[rbp], rcx
	lea	rcx, -1072[rbp]
	mov	QWORD PTR -2184[rbp], rdx
	lea	rdx, -1136[rbp]
	mov	QWORD PTR -2192[rbp], r9
	lea	r9, -1712[rbp]
	mov	QWORD PTR -2200[rbp], r8
	lea	r8, -1776[rbp]
	push	rsi
	mov	QWORD PTR -2248[rbp], rax
	lea	rax, -1840[rbp]
	push	rcx
	mov	QWORD PTR -2256[rbp], rbx
	lea	rbx, -1904[rbp]
	push	rdx
	mov	QWORD PTR -2208[rbp], rsi
	mov	rsi, r11
	push	r9
	mov	QWORD PTR -2216[rbp], rcx
	mov	rcx, rdi
	mov	QWORD PTR -2224[rbp], rdx
	mov	rdx, r12
	mov	QWORD PTR -2232[rbp], r9
	mov	r9, rax
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm0
	mov	QWORD PTR -2240[rbp], r8
	push	r8
	mov	r8, rbx
	mov	QWORD PTR -2264[rbp], rdi
	mov	rdi, r10
	mov	QWORD PTR -2288[rbp], rax
	mov	QWORD PTR -2280[rbp], r11
	mov	QWORD PTR -2272[rbp], r10
	vzeroupper
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	lea	rcx, -624[rbp]
	lea	rdx, -1520[rbp]
	lea	rsi, -1584[rbp]
	lea	rdi, -1648[rbp]
	lea	r9, -496[rbp]
	lea	r8, -560[rbp]
	call	_Z15bitonic_sort_3vRDv8_xS0_S0_S0_S0_S0_
	mov	r8, rbx
	mov	rdx, r12
	vmovdqa64	zmm0, ZMMWORD PTR .LC3[rip]
	vpermq	zmm1, zmm0, ZMMWORD PTR -1648[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1712[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1712[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -624[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1712[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1776[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1776[rbp]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1776[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1520[rbp]
	vpermq	zmm0, zmm0, ZMMWORD PTR -496[rbp]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm2
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR -1840[rbp]
	vpminuq	zmm3, zmm1, ZMMWORD PTR -1840[rbp]
	vpcmpuq	k1, zmm2, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -816[rbp]
	vmovdqa64	zmm1{k1}, zmm0
	vpcmpuq	k1, zmm3, ZMMWORD PTR -1840[rbp], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR -816[rbp]
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm0
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm3
	mov	rax, QWORD PTR -2288[rbp]
	mov	r11, QWORD PTR -2280[rbp]
	push	QWORD PTR -2168[rbp]
	mov	r10, QWORD PTR -2272[rbp]
	push	QWORD PTR -2176[rbp]
	mov	r9, rax
	mov	rsi, r11
	mov	rcx, QWORD PTR -2264[rbp]
	push	QWORD PTR -2184[rbp]
	mov	rdi, r10
	push	QWORD PTR -2192[rbp]
	push	QWORD PTR -2200[rbp]
	push	QWORD PTR -2208[rbp]
	push	QWORD PTR -2216[rbp]
	push	QWORD PTR -2224[rbp]
	push	QWORD PTR -2232[rbp]
	push	QWORD PTR -2240[rbp]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm2
	vzeroupper
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	kmovw	k7, r13d
	add	rsp, 80
	vmovdqa64	zmm5, ZMMWORD PTR -1520[rbp]
	mov	edi, -16
	vmovdqa64	zmm6, ZMMWORD PTR -1648[rbp]
	vpminuq	zmm0, zmm5, ZMMWORD PTR -1648[rbp]
	kmovw	k4, edi
	vpminuq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	mov	edi, -52
	vmovdqa64	zmm2, ZMMWORD PTR .LC0[rip]
	vpmaxuq	zmm6, zmm6, zmm5
	vmovdqa64	zmm9, ZMMWORD PTR -496[rbp]
	kmovw	k3, edi
	vpcmpuq	k1, zmm0, ZMMWORD PTR -1648[rbp], 0
	mov	edi, -86
	vmovdqa64	zmm9{k1}, ZMMWORD PTR -624[rbp]
	vmovdqa64	zmm8, ZMMWORD PTR -624[rbp]
	vpermq	zmm4, zmm2, zmm1
	vpcmpuq	k1, zmm6, zmm5, 0
	kmovw	k2, edi
	vmovdqa64	zmm8{k1}, ZMMWORD PTR -496[rbp]
	vpcmpuq	k1, zmm1, zmm0, 0
	vpmaxuq	zmm5, zmm0, ZMMWORD PTR -1584[rbp]
	vpminuq	zmm0, zmm4, zmm1
	vmovdqa64	zmm3, ZMMWORD PTR -560[rbp]
	vpmaxuq	zmm0{k4}, zmm4, zmm1
	vmovdqa64	zmm3{k1}, zmm9
	vpcmpuq	k1, zmm5, ZMMWORD PTR -1584[rbp], 0
	vmovdqa64	zmm9{k1}, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm0, zmm1, 0
	vpermq	zmm7, zmm2, zmm3
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vpermq	zmm4, zmm1, zmm0
	vmovdqa64	zmm7{k1}, zmm3
	vpminuq	zmm3, zmm4, zmm0
	vpmaxuq	zmm3{k3}, zmm4, zmm0
	vpermq	zmm4, zmm1, zmm7
	vpcmpuq	k1, zmm3, zmm0, 0
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vpermq	zmm10, zmm0, zmm3
	vmovdqa64	zmm4{k1}, zmm7
	vpminuq	zmm7, zmm10, zmm3
	vpmaxuq	zmm7{k2}, zmm10, zmm3
	vpermq	zmm10, zmm0, zmm4
	vpcmpuq	k1, zmm7, zmm3, 0
	vpermq	zmm3, zmm2, zmm5
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm7
	vmovdqa64	zmm10{k1}, zmm4
	vpminuq	zmm4, zmm3, zmm5
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm10
	vpmaxuq	zmm4{k4}, zmm3, zmm5
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm2, zmm9
	vmovdqa64	zmm5{k1}, zmm9
	vpermq	zmm9, zmm1, zmm4
	vpminuq	zmm3, zmm9, zmm4
	vpmaxuq	zmm3{k3}, zmm9, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm9, zmm0, zmm3
	vpermq	zmm4, zmm1, zmm5
	vmovdqa64	zmm4{k1}, zmm5
	vpminuq	zmm5, zmm9, zmm3
	vpmaxuq	zmm5{k2}, zmm9, zmm3
	vpermq	zmm9, zmm0, zmm4
	vpcmpuq	k1, zmm5, zmm3, 0
	vpermq	zmm3, zmm2, zmm6
	vpermq	zmm2, zmm2, zmm8
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm5
	vmovdqa64	zmm9{k1}, zmm4
	vpminuq	zmm4, zmm3, zmm6
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm9
	vpmaxuq	zmm4{k4}, zmm3, zmm6
	vpcmpuq	k1, zmm4, zmm6, 0
	vpermq	zmm6, zmm1, zmm4
	vpminuq	zmm3, zmm6, zmm4
	vpmaxuq	zmm3{k3}, zmm6, zmm4
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vmovdqa64	zmm2{k1}, zmm8
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm0, zmm3
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	vpermq	zmm1, zmm1, zmm2
	vmovdqa64	zmm6, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm1{k1}, zmm2
	vmovdqu64	ZMMWORD PTR 64[r15], zmm6
	vpminuq	zmm2, zmm4, zmm3
	vmovdqa64	zmm6, ZMMWORD PTR -2032[rbp]
	vpmaxuq	zmm2{k2}, zmm4, zmm3
	vpermq	zmm0, zmm0, zmm1
	vmovdqu64	ZMMWORD PTR 128[r15], zmm6
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm6, ZMMWORD PTR -1968[rbp]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm2
	vmovdqu64	ZMMWORD PTR 192[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1904[rbp]
	vmovdqa64	zmm0{k1}, zmm1
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm0
	vmovdqu64	ZMMWORD PTR 256[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1840[rbp]
	mov	rax, QWORD PTR -2248[rbp]
	vmovdqu64	ZMMWORD PTR 512[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR 576[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 320[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1776[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -816[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1712[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -752[rbp]
	vmovdqu64	ZMMWORD PTR 320[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -688[rbp]
	vmovdqu64	ZMMWORD PTR 448[r15], zmm6
	vmovdqu64	ZMMWORD PTR 384[r14], zmm7
	vmovdqu64	ZMMWORD PTR 448[r14], zmm5
	vmovdqu64	ZMMWORD PTR 512[r14], zmm10
	vmovdqu64	ZMMWORD PTR 576[r14], zmm9
	vpcompressq	ZMMWORD PTR [rax]{k7}, zmm2
	mov	rax, QWORD PTR -2256[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k7}, zmm0
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L32:
	vmovdqu64	zmm7, ZMMWORD PTR [r15]
	vmovdqu64	zmm5, ZMMWORD PTR 64[r15]
	kmovw	k2, r13d
	lea	rcx, -688[rbp]
	lea	rdx, -752[rbp]
	lea	r9, -816[rbp]
	vmovdqu64	zmm6, ZMMWORD PTR 640[r15]
	lea	r8, -880[rbp]
	lea	r12, -944[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 128[r15]
	lea	rax, 704[r15]
	lea	rbx, 704[r14]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 192[r15]
	lea	rdi, -1968[rbp]
	lea	rsi, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 256[r15]
	lea	r10, -2096[rbp]
	lea	r11, -2160[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 320[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 448[r15]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 512[r15]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 576[r15]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 320[r14]
	vmovdqu64	zmm1{k2}{z}, ZMMWORD PTR 704[r15]
	vmovdqu64	zmm7, ZMMWORD PTR 384[r14]
	push	rcx
	vmovdqu64	zmm5, ZMMWORD PTR 448[r14]
	vpord	zmm1, zmm0, zmm1
	push	rdx
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm1
	vmovdqu64	zmm1{k2}{z}, ZMMWORD PTR 704[r14]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 512[r14]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm7
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm7, ZMMWORD PTR 576[r14]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 640[r14]
	push	r9
	mov	QWORD PTR -2168[rbp], rcx
	lea	rcx, -1008[rbp]
	push	r8
	mov	QWORD PTR -2176[rbp], rdx
	lea	rdx, -1072[rbp]
	push	r12
	mov	QWORD PTR -2184[rbp], r9
	lea	r9, -1136[rbp]
	mov	QWORD PTR -2192[rbp], r8
	lea	r8, -1712[rbp]
	mov	QWORD PTR -2200[rbp], r12
	lea	r12, -1776[rbp]
	push	rcx
	mov	QWORD PTR -2264[rbp], rax
	lea	rax, -1840[rbp]
	push	rdx
	mov	QWORD PTR -2272[rbp], rbx
	lea	rbx, -1904[rbp]
	mov	QWORD PTR -2208[rbp], rcx
	mov	rcx, rdi
	mov	QWORD PTR -2216[rbp], rdx
	mov	rdx, rsi
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm0
	mov	QWORD PTR -2224[rbp], r9
	push	r9
	mov	r9, rax
	push	r8
	push	r12
	mov	QWORD PTR -2232[rbp], r8
	mov	r8, rbx
	mov	QWORD PTR -2296[rbp], rdi
	mov	rdi, r11
	mov	QWORD PTR -2304[rbp], rsi
	mov	rsi, r10
	mov	QWORD PTR -2240[rbp], r12
	mov	QWORD PTR -2280[rbp], rax
	mov	QWORD PTR -2288[rbp], rbx
	mov	QWORD PTR -2312[rbp], r10
	mov	QWORD PTR -2320[rbp], r11
	vzeroupper
	lea	rbx, -624[rbp]
	lea	r12, -1520[rbp]
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	mov	r8, rbx
	lea	rsi, -432[rbp]
	push	rsi
	lea	r10, -1456[rbp]
	mov	rdx, r12
	lea	rax, -560[rbp]
	mov	QWORD PTR -2248[rbp], rsi
	lea	rsi, -496[rbp]
	mov	rdi, r10
	mov	r9, rax
	push	rsi
	lea	r11, -1584[rbp]
	mov	rcx, rdi
	lea	r10, -1648[rbp]
	mov	QWORD PTR -2256[rbp], rsi
	mov	rsi, r11
	mov	QWORD PTR -2328[rbp], rdi
	mov	rdi, r10
	mov	QWORD PTR -2352[rbp], rax
	mov	QWORD PTR -2344[rbp], r11
	mov	QWORD PTR -2336[rbp], r10
	call	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	vmovdqa64	zmm0, ZMMWORD PTR .LC3[rip]
	vpermq	zmm1, zmm0, ZMMWORD PTR -1648[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1712[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1712[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -624[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1712[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1776[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1776[rbp]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1776[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1520[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1840[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1840[rbp]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -496[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -816[rbp]
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1840[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -816[rbp]
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm4
	vpermq	zmm1, zmm0, ZMMWORD PTR -1456[rbp]
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR -1904[rbp]
	vpermq	zmm0, zmm0, ZMMWORD PTR -432[rbp]
	push	QWORD PTR -2168[rbp]
	vpcmpuq	k1, zmm2, zmm1, 0
	push	QWORD PTR -2176[rbp]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm3
	vpminuq	zmm3, zmm1, ZMMWORD PTR -1904[rbp]
	vmovdqa64	zmm1, ZMMWORD PTR -880[rbp]
	push	QWORD PTR -2184[rbp]
	push	QWORD PTR -2192[rbp]
	vmovdqa64	zmm1{k1}, zmm0
	push	QWORD PTR -2200[rbp]
	vpcmpuq	k1, zmm3, ZMMWORD PTR -1904[rbp], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR -880[rbp]
	push	QWORD PTR -2208[rbp]
	push	QWORD PTR -2216[rbp]
	push	QWORD PTR -2224[rbp]
	push	QWORD PTR -2232[rbp]
	push	QWORD PTR -2240[rbp]
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm0
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm3
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm2
	mov	r9, QWORD PTR -2280[rbp]
	mov	r8, QWORD PTR -2288[rbp]
	mov	rcx, QWORD PTR -2296[rbp]
	mov	rdx, QWORD PTR -2304[rbp]
	mov	rsi, QWORD PTR -2312[rbp]
	mov	rdi, QWORD PTR -2320[rbp]
	vzeroupper
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 96
	mov	rax, QWORD PTR -2352[rbp]
	push	QWORD PTR -2248[rbp]
	mov	r8, rbx
	mov	rdx, r12
	mov	r11, QWORD PTR -2344[rbp]
	mov	r10, QWORD PTR -2336[rbp]
	push	QWORD PTR -2256[rbp]
	mov	r9, rax
	mov	rcx, QWORD PTR -2328[rbp]
	mov	rsi, r11
	mov	rdi, r10
	call	_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	kmovw	k4, r13d
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vmovdqa64	zmm7, ZMMWORD PTR -2096[rbp]
	vmovdqa64	zmm5, ZMMWORD PTR -2032[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1968[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR 128[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1840[rbp]
	vmovdqu64	ZMMWORD PTR 192[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1776[rbp]
	vmovdqu64	ZMMWORD PTR 256[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1712[rbp]
	vmovdqu64	ZMMWORD PTR 320[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1648[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1584[rbp]
	vmovdqu64	ZMMWORD PTR 448[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1520[rbp]
	vmovdqu64	ZMMWORD PTR 512[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR 576[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR 640[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm5
	vmovdqu64	ZMMWORD PTR 256[r14], zmm6
	vmovdqu64	ZMMWORD PTR 128[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -816[rbp]
	vmovdqa64	zmm5, ZMMWORD PTR -752[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -688[rbp]
	mov	rax, QWORD PTR -2264[rbp]
	vmovdqu64	ZMMWORD PTR 320[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -624[rbp]
	vmovdqu64	ZMMWORD PTR 384[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -560[rbp]
	vmovdqu64	ZMMWORD PTR 448[r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -496[rbp]
	vmovdqu64	ZMMWORD PTR 512[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1456[rbp]
	vmovdqu64	ZMMWORD PTR 640[r14], zmm6
	vmovdqu64	ZMMWORD PTR 576[r14], zmm5
	vpcompressq	ZMMWORD PTR [rax]{k4}, zmm7
	mov	rax, QWORD PTR -2272[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -432[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k4}, zmm6
	pop	rdi
	pop	r8
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L31:
	vmovdqu64	zmm7, ZMMWORD PTR [r15]
	vmovdqu64	zmm5, ZMMWORD PTR 64[r15]
	kmovw	k7, r13d
	lea	rcx, -688[rbp]
	lea	rdx, -752[rbp]
	lea	r9, -816[rbp]
	vmovdqu64	zmm6, ZMMWORD PTR 128[r15]
	lea	r8, -880[rbp]
	lea	r12, -944[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r15]
	lea	rax, 768[r15]
	lea	rbx, 768[r14]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 256[r15]
	lea	rdi, -2032[rbp]
	lea	r11, -1904[rbp]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 320[r15]
	lea	r10, -2160[rbp]
	lea	rsi, -2096[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 448[r15]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 512[r15]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 576[r15]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 640[r15]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 704[r15]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r14]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 256[r14]
	vmovdqu64	zmm6, ZMMWORD PTR 320[r14]
	vmovdqu64	zmm1{k7}{z}, ZMMWORD PTR 768[r15]
	push	rcx
	vmovdqu64	zmm7, ZMMWORD PTR 384[r14]
	push	rdx
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm5
	vpord	zmm1, zmm0, zmm1
	vmovdqu64	zmm5, ZMMWORD PTR 448[r14]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 512[r14]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm1
	vmovdqu64	zmm1{k7}{z}, ZMMWORD PTR 768[r14]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 576[r14]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm5
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm5, ZMMWORD PTR 640[r14]
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 704[r14]
	push	r9
	mov	QWORD PTR -2184[rbp], rcx
	lea	rcx, -1008[rbp]
	push	r8
	mov	QWORD PTR -2192[rbp], rdx
	lea	rdx, -1072[rbp]
	push	r12
	mov	QWORD PTR -2200[rbp], r9
	lea	r9, -1136[rbp]
	mov	QWORD PTR -2208[rbp], r8
	lea	r8, -1712[rbp]
	mov	QWORD PTR -2216[rbp], r12
	lea	r12, -1776[rbp]
	mov	QWORD PTR -2296[rbp], rax
	lea	rax, -1840[rbp]
	mov	QWORD PTR -2304[rbp], rbx
	lea	rbx, -1968[rbp]
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm0
	mov	QWORD PTR -2224[rbp], rcx
	push	rcx
	mov	rcx, rbx
	push	rdx
	push	r9
	push	r8
	push	r12
	mov	QWORD PTR -2232[rbp], rdx
	mov	rdx, rdi
	mov	QWORD PTR -2240[rbp], r9
	mov	r9, rax
	mov	QWORD PTR -2248[rbp], r8
	mov	r8, r11
	mov	QWORD PTR -2320[rbp], rdi
	mov	rdi, r10
	mov	QWORD PTR -2256[rbp], r12
	mov	QWORD PTR -2352[rbp], rax
	mov	QWORD PTR -2344[rbp], r11
	mov	QWORD PTR -2312[rbp], rbx
	mov	QWORD PTR -2328[rbp], rsi
	mov	QWORD PTR -2336[rbp], r10
	vzeroupper
	lea	rbx, -624[rbp]
	lea	r12, -1584[rbp]
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	mov	rsi, r12
	lea	r9, -432[rbp]
	lea	r8, -496[rbp]
	push	r9
	lea	r10, -1520[rbp]
	push	r8
	lea	r11, -1648[rbp]
	mov	rdx, r10
	lea	rax, -560[rbp]
	lea	rdi, -1456[rbp]
	mov	QWORD PTR -2168[rbp], r9
	mov	r9, rax
	mov	QWORD PTR -2176[rbp], r8
	mov	rcx, rdi
	mov	r8, rbx
	mov	QWORD PTR -2272[rbp], rdi
	mov	rdi, r11
	mov	QWORD PTR -2280[rbp], r10
	mov	QWORD PTR -2288[rbp], r11
	mov	QWORD PTR -2264[rbp], rax
	call	_Z15bitonic_sort_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	mov	edx, 102
	mov	r8, rbx
	mov	rsi, r12
	vmovdqa64	zmm1, ZMMWORD PTR -1392[rbp]
	kmovw	k2, edx
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	mov	edx, 60
	kmovw	k3, edx
	mov	edx, 90
	vpermq	zmm5, zmm0, ZMMWORD PTR -368[rbp]
	movzx	r10d, BYTE PTR .LC4[rip]
	vpermq	zmm3, zmm0, zmm1
	kmovw	k4, edx
	movzx	r11d, BYTE PTR .LC5[rip]
	push	QWORD PTR -2168[rbp]
	vpminuq	zmm2, zmm3, zmm1
	kmovw	k6, r10d
	movzx	r10d, BYTE PTR .LC6[rip]
	push	QWORD PTR -2176[rbp]
	vpmaxuq	zmm2{k2}, zmm3, zmm1
	kmovw	k7, r11d
	mov	r9, QWORD PTR -2264[rbp]
	vpcmpuq	k1, zmm2, zmm1, 0
	kmovw	k5, r10d
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	vmovdqa64	zmm5{k1}, ZMMWORD PTR -368[rbp]
	mov	rcx, QWORD PTR -2272[rbp]
	mov	rdx, QWORD PTR -2280[rbp]
	vpermq	zmm4, zmm1, zmm2
	mov	rdi, QWORD PTR -2288[rbp]
	vpminuq	zmm3, zmm4, zmm2
	vpmaxuq	zmm3{k3}, zmm4, zmm2
	vpermq	zmm4, zmm1, zmm5
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqa64	zmm4{k1}, zmm5
	vpermq	zmm5, zmm0, zmm3
	vpminuq	zmm2, zmm5, zmm3
	vpermq	zmm6, zmm0, zmm4
	vpmaxuq	zmm2{k4}, zmm5, zmm3
	vpcmpuq	k1, zmm2, zmm3, 0
	vmovdqa64	zmm3, ZMMWORD PTR .LC0[rip]
	vpermq	zmm5, zmm3, zmm2
	vmovdqa64	zmm6{k1}, zmm4
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k6}, zmm5, zmm2
	vpermq	zmm5, zmm3, zmm6
	vpcmpuq	k1, zmm4, zmm2, 0
	vmovdqa64	zmm5{k1}, zmm6
	vpermq	zmm6, zmm1, zmm4
	vpminuq	zmm2, zmm6, zmm4
	vpmaxuq	zmm2{k7}, zmm6, zmm4
	vpermq	zmm6, zmm1, zmm5
	vpcmpuq	k1, zmm2, zmm4, 0
	vmovdqa64	zmm6{k1}, zmm5
	vpermq	zmm5, zmm0, zmm2
	vpminuq	zmm4, zmm5, zmm2
	vpmaxuq	zmm4{k5}, zmm5, zmm2
	vpermq	zmm5, zmm0, zmm6
	vpcmpuq	k1, zmm4, zmm2, 0
	vmovdqa64	zmm2, ZMMWORD PTR .LC3[rip]
	vpermq	zmm4, zmm2, zmm4
	vpminuq	zmm7, zmm4, ZMMWORD PTR -1456[rbp]
	vmovdqa64	zmm5{k1}, zmm6
	vpmaxuq	zmm6, zmm4, ZMMWORD PTR -1456[rbp]
	vpermq	zmm5, zmm2, zmm5
	vpcmpuq	k1, zmm6, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR -432[rbp]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm6
	vmovdqa64	zmm4{k1}, zmm5
	vpcmpuq	k1, zmm7, ZMMWORD PTR -1456[rbp], 0
	vmovdqa64	zmm5{k1}, ZMMWORD PTR -432[rbp]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm5
	vzeroupper
	call	_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	movzx	r11d, BYTE PTR .LC4[rip]
	add	rsp, 32
	vmovdqa64	zmm4, ZMMWORD PTR -1392[rbp]
	movzx	r10d, BYTE PTR .LC5[rip]
	vmovdqa64	zmm3, ZMMWORD PTR .LC0[rip]
	kmovw	k2, r11d
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	kmovw	k3, r10d
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	movzx	r11d, BYTE PTR .LC6[rip]
	vmovdqa64	zmm2, ZMMWORD PTR .LC3[rip]
	vpermq	zmm6, zmm3, zmm4
	vpminuq	zmm5, zmm6, zmm4
	kmovw	k4, r11d
	vpmaxuq	zmm5{k2}, zmm6, zmm4
	vpermq	zmm6, zmm3, ZMMWORD PTR -368[rbp]
	vpermq	zmm7, zmm1, zmm5
	vpcmpuq	k1, zmm5, zmm4, 0
	vmovdqa64	zmm6{k1}, ZMMWORD PTR -368[rbp]
	vpminuq	zmm4, zmm7, zmm5
	vpmaxuq	zmm4{k3}, zmm7, zmm5
	vpermq	zmm7, zmm1, zmm6
	vpcmpuq	k1, zmm4, zmm5, 0
	vmovdqa64	zmm7{k1}, zmm6
	vpermq	zmm6, zmm0, zmm4
	vpminuq	zmm5, zmm6, zmm4
	vpmaxuq	zmm5{k4}, zmm6, zmm4
	vpermq	zmm6, zmm0, zmm7
	vpcmpuq	k1, zmm5, zmm4, 0
	vpermq	zmm4, zmm2, ZMMWORD PTR -1648[rbp]
	vpmaxuq	zmm8, zmm4, ZMMWORD PTR -1712[rbp]
	vpminuq	zmm9, zmm4, ZMMWORD PTR -1712[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm8
	vmovdqa64	zmm6{k1}, zmm7
	vpcmpuq	k1, zmm8, zmm4, 0
	vpermq	zmm7, zmm2, ZMMWORD PTR -624[rbp]
	vmovdqa64	zmm4, ZMMWORD PTR -688[rbp]
	vmovdqa64	zmm4{k1}, zmm7
	vpcmpuq	k1, zmm9, ZMMWORD PTR -1712[rbp], 0
	vmovdqa64	zmm7{k1}, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm9
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm4
	vpermq	zmm4, zmm2, ZMMWORD PTR -1584[rbp]
	vpmaxuq	zmm8, zmm4, ZMMWORD PTR -1776[rbp]
	vpminuq	zmm9, zmm4, ZMMWORD PTR -1776[rbp]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm7
	vpermq	zmm7, zmm2, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm8, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm8
	vmovdqa64	zmm4{k1}, zmm7
	vpcmpuq	k1, zmm9, ZMMWORD PTR -1776[rbp], 0
	vmovdqa64	zmm7{k1}, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm9
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm7
	vpermq	zmm4, zmm2, ZMMWORD PTR -1520[rbp]
	vpmaxuq	zmm8, zmm4, ZMMWORD PTR -1840[rbp]
	vpminuq	zmm9, zmm4, ZMMWORD PTR -1840[rbp]
	vpermq	zmm7, zmm2, ZMMWORD PTR -496[rbp]
	vpcmpuq	k1, zmm8, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR -816[rbp]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm8
	vmovdqa64	zmm4{k1}, zmm7
	vpcmpuq	k1, zmm9, ZMMWORD PTR -1840[rbp], 0
	vmovdqa64	zmm7{k1}, ZMMWORD PTR -816[rbp]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm9
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm4
	vpermq	zmm4, zmm2, ZMMWORD PTR -1456[rbp]
	vpmaxuq	zmm8, zmm4, ZMMWORD PTR -1904[rbp]
	vpminuq	zmm9, zmm4, ZMMWORD PTR -1904[rbp]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm7
	vpermq	zmm7, zmm2, ZMMWORD PTR -432[rbp]
	vpcmpuq	k1, zmm8, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR -880[rbp]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm8
	vmovdqa64	zmm4{k1}, zmm7
	vpcmpuq	k1, zmm9, ZMMWORD PTR -1904[rbp], 0
	vmovdqa64	zmm7{k1}, ZMMWORD PTR -880[rbp]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm9
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm4
	vpermq	zmm4, zmm2, zmm5
	vpmaxuq	zmm5, zmm4, ZMMWORD PTR -1968[rbp]
	vpermq	zmm2, zmm2, zmm6
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm7
	vpminuq	zmm7, zmm4, ZMMWORD PTR -1968[rbp]
	vpcmpuq	k1, zmm5, zmm4, 0
	vmovdqa64	zmm4, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm5
	vmovdqa64	zmm4{k1}, zmm2
	vpcmpuq	k1, zmm7, ZMMWORD PTR -1968[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm2
	push	QWORD PTR -2184[rbp]
	mov	rax, QWORD PTR -2352[rbp]
	mov	r11, QWORD PTR -2344[rbp]
	push	QWORD PTR -2192[rbp]
	mov	r10, QWORD PTR -2336[rbp]
	push	QWORD PTR -2200[rbp]
	mov	r9, rax
	mov	rcx, QWORD PTR -2312[rbp]
	push	QWORD PTR -2208[rbp]
	mov	r8, r11
	mov	rdx, QWORD PTR -2320[rbp]
	push	QWORD PTR -2216[rbp]
	mov	rdi, r10
	mov	rsi, QWORD PTR -2328[rbp]
	push	QWORD PTR -2224[rbp]
	push	QWORD PTR -2232[rbp]
	push	QWORD PTR -2240[rbp]
	push	QWORD PTR -2248[rbp]
	push	QWORD PTR -2256[rbp]
	vzeroupper
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	vmovdqa64	zmm7, ZMMWORD PTR -1392[rbp]
	vpminuq	zmm5, zmm7, ZMMWORD PTR -1648[rbp]
	mov	r8, rbx
	mov	rsi, r12
	vmovdqa64	zmm2, ZMMWORD PTR -624[rbp]
	vpmaxuq	zmm4, zmm7, ZMMWORD PTR -1648[rbp]
	push	QWORD PTR -2168[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -368[rbp]
	push	QWORD PTR -2176[rbp]
	vpcmpuq	k1, zmm5, ZMMWORD PTR -1648[rbp], 0
	mov	r9, QWORD PTR -2264[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm5
	mov	rcx, QWORD PTR -2272[rbp]
	mov	rdx, QWORD PTR -2280[rbp]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm4
	vmovdqa64	zmm6{k1}, zmm2
	vpcmpuq	k1, zmm4, zmm7, 0
	mov	rdi, QWORD PTR -2288[rbp]
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -368[rbp]
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm2
	vzeroupper
	call	_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	movzx	edi, BYTE PTR .LC4[rip]
	kmovw	k2, r13d
	vmovdqa64	zmm2, ZMMWORD PTR -1392[rbp]
	vmovdqa64	zmm3, ZMMWORD PTR .LC0[rip]
	vmovdqa64	zmm1, ZMMWORD PTR .LC1[rip]
	kmovw	k6, edi
	movzx	edi, BYTE PTR .LC5[rip]
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vpermq	zmm5, zmm3, zmm2
	vpermq	zmm3, zmm3, ZMMWORD PTR -368[rbp]
	vpminuq	zmm4, zmm5, zmm2
	kmovw	k7, edi
	vmovdqa64	zmm7, ZMMWORD PTR -2096[rbp]
	movzx	edi, BYTE PTR .LC6[rip]
	vmovdqa64	zmm6, ZMMWORD PTR -1968[rbp]
	vpmaxuq	zmm4{k6}, zmm5, zmm2
	vpermq	zmm5, zmm1, zmm4
	vpcmpuq	k1, zmm4, zmm2, 0
	vmovdqu64	ZMMWORD PTR 64[r15], zmm7
	kmovw	k5, edi
	vmovdqa64	zmm3{k1}, ZMMWORD PTR -368[rbp]
	vpminuq	zmm2, zmm5, zmm4
	vmovdqa64	zmm7, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR 192[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1776[rbp]
	vpmaxuq	zmm2{k7}, zmm5, zmm4
	vmovdqa64	zmm5, ZMMWORD PTR -2160[rbp]
	vpcmpuq	k1, zmm2, zmm4, 0
	vpermq	zmm1, zmm1, zmm3
	vpermq	zmm4, zmm0, zmm2
	vmovdqu64	ZMMWORD PTR 256[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1712[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -2032[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1584[rbp]
	vmovdqu64	ZMMWORD PTR 128[r15], zmm5
	vmovdqa64	zmm1{k1}, zmm3
	vpminuq	zmm3, zmm4, zmm2
	vmovdqa64	zmm5, ZMMWORD PTR -1840[rbp]
	vpmaxuq	zmm3{k5}, zmm4, zmm2
	vpermq	zmm0, zmm0, zmm1
	vmovdqu64	ZMMWORD PTR 448[r15], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1520[rbp]
	vpcmpuq	k1, zmm3, zmm2, 0
	vmovdqu64	ZMMWORD PTR 320[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1648[rbp]
	vmovdqu64	ZMMWORD PTR 576[r15], zmm6
	vmovdqu64	ZMMWORD PTR 512[r15], zmm5
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm3
	vmovdqa64	zmm0{k1}, zmm1
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm0
	vmovdqu64	ZMMWORD PTR 640[r15], zmm7
	vmovdqa64	zmm5, ZMMWORD PTR -1456[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -1136[rbp]
	vmovdqa64	zmm7, ZMMWORD PTR -1072[rbp]
	mov	rax, QWORD PTR -2296[rbp]
	vmovdqu64	ZMMWORD PTR 704[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -816[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -752[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -688[rbp]
	vmovdqu64	ZMMWORD PTR 320[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -624[rbp]
	vmovdqu64	ZMMWORD PTR 384[r14], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -560[rbp]
	vmovdqu64	ZMMWORD PTR 448[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -496[rbp]
	vmovdqu64	ZMMWORD PTR 512[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -432[rbp]
	vmovdqu64	ZMMWORD PTR 576[r14], zmm6
	vmovdqu64	ZMMWORD PTR 640[r14], zmm7
	vmovdqu64	ZMMWORD PTR 704[r14], zmm5
	vpcompressq	ZMMWORD PTR [rax]{k2}, zmm3
	mov	rax, QWORD PTR -2304[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k2}, zmm0
	pop	rcx
	pop	rsi
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L30:
	vmovdqu64	zmm6, ZMMWORD PTR [r15]
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	kmovw	k4, r13d
	lea	rcx, -688[rbp]
	lea	rdx, -752[rbp]
	lea	r9, -816[rbp]
	vmovdqu64	zmm5, ZMMWORD PTR 128[r15]
	lea	r8, -880[rbp]
	lea	r12, -944[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 192[r15]
	lea	rax, 832[r15]
	lea	rbx, 832[r14]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 256[r15]
	lea	rdi, -1968[rbp]
	lea	rsi, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 320[r15]
	lea	r11, -2096[rbp]
	lea	r10, -2160[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 448[r15]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 512[r15]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 576[r15]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 640[r15]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 704[r15]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 768[r15]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 64[r14]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 128[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r14]
	vmovdqu64	zmm5, ZMMWORD PTR 256[r14]
	vmovdqu64	zmm6, ZMMWORD PTR 320[r14]
	push	rcx
	vmovdqu64	zmm1{k4}{z}, ZMMWORD PTR 832[r15]
	push	rdx
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 384[r14]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm5
	vpord	zmm1, zmm0, zmm1
	vmovdqu64	zmm5, ZMMWORD PTR 448[r14]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 512[r14]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 576[r14]
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm1
	vmovdqu64	zmm1{k4}{z}, ZMMWORD PTR 832[r14]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 640[r14]
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm6
	vpord	zmm0, zmm0, zmm1
	vmovdqu64	zmm6, ZMMWORD PTR 704[r14]
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 768[r14]
	push	r9
	mov	QWORD PTR -2280[rbp], rax
	lea	rax, -1904[rbp]
	mov	QWORD PTR -2288[rbp], rbx
	lea	rbx, -1840[rbp]
	mov	QWORD PTR -2168[rbp], rcx
	lea	rcx, -1008[rbp]
	mov	QWORD PTR -2176[rbp], rdx
	lea	rdx, -1072[rbp]
	mov	QWORD PTR -2184[rbp], r9
	lea	r9, -1136[rbp]
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm0
	mov	QWORD PTR -2192[rbp], r8
	push	r8
	lea	r8, -1712[rbp]
	push	r12
	mov	QWORD PTR -2200[rbp], r12
	lea	r12, -1776[rbp]
	push	rcx
	push	rdx
	push	r9
	push	r8
	push	r12
	mov	QWORD PTR -2208[rbp], rcx
	mov	rcx, rdi
	mov	QWORD PTR -2216[rbp], rdx
	mov	rdx, rsi
	mov	QWORD PTR -2224[rbp], r9
	mov	r9, rbx
	mov	QWORD PTR -2232[rbp], r8
	mov	r8, rax
	mov	QWORD PTR -2296[rbp], rdi
	mov	rdi, r10
	mov	QWORD PTR -2304[rbp], rsi
	mov	rsi, r11
	mov	QWORD PTR -2240[rbp], r12
	mov	QWORD PTR -2352[rbp], rax
	mov	QWORD PTR -2312[rbp], r11
	mov	QWORD PTR -2320[rbp], r10
	vzeroupper
	lea	r12, -1648[rbp]
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	lea	rdx, -304[rbp]
	lea	rdi, -432[rbp]
	push	rdx
	lea	rsi, -496[rbp]
	lea	r9, -560[rbp]
	lea	r8, -624[rbp]
	lea	rdx, -368[rbp]
	mov	QWORD PTR -2248[rbp], rdi
	push	rdx
	lea	rax, -1584[rbp]
	lea	r10, -1456[rbp]
	push	rdi
	mov	rcx, r10
	mov	rdi, r12
	lea	r11, -1520[rbp]
	push	rsi
	mov	rdx, r11
	push	r9
	push	r8
	mov	QWORD PTR -2256[rbp], rsi
	mov	rsi, rax
	mov	QWORD PTR -2264[rbp], r9
	lea	r9, -1328[rbp]
	mov	QWORD PTR -2272[rbp], r8
	lea	r8, -1392[rbp]
	mov	QWORD PTR -2328[rbp], rax
	mov	QWORD PTR -2344[rbp], r10
	mov	QWORD PTR -2336[rbp], r11
	call	_Z15bitonic_sort_6vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 48
	mov	r9, rbx
	vmovdqa64	zmm0, ZMMWORD PTR .LC3[rip]
	vpermq	zmm1, zmm0, ZMMWORD PTR -1648[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1712[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1712[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -624[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1712[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1776[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1776[rbp]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1776[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1520[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1840[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1840[rbp]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -496[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -816[rbp]
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1840[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -816[rbp]
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm4
	vpermq	zmm1, zmm0, ZMMWORD PTR -1456[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -432[rbp]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm3
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1904[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1904[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -880[rbp]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1904[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -880[rbp]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1392[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1968[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1968[rbp]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -368[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1968[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1328[rbp]
	vpermq	zmm0, zmm0, ZMMWORD PTR -304[rbp]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm2
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR -2032[rbp]
	vpminuq	zmm3, zmm1, ZMMWORD PTR -2032[rbp]
	vpcmpuq	k1, zmm2, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -1008[rbp]
	vmovdqa64	zmm1{k1}, zmm0
	vpcmpuq	k1, zmm3, ZMMWORD PTR -2032[rbp], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR -1008[rbp]
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm0
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm3
	mov	rax, QWORD PTR -2352[rbp]
	mov	rcx, QWORD PTR -2296[rbp]
	push	QWORD PTR -2168[rbp]
	mov	rdx, QWORD PTR -2304[rbp]
	mov	rsi, QWORD PTR -2312[rbp]
	push	QWORD PTR -2176[rbp]
	mov	r8, rax
	mov	rdi, QWORD PTR -2320[rbp]
	push	QWORD PTR -2184[rbp]
	push	QWORD PTR -2192[rbp]
	push	QWORD PTR -2200[rbp]
	push	QWORD PTR -2208[rbp]
	push	QWORD PTR -2216[rbp]
	push	QWORD PTR -2224[rbp]
	push	QWORD PTR -2232[rbp]
	push	QWORD PTR -2240[rbp]
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm2
	vzeroupper
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	vmovdqa64	zmm0, ZMMWORD PTR -1392[rbp]
	push	QWORD PTR -2248[rbp]
	mov	r10, QWORD PTR -2344[rbp]
	mov	rdi, r12
	vpminuq	zmm2, zmm0, ZMMWORD PTR -1648[rbp]
	push	QWORD PTR -2256[rbp]
	vpmaxuq	zmm1, zmm0, ZMMWORD PTR -1648[rbp]
	mov	rcx, r10
	mov	r11, QWORD PTR -2336[rbp]
	mov	r9, QWORD PTR -2264[rbp]
	vpcmpuq	k1, zmm2, ZMMWORD PTR -1648[rbp], 0
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm2
	vmovdqa64	zmm0, ZMMWORD PTR -624[rbp]
	mov	r8, QWORD PTR -2272[rbp]
	vmovdqa64	zmm3, ZMMWORD PTR -368[rbp]
	mov	rdx, r11
	vmovdqa64	zmm3{k1}, zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR -1392[rbp], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR -368[rbp]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm3
	vmovdqa64	zmm3, ZMMWORD PTR -304[rbp]
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1328[rbp]
	vpminuq	zmm2, zmm0, ZMMWORD PTR -1584[rbp]
	vpmaxuq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	vmovdqa64	zmm0, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm2, ZMMWORD PTR -1584[rbp], 0
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm2
	vmovdqa64	zmm3{k1}, zmm0
	vpcmpuq	k1, zmm1, ZMMWORD PTR -1328[rbp], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR -304[rbp]
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm3
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm0
	mov	rsi, QWORD PTR -2328[rbp]
	vzeroupper
	call	_Z24sort_bitonic_sequence_4vRDv8_xS0_S0_S0_S0_S0_S0_S0_
	mov	edi, -16
	kmovw	k7, r13d
	vmovdqa64	zmm5, ZMMWORD PTR -1328[rbp]
	kmovw	k4, edi
	mov	edi, -52
	vpmaxuq	zmm4, zmm5, ZMMWORD PTR -1392[rbp]
	vpminuq	zmm2, zmm5, ZMMWORD PTR -1392[rbp]
	kmovw	k3, edi
	vmovdqa64	zmm1, ZMMWORD PTR .LC0[rip]
	mov	edi, -86
	vmovdqa64	zmm3, ZMMWORD PTR -304[rbp]
	kmovw	k2, edi
	vmovdqa64	zmm6, ZMMWORD PTR -368[rbp]
	vpcmpuq	k1, zmm2, ZMMWORD PTR -1392[rbp], 0
	vmovdqa64	zmm3{k1}, ZMMWORD PTR -368[rbp]
	vpcmpuq	k1, zmm4, zmm5, 0
	vpermq	zmm5, zmm1, zmm2
	vmovdqa64	zmm6{k1}, ZMMWORD PTR -304[rbp]
	vpminuq	zmm0, zmm5, zmm2
	vpmaxuq	zmm0{k4}, zmm5, zmm2
	vpermq	zmm5, zmm1, zmm3
	vpcmpuq	k1, zmm0, zmm2, 0
	vmovdqa64	zmm2, ZMMWORD PTR .LC1[rip]
	vpermq	zmm7, zmm2, zmm0
	vmovdqa64	zmm5{k1}, zmm3
	vpminuq	zmm3, zmm7, zmm0
	vpmaxuq	zmm3{k3}, zmm7, zmm0
	vpermq	zmm8, zmm2, zmm5
	vpcmpuq	k1, zmm3, zmm0, 0
	vmovdqa64	zmm0, ZMMWORD PTR .LC2[rip]
	vpermq	zmm7, zmm0, zmm3
	vmovdqa64	zmm8{k1}, zmm5
	vpminuq	zmm5, zmm7, zmm3
	vpmaxuq	zmm5{k2}, zmm7, zmm3
	vpermq	zmm7, zmm0, zmm8
	vpcmpuq	k1, zmm5, zmm3, 0
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm5
	vmovdqa64	zmm7{k1}, zmm8
	vpermq	zmm8, zmm1, zmm4
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm7
	vpminuq	zmm3, zmm8, zmm4
	vpmaxuq	zmm3{k4}, zmm8, zmm4
	vpcmpuq	k1, zmm3, zmm4, 0
	vpermq	zmm4, zmm1, zmm6
	vmovdqa64	zmm4{k1}, zmm6
	vpermq	zmm6, zmm2, zmm3
	vpminuq	zmm1, zmm6, zmm3
	vpermq	zmm2, zmm2, zmm4
	vpmaxuq	zmm1{k3}, zmm6, zmm3
	vmovdqa64	zmm6, ZMMWORD PTR -2160[rbp]
	vpcmpuq	k1, zmm1, zmm3, 0
	vmovdqu64	ZMMWORD PTR [r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -2096[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm6
	vmovdqa64	zmm2{k1}, zmm4
	vmovdqa64	zmm6, ZMMWORD PTR -2032[rbp]
	vpermq	zmm4, zmm0, zmm1
	vpminuq	zmm3, zmm4, zmm1
	vpermq	zmm0, zmm0, zmm2
	vmovdqu64	ZMMWORD PTR 128[r15], zmm6
	vpmaxuq	zmm3{k2}, zmm4, zmm1
	vmovdqa64	zmm6, ZMMWORD PTR -1968[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm3
	vmovdqu64	ZMMWORD PTR 192[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR 256[r15], zmm6
	vmovdqa64	zmm0{k1}, zmm2
	vmovdqa64	zmm6, ZMMWORD PTR -1840[rbp]
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm0
	vmovdqu64	ZMMWORD PTR 320[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1776[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1712[rbp]
	vmovdqu64	ZMMWORD PTR 448[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1648[rbp]
	vmovdqu64	ZMMWORD PTR 512[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1584[rbp]
	vmovdqu64	ZMMWORD PTR 768[r15], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR 576[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1520[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1072[rbp]
	vmovdqu64	ZMMWORD PTR 640[r15], zmm6
	vmovdqa64	zmm6, ZMMWORD PTR -1456[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -1008[rbp]
	vmovdqu64	ZMMWORD PTR 704[r15], zmm6
	vmovdqu64	ZMMWORD PTR 128[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 768[r14], zmm7
	vmovdqu64	ZMMWORD PTR 192[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -816[rbp]
	vmovdqu64	ZMMWORD PTR 320[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -752[rbp]
	vmovdqu64	ZMMWORD PTR 384[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -688[rbp]
	vmovdqu64	ZMMWORD PTR 448[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -624[rbp]
	vmovdqu64	ZMMWORD PTR 512[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -560[rbp]
	vmovdqu64	ZMMWORD PTR 576[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -496[rbp]
	vmovdqu64	ZMMWORD PTR 640[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -432[rbp]
	vmovdqu64	ZMMWORD PTR 704[r14], zmm5
	mov	rax, QWORD PTR -2280[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k7}, zmm3
	mov	rax, QWORD PTR -2288[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k7}, zmm0
	pop	rax
	pop	rdx
	jmp	.L26
.L27:
	vmovdqu64	zmm2, ZMMWORD PTR [r15]
	kmovw	k7, r13d
	vmovdqu64	zmm7, ZMMWORD PTR 64[r15]
	lea	rcx, -688[rbp]
	lea	rdx, -752[rbp]
	lea	r9, -816[rbp]
	vmovdqu64	zmm6, ZMMWORD PTR 576[r15]
	vmovdqu64	zmm5, ZMMWORD PTR 704[r15]
	lea	r8, -880[rbp]
	lea	r12, -944[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 128[r15]
	lea	rax, 960[r15]
	lea	rbx, 960[r14]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 192[r15]
	lea	rdi, -1968[rbp]
	lea	rsi, -2032[rbp]
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 256[r15]
	lea	r11, -2096[rbp]
	lea	r10, -2160[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 320[r15]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 384[r15]
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 448[r15]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 512[r15]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 640[r15]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 768[r15]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 832[r15]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 896[r15]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR [r14]
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -1264[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 64[r14]
	vmovdqu64	zmm6, ZMMWORD PTR 128[r14]
	vmovdqu64	zmm7, ZMMWORD PTR 192[r14]
	mov	QWORD PTR -2328[rbp], rax
	lea	rax, -1840[rbp]
	vmovdqu64	zmm5, ZMMWORD PTR 256[r14]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 320[r14]
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 384[r14]
	vmovdqu64	zmm1{k7}{z}, ZMMWORD PTR 960[r15]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 448[r14]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm5
	vpord	zmm1, zmm0, zmm1
	vmovdqu64	zmm5, ZMMWORD PTR 512[r14]
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 576[r14]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 640[r14]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm7
	vmovdqu64	zmm7, ZMMWORD PTR 704[r14]
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm5
	vmovdqu64	zmm5, ZMMWORD PTR 768[r14]
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm2
	vmovdqu64	zmm2, ZMMWORD PTR 832[r14]
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm6
	vmovdqu64	zmm6, ZMMWORD PTR 896[r14]
	mov	QWORD PTR -2336[rbp], rbx
	lea	rbx, -1904[rbp]
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm7
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm5
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -240[rbp], zmm6
	vmovdqa64	ZMMWORD PTR -1200[rbp], zmm1
	vmovdqu64	zmm1{k7}{z}, ZMMWORD PTR 960[r14]
	push	rcx
	mov	QWORD PTR -2168[rbp], rcx
	lea	rcx, -1008[rbp]
	vpord	zmm0, zmm0, zmm1
	push	rdx
	mov	QWORD PTR -2176[rbp], rdx
	lea	rdx, -1072[rbp]
	push	r9
	mov	QWORD PTR -2184[rbp], r9
	lea	r9, -1136[rbp]
	push	r8
	mov	QWORD PTR -2192[rbp], r8
	lea	r8, -1712[rbp]
	push	r12
	mov	QWORD PTR -2200[rbp], r12
	lea	r12, -1776[rbp]
	push	rcx
	push	rdx
	push	r9
	push	r8
	push	r12
	mov	QWORD PTR -2208[rbp], rcx
	mov	rcx, rdi
	mov	QWORD PTR -2216[rbp], rdx
	mov	rdx, rsi
	mov	QWORD PTR -2224[rbp], r9
	mov	r9, rax
	mov	QWORD PTR -2232[rbp], r8
	mov	r8, rbx
	mov	QWORD PTR -2360[rbp], rdi
	mov	rdi, r10
	mov	QWORD PTR -2368[rbp], rsi
	mov	rsi, r11
	mov	QWORD PTR -2240[rbp], r12
	mov	QWORD PTR -2344[rbp], rax
	mov	QWORD PTR -2352[rbp], rbx
	mov	QWORD PTR -2376[rbp], r11
	mov	QWORD PTR -2384[rbp], r10
	vmovdqa64	ZMMWORD PTR -176[rbp], zmm0
	vzeroupper
	lea	rbx, -1392[rbp]
	lea	r12, -1520[rbp]
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	lea	rsi, -176[rbp]
	lea	rcx, -304[rbp]
	push	rsi
	lea	rdx, -368[rbp]
	lea	r9, -432[rbp]
	mov	QWORD PTR -2248[rbp], rsi
	lea	rsi, -240[rbp]
	lea	r8, -496[rbp]
	push	rsi
	lea	r11, -1456[rbp]
	lea	rax, -1328[rbp]
	push	rcx
	mov	rdi, r11
	lea	r10, -1648[rbp]
	lea	r11, -1584[rbp]
	push	rdx
	mov	QWORD PTR -2256[rbp], rsi
	lea	rsi, -560[rbp]
	push	r9
	mov	QWORD PTR -2264[rbp], rcx
	lea	rcx, -624[rbp]
	mov	QWORD PTR -2272[rbp], rdx
	lea	rdx, -1200[rbp]
	mov	QWORD PTR -2280[rbp], r9
	lea	r9, -1264[rbp]
	push	r8
	push	rsi
	push	rcx
	push	rdx
	push	r9
	mov	QWORD PTR -2288[rbp], r8
	mov	r8, rbx
	mov	QWORD PTR -2296[rbp], rsi
	mov	rsi, r11
	mov	QWORD PTR -2304[rbp], rcx
	mov	rcx, rdi
	mov	QWORD PTR -2312[rbp], rdx
	mov	rdx, r12
	mov	QWORD PTR -2320[rbp], r9
	mov	r9, rax
	mov	QWORD PTR -2392[rbp], rdi
	mov	rdi, r10
	mov	QWORD PTR -2416[rbp], rax
	mov	QWORD PTR -2408[rbp], r11
	mov	QWORD PTR -2400[rbp], r10
	call	_Z15bitonic_sort_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	vmovdqa64	zmm0, ZMMWORD PTR .LC3[rip]
	vpermq	zmm1, zmm0, ZMMWORD PTR -1648[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1712[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1712[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -624[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1648[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1712[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -688[rbp]
	vmovdqa64	ZMMWORD PTR -1712[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -624[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1584[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1776[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1776[rbp]
	vmovdqa64	ZMMWORD PTR -688[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -560[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1584[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1776[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -752[rbp]
	vmovdqa64	ZMMWORD PTR -1776[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -560[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1520[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1840[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1840[rbp]
	vmovdqa64	ZMMWORD PTR -752[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -496[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -816[rbp]
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1840[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -816[rbp]
	vmovdqa64	ZMMWORD PTR -496[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -816[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -1840[rbp], zmm4
	vpermq	zmm1, zmm0, ZMMWORD PTR -1456[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -432[rbp]
	vmovdqa64	ZMMWORD PTR -1520[rbp], zmm3
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1904[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1904[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -880[rbp]
	vmovdqa64	ZMMWORD PTR -1456[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1904[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -880[rbp]
	vmovdqa64	ZMMWORD PTR -1904[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -432[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1392[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -1968[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -1968[rbp]
	vmovdqa64	ZMMWORD PTR -880[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -368[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1392[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -1968[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -944[rbp]
	vmovdqa64	ZMMWORD PTR -1968[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -368[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1328[rbp]
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -2032[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -2032[rbp]
	vmovdqa64	ZMMWORD PTR -944[rbp], zmm2
	vpermq	zmm2, zmm0, ZMMWORD PTR -304[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -1008[rbp]
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -2032[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -1008[rbp]
	vmovdqa64	ZMMWORD PTR -304[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -1008[rbp], zmm2
	vmovdqa64	ZMMWORD PTR -2032[rbp], zmm4
	vpermq	zmm1, zmm0, ZMMWORD PTR -1264[rbp]
	vpermq	zmm2, zmm0, ZMMWORD PTR -240[rbp]
	vpminuq	zmm4, zmm1, ZMMWORD PTR -2096[rbp]
	push	QWORD PTR -2168[rbp]
	vmovdqa64	ZMMWORD PTR -1328[rbp], zmm3
	vpmaxuq	zmm3, zmm1, ZMMWORD PTR -2096[rbp]
	push	QWORD PTR -2176[rbp]
	vpcmpuq	k1, zmm3, zmm1, 0
	push	QWORD PTR -2184[rbp]
	vmovdqa64	zmm1, ZMMWORD PTR -1072[rbp]
	push	QWORD PTR -2192[rbp]
	vmovdqa64	ZMMWORD PTR -1264[rbp], zmm3
	vmovdqa64	zmm1{k1}, zmm2
	vpcmpuq	k1, zmm4, ZMMWORD PTR -2096[rbp], 0
	vmovdqa64	zmm2{k1}, ZMMWORD PTR -1072[rbp]
	vmovdqa64	ZMMWORD PTR -2096[rbp], zmm4
	vmovdqa64	ZMMWORD PTR -240[rbp], zmm1
	vpermq	zmm1, zmm0, ZMMWORD PTR -1200[rbp]
	vpermq	zmm0, zmm0, ZMMWORD PTR -176[rbp]
	vmovdqa64	ZMMWORD PTR -1072[rbp], zmm2
	vpmaxuq	zmm2, zmm1, ZMMWORD PTR -2160[rbp]
	vpminuq	zmm3, zmm1, ZMMWORD PTR -2160[rbp]
	vpcmpuq	k1, zmm2, zmm1, 0
	vmovdqa64	zmm1, ZMMWORD PTR -1136[rbp]
	vmovdqa64	ZMMWORD PTR -1200[rbp], zmm2
	vmovdqa64	zmm1{k1}, zmm0
	vpcmpuq	k1, zmm3, ZMMWORD PTR -2160[rbp], 0
	vmovdqa64	zmm0{k1}, ZMMWORD PTR -1136[rbp]
	vmovdqa64	ZMMWORD PTR -2160[rbp], zmm3
	vmovdqa64	ZMMWORD PTR -176[rbp], zmm1
	vmovdqa64	ZMMWORD PTR -1136[rbp], zmm0
	push	QWORD PTR -2200[rbp]
	mov	r9, QWORD PTR -2344[rbp]
	mov	r8, QWORD PTR -2352[rbp]
	push	QWORD PTR -2208[rbp]
	mov	rcx, QWORD PTR -2360[rbp]
	push	QWORD PTR -2216[rbp]
	mov	rdx, QWORD PTR -2368[rbp]
	push	QWORD PTR -2224[rbp]
	mov	rsi, QWORD PTR -2376[rbp]
	push	QWORD PTR -2232[rbp]
	mov	rdi, QWORD PTR -2384[rbp]
	push	QWORD PTR -2240[rbp]
	vzeroupper
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	add	rsp, 80
	mov	rax, QWORD PTR -2416[rbp]
	push	QWORD PTR -2248[rbp]
	mov	r8, rbx
	mov	rdx, r12
	mov	r11, QWORD PTR -2408[rbp]
	mov	r10, QWORD PTR -2400[rbp]
	push	QWORD PTR -2256[rbp]
	mov	r9, rax
	mov	rcx, QWORD PTR -2392[rbp]
	push	QWORD PTR -2264[rbp]
	mov	rsi, r11
	push	QWORD PTR -2272[rbp]
	mov	rdi, r10
	push	QWORD PTR -2280[rbp]
	push	QWORD PTR -2288[rbp]
	push	QWORD PTR -2296[rbp]
	push	QWORD PTR -2304[rbp]
	push	QWORD PTR -2312[rbp]
	push	QWORD PTR -2320[rbp]
	call	_Z24sort_bitonic_sequence_8vRDv8_xS0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_S0_
	kmovw	k2, r13d
	add	rsp, 80
	vmovdqa64	zmm0, ZMMWORD PTR -2160[rbp]
	vmovdqu64	ZMMWORD PTR [r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -2096[rbp]
	vmovdqu64	ZMMWORD PTR 64[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -2032[rbp]
	vmovdqu64	ZMMWORD PTR 128[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1968[rbp]
	vmovdqu64	ZMMWORD PTR 192[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1904[rbp]
	vmovdqu64	ZMMWORD PTR 256[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1840[rbp]
	vmovdqu64	ZMMWORD PTR 320[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1776[rbp]
	vmovdqu64	ZMMWORD PTR 384[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1712[rbp]
	vmovdqu64	ZMMWORD PTR 448[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1648[rbp]
	vmovdqu64	ZMMWORD PTR 512[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1584[rbp]
	vmovdqu64	ZMMWORD PTR 576[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1520[rbp]
	vmovdqu64	ZMMWORD PTR 640[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1456[rbp]
	vmovdqu64	ZMMWORD PTR 704[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1392[rbp]
	vmovdqu64	ZMMWORD PTR 768[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1328[rbp]
	vmovdqu64	ZMMWORD PTR 832[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1264[rbp]
	vmovdqu64	ZMMWORD PTR 896[r15], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1136[rbp]
	vmovdqu64	ZMMWORD PTR [r14], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1072[rbp]
	mov	rax, QWORD PTR -2328[rbp]
	vmovdqa64	zmm7, ZMMWORD PTR -752[rbp]
	vmovdqa64	zmm5, ZMMWORD PTR -624[rbp]
	vmovdqu64	ZMMWORD PTR 64[r14], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -1008[rbp]
	vmovdqa64	zmm2, ZMMWORD PTR -560[rbp]
	vmovdqu64	ZMMWORD PTR 384[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -432[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -496[rbp]
	vmovdqu64	ZMMWORD PTR 128[r14], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -944[rbp]
	vmovdqu64	ZMMWORD PTR 512[r14], zmm5
	vmovdqa64	zmm5, ZMMWORD PTR -304[rbp]
	vmovdqu64	ZMMWORD PTR 192[r14], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -880[rbp]
	vmovdqu64	ZMMWORD PTR 576[r14], zmm2
	vmovdqa64	zmm2, ZMMWORD PTR -240[rbp]
	vmovdqu64	ZMMWORD PTR 256[r14], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -816[rbp]
	vmovdqu64	ZMMWORD PTR 704[r14], zmm7
	vmovdqa64	zmm7, ZMMWORD PTR -1200[rbp]
	vmovdqu64	ZMMWORD PTR 320[r14], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -688[rbp]
	vmovdqu64	ZMMWORD PTR 640[r14], zmm6
	vmovdqu64	ZMMWORD PTR 448[r14], zmm0
	vmovdqa64	zmm0, ZMMWORD PTR -368[rbp]
	vmovdqu64	ZMMWORD PTR 832[r14], zmm5
	vmovdqu64	ZMMWORD PTR 768[r14], zmm0
	vmovdqu64	ZMMWORD PTR 896[r14], zmm2
	vpcompressq	ZMMWORD PTR [rax]{k2}, zmm7
	mov	rax, QWORD PTR -2336[rbp]
	vmovdqa64	zmm6, ZMMWORD PTR -176[rbp]
	vpcompressq	ZMMWORD PTR [rax]{k2}, zmm6
	jmp	.L26
.L48:
	vzeroupper
	call	__stack_chk_fail@PLT
	.size	_Z12bitonic_sortPmS_l, .-_Z12bitonic_sortPmS_l
	.section	.text._Z7do_sortPmS_lll,"axG",@progbits,_Z7do_sortPmS_lll,comdat
	.p2align 4
	.weak	_Z7do_sortPmS_lll
	.type	_Z7do_sortPmS_lll, @function
_Z7do_sortPmS_lll:
	endbr64
	push	r15
	lea	rax, 0[0+rdx*8]
	mov	r15, rsi
	mov	r10, rdx
	push	r14
	mov	r11, r8
	mov	r14, rdi
	push	r13
	push	r12
	mov	r12, rcx
	push	rbp
	lea	rbp, [rdi+rax]
	push	rbx
	sub	rsp, 56
	mov	QWORD PTR 40[rsp], rax
	add	rax, rsi
	mov	QWORD PTR 32[rsp], rax
.L73:
	mov	rdx, r12
	sub	rdx, r10
	cmp	rdx, 127
	jle	.L109
	test	r11, r11
	je	.L110
	sar	rdx
	lea	rbx, 0[0+r12*8]
	mov	rax, QWORD PTR 0[rbp]
	sub	r11, 1
	add	rdx, r10
	lea	r9, [r14+rbx]
	add	rbx, r15
	sal	rdx, 3
	mov	rcx, QWORD PTR [r9]
	lea	r8, [r14+rdx]
	mov	r13, QWORD PTR [r8]
	cmp	r13, rax
	jbe	.L64
	cmp	rax, rcx
	jnb	.L108
	cmp	r13, rcx
	jbe	.L104
.L68:
	cmp	rax, rcx
	jbe	.L80
	cmp	r13, rcx
	jb	.L79
.L80:
	cmp	r13, rcx
	jbe	.L81
	cmp	rax, rcx
	jb	.L79
.L81:
	mov	rax, QWORD PTR [r14]
	mov	rdx, r15
	mov	r8, r14
	.p2align 4,,10
	.p2align 3
.L66:
	mov	QWORD PTR [r8], rcx
	mov	rsi, r15
	mov	rdi, r14
	mov	QWORD PTR [r9], rax
	mov	rax, QWORD PTR [rdx]
	mov	rcx, QWORD PTR [rbx]
	mov	QWORD PTR 24[rsp], r11
	mov	QWORD PTR 16[rsp], r9
	mov	QWORD PTR [rdx], rcx
	mov	rdx, r10
	lea	rcx, -1[r12]
	mov	QWORD PTR [rbx], rax
	mov	r8, QWORD PTR [r9]
	mov	QWORD PTR 8[rsp], r10
	call	_ZL12do_partitionPmS_llm
	mov	r9, QWORD PTR 16[rsp]
	mov	r10, QWORD PTR 8[rsp]
	mov	r13, rax
	lea	rax, 0[0+rax*8]
	mov	r11, QWORD PTR 24[rsp]
	lea	rdx, [r14+rax]
	mov	r8, QWORD PTR [r9]
	add	rax, r15
	mov	rcx, QWORD PTR [rdx]
	mov	QWORD PTR [rdx], r8
	mov	QWORD PTR [r9], rcx
	mov	rdx, QWORD PTR [rax]
	mov	rcx, QWORD PTR [rbx]
	mov	QWORD PTR [rax], rcx
	mov	QWORD PTR [rbx], rdx
	lea	rdx, 1[r13]
	cmp	rdx, r12
	jl	.L111
.L71:
	test	r13, r13
	je	.L105
	lea	r12, -1[r13]
	cmp	r10, r12
	jl	.L73
.L105:
	add	rsp, 56
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.p2align 4,,10
	.p2align 3
.L79:
	mov	rdx, rbx
	mov	rax, rcx
	mov	r8, r9
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L64:
	jnb	.L75
	cmp	rax, rcx
	ja	.L75
.L108:
	mov	rdx, QWORD PTR 32[rsp]
	mov	r8, rbp
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L111:
	mov	r8, r11
	mov	rcx, r12
	mov	QWORD PTR 16[rsp], r10
	mov	QWORD PTR 8[rsp], r11
	call	_Z7do_sortPmS_lll
	mov	r10, QWORD PTR 16[rsp]
	mov	r11, QWORD PTR 8[rsp]
	jmp	.L71
	.p2align 4,,10
	.p2align 3
.L75:
	cmp	r13, rcx
	jnb	.L104
	cmp	r13, rax
	jne	.L68
	add	rdx, r15
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L104:
	add	rdx, r15
	mov	rax, r13
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L109:
	mov	rsi, QWORD PTR 40[rsp]
	add	rsp, 56
	mov	rdi, rbp
	add	rdx, 1
	pop	rbx
	pop	rbp
	add	rsi, r15
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	jmp	_Z12bitonic_sortPmS_l
	.p2align 4,,10
	.p2align 3
.L110:
	lea	r8, 1[rdx]
	mov	rsi, QWORD PTR 40[rsp]
	mov	r10, r8
	sar	r10
	add	rsi, r15
	sub	r10, 1
	.p2align 4,,10
	.p2align 3
.L54:
	lea	r9d, 1[r10+r10]
	movsx	rcx, r10d
	movsx	rax, r9d
	cmp	r8, rax
	jle	.L57
	test	r9d, r9d
	jns	.L52
	jmp	.L57
	.p2align 4,,10
	.p2align 3
.L112:
	add	rax, rsi
	add	rcx, rsi
	mov	QWORD PTR [r12], r11
	mov	QWORD PTR [rbx], rdi
	mov	rdi, QWORD PTR [rcx]
	mov	r11, QWORD PTR [rax]
	mov	QWORD PTR [rcx], r11
	mov	QWORD PTR [rax], rdi
	lea	edi, 1[r9+r9]
	test	edi, edi
	js	.L57
	movsx	rax, edi
	cmp	r8, rax
	jle	.L57
	movsx	rcx, r9d
	mov	r9d, edi
.L52:
	lea	r12d, 2[rcx+rcx]
	sal	rax, 3
	lea	rbx, 0[rbp+rax]
	movsx	rdi, r12d
	mov	r11, QWORD PTR [rbx]
	cmp	r8, rdi
	jle	.L56
	sal	rdi, 3
	lea	r13, 0[rbp+rdi]
	mov	r14, QWORD PTR 0[r13]
	cmp	r14, r11
	jbe	.L56
	mov	r11, r14
	mov	rbx, r13
	mov	rax, rdi
	mov	r9d, r12d
.L56:
	sal	rcx, 3
	lea	r12, 0[rbp+rcx]
	mov	rdi, QWORD PTR [r12]
	cmp	rdi, r11
	jbe	.L112
.L57:
	sub	r10, 1
	cmp	r10, -1
	jne	.L54
	.p2align 4,,10
	.p2align 3
.L55:
	mov	rax, QWORD PTR 0[rbp]
	mov	rcx, QWORD PTR 0[rbp+rdx*8]
	mov	QWORD PTR 0[rbp], rcx
	mov	QWORD PTR 0[rbp+rdx*8], rax
	mov	rax, QWORD PTR [rsi]
	mov	rcx, QWORD PTR [rsi+rdx*8]
	mov	QWORD PTR [rsi], rcx
	mov	QWORD PTR [rsi+rdx*8], rax
	cmp	rdx, 1
	jle	.L58
	mov	r8d, 1
	xor	eax, eax
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L102:
	add	rcx, rsi
	add	rax, rsi
	mov	QWORD PTR [r11], r9
	mov	QWORD PTR [r10], rdi
	mov	rdi, QWORD PTR [rax]
	mov	r9, QWORD PTR [rcx]
	mov	QWORD PTR [rax], r9
	mov	QWORD PTR [rcx], rdi
	lea	ecx, 1[r8+r8]
	movsx	rax, ecx
	cmp	rax, rdx
	jge	.L107
	movsx	rax, r8d
	mov	r8d, ecx
.L61:
	movsx	rcx, r8d
	lea	r11d, 2[rax+rax]
	sal	rcx, 3
	movsx	rdi, r11d
	lea	r10, 0[rbp+rcx]
	mov	r9, QWORD PTR [r10]
	cmp	rdi, rdx
	jge	.L59
	sal	rdi, 3
	lea	rbx, 0[rbp+rdi]
	mov	r12, QWORD PTR [rbx]
	cmp	r12, r9
	jbe	.L59
	mov	r9, r12
	mov	r10, rbx
	mov	rcx, rdi
	mov	r8d, r11d
.L59:
	sal	rax, 3
	lea	r11, 0[rbp+rax]
	mov	rdi, QWORD PTR [r11]
	cmp	rdi, r9
	jbe	.L102
.L107:
	sub	rdx, 1
	jmp	.L55
	.p2align 4,,10
	.p2align 3
.L58:
	sub	rdx, 1
	test	rdx, rdx
	jg	.L55
	add	rsp, 56
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.size	_Z7do_sortPmS_lll, .-_Z7do_sortPmS_lll
	.section	.text._Z9sort_loopPmPPcllll,"axG",@progbits,_Z9sort_loopPmPPcllll,comdat
	.p2align 4
	.weak	_Z9sort_loopPmPPcllll
	.type	_Z9sort_loopPmPPcllll, @function
_Z9sort_loopPmPPcllll:
	endbr64
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	mov	rbp, rdi
	push	rbx
	mov	rbx, r8
	sub	rsp, 88
	mov	QWORD PTR 16[rsp], rsi
	mov	QWORD PTR 24[rsp], rdx
	mov	QWORD PTR 32[rsp], rcx
	mov	QWORD PTR 48[rsp], r9
	cmp	r8, r9
	jge	.L118
	lea	rsi, 0[0+rdx*8]
	lea	r8, 1[rsi]
	lea	r9, 2[rsi]
	lea	r10, 3[rsi]
	lea	r11, 4[rsi]
	lea	r12, 5[rsi]
	lea	r13, 6[rsi]
	lea	r14, 7[rsi]
	cmp	QWORD PTR 32[rsp], rsi
	jle	.L117
	mov	rdi, QWORD PTR 16[rsp]
	lea	rax, 0[0+rbx*8]
	lea	rcx, [rdi+rax]
	mov	rdi, QWORD PTR 48[rsp]
	add	rax, rbp
	lea	r15, 0[rbp+rdi*8]
	.p2align 4,,10
	.p2align 3
.L119:
	mov	rdx, QWORD PTR [rcx]
	add	rax, 8
	add	rcx, 8
	movsx	rdi, BYTE PTR [rdx+rsi]
	mov	QWORD PTR 48[rax], rdi
	movsx	rdi, BYTE PTR [rdx+r8]
	mov	QWORD PTR 40[rax], rdi
	movsx	rdi, BYTE PTR [rdx+r9]
	mov	QWORD PTR 32[rax], rdi
	movsx	rdi, BYTE PTR [rdx+r10]
	mov	QWORD PTR 24[rax], rdi
	movsx	rdi, BYTE PTR [rdx+r11]
	mov	QWORD PTR 16[rax], rdi
	movsx	rdi, BYTE PTR [rdx+r12]
	mov	QWORD PTR 8[rax], rdi
	movsx	rdi, BYTE PTR [rdx+r13]
	mov	QWORD PTR [rax], rdi
	movsx	rdx, BYTE PTR [rdx+r14]
	mov	QWORD PTR -8[rax], rdx
	cmp	rax, r15
	jne	.L119
.L118:
	mov	rax, QWORD PTR 48[rsp]
	xor	r15d, r15d
	sub	rax, rbx
	cmp	rax, 1
	jle	.L115
	.p2align 4,,10
	.p2align 3
.L116:
	sar	rax
	add	r15, 1
	cmp	rax, 1
	jne	.L116
	add	r15, r15
.L115:
	mov	rax, QWORD PTR 48[rsp]
	mov	rsi, QWORD PTR 16[rsp]
	mov	r9, rbx
	lea	r12, -1[rax]
	mov	rdi, rsi
	lea	rax, 0[0+rbx*8]
	add	rdi, rax
	mov	QWORD PTR 72[rsp], rax
	lea	r13, 0[rbp+rax]
	mov	QWORD PTR 56[rsp], rdi
	mov	QWORD PTR 40[rsp], r13
	mov	r13, r12
	mov	QWORD PTR 64[rsp], r12
	mov	r12, r15
.L145:
	mov	rax, r13
	sub	rax, r9
	cmp	rax, 127
	jle	.L203
	test	r12, r12
	je	.L204
	sar	rax
	mov	rdi, QWORD PTR 40[rsp]
	lea	r14, 0[0+r13*8]
	sub	r12, 1
	add	rax, r9
	lea	rbx, 0[rbp+r14]
	add	r14, rsi
	sal	rax, 3
	mov	rdx, QWORD PTR [rdi]
	mov	rcx, QWORD PTR [rbx]
	lea	r8, 0[rbp+rax]
	mov	r11, QWORD PTR [r8]
	cmp	r11, rdx
	jbe	.L137
	cmp	rdx, rcx
	jb	.L138
	mov	rax, QWORD PTR 56[rsp]
	mov	r8, rdi
.L139:
	mov	QWORD PTR [r8], rcx
	mov	rdi, rbp
	mov	QWORD PTR [rbx], rdx
	mov	rdx, QWORD PTR [rax]
	mov	rcx, QWORD PTR [r14]
	mov	QWORD PTR 8[rsp], r9
	mov	QWORD PTR [rsp], rsi
	mov	QWORD PTR [rax], rcx
	lea	rcx, -1[r13]
	mov	QWORD PTR [r14], rdx
	mov	r8, QWORD PTR [rbx]
	mov	rdx, r9
	call	_ZL12do_partitionPmS_llm
	mov	rsi, QWORD PTR [rsp]
	mov	r8, QWORD PTR [rbx]
	mov	r15, rax
	lea	rax, 0[0+rax*8]
	mov	r9, QWORD PTR 8[rsp]
	lea	rdx, 0[rbp+rax]
	add	rax, rsi
	mov	rcx, QWORD PTR [rdx]
	mov	QWORD PTR [rdx], r8
	mov	QWORD PTR [rbx], rcx
	mov	rdx, QWORD PTR [rax]
	mov	rcx, QWORD PTR [r14]
	mov	QWORD PTR [rax], rcx
	mov	QWORD PTR [r14], rdx
	lea	rdx, 1[r15]
	cmp	r13, rdx
	jg	.L205
.L144:
	test	r15, r15
	je	.L199
	lea	r13, -1[r15]
	cmp	r9, r13
	jl	.L145
.L199:
	mov	r12, QWORD PTR 64[rsp]
	mov	rbx, r9
.L122:
	mov	r14, QWORD PTR 48[rsp]
	xor	r13d, r13d
	.p2align 4,,10
	.p2align 3
.L123:
	cmp	r12, rbx
	jle	.L164
	mov	rax, QWORD PTR 0[rbp+rbx*8]
	mov	rcx, r12
	jmp	.L148
	.p2align 4,,10
	.p2align 3
.L206:
	cmp	r12, rbx
	je	.L146
.L148:
	mov	rdx, rax
	mov	rax, QWORD PTR 8[rbp+rbx*8]
	mov	r8, rbx
	add	rbx, 1
	cmp	rdx, rax
	jne	.L206
	cmp	r12, r8
	jle	.L165
	mov	rax, r8
	.p2align 4,,10
	.p2align 3
.L149:
	mov	rbx, rax
	add	rax, 1
	cmp	rax, r12
	je	.L150
	mov	rsi, QWORD PTR 8[rbp+rax*8]
	cmp	QWORD PTR 0[rbp+rax*8], rsi
	je	.L149
.L150:
	add	rbx, 2
	cmp	r14, rbx
	mov	rax, rbx
	cmovle	rax, r14
	cmp	rax, r8
	jle	.L154
	mov	rcx, r8
	lea	rdx, 1[r8]
.L153:
	lea	r8, -1[rax]
	sub	r8, rcx
	cmp	rax, rcx
	cmovle	r8, r13
	add	r8, rdx
	cmp	r12, r8
	jle	.L167
.L154:
	mov	rax, rbx
	sub	rax, r8
	cmp	rax, 1
	jle	.L123
	mov	rax, QWORD PTR 24[rsp]
	mov	rcx, QWORD PTR 32[rsp]
	mov	r9, rbx
	mov	rdi, rbp
	mov	rsi, QWORD PTR 16[rsp]
	lea	rdx, 1[rax]
	call	_Z9sort_loopPmPPcllll
	test	al, al
	jne	.L123
.L117:
	add	rsp, 88
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L165:
	mov	rcx, r8
	.p2align 4,,10
	.p2align 3
.L146:
	lea	rdx, 1[rcx]
	mov	rax, r14
	cmp	rdx, r14
	mov	rbx, rdx
	cmovle	rax, rdx
	cmp	rcx, rax
	jl	.L153
.L167:
	add	rsp, 88
	mov	eax, 1
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.p2align 4,,10
	.p2align 3
.L137:
	jnb	.L155
	cmp	rdx, rcx
	ja	.L155
	mov	rax, QWORD PTR 56[rsp]
	mov	r8, rdi
	jmp	.L139
	.p2align 4,,10
	.p2align 3
.L205:
	mov	r8, r12
	mov	rcx, r13
	call	_Z7do_sortPmS_lll
	mov	r9, QWORD PTR 8[rsp]
	mov	rsi, QWORD PTR [rsp]
	jmp	.L144
	.p2align 4,,10
	.p2align 3
.L155:
	cmp	r11, rcx
	jnb	.L194
	cmp	r11, rdx
	je	.L207
	cmp	r11, rcx
	jnb	.L168
	cmp	rdx, rcx
	ja	.L163
.L168:
	cmp	rdx, rcx
	jnb	.L169
	cmp	r11, rcx
	ja	.L163
.L169:
	mov	rdx, QWORD PTR 0[rbp]
	mov	rax, rsi
	mov	r8, rbp
	jmp	.L139
.L163:
	mov	rax, r14
	mov	rdx, rcx
	mov	r8, rbx
	jmp	.L139
	.p2align 4,,10
	.p2align 3
.L138:
	cmp	r11, rcx
	ja	.L168
.L194:
	add	rax, rsi
	mov	rdx, r11
	jmp	.L139
.L164:
	mov	rcx, rbx
	jmp	.L146
.L203:
	mov	r13, QWORD PTR 40[rsp]
	add	rax, 1
	mov	rsi, QWORD PTR 72[rsp]
	mov	rbx, r9
	mov	rdx, rax
	add	rsi, QWORD PTR 16[rsp]
	mov	r12, QWORD PTR 64[rsp]
	mov	rdi, r13
	call	_Z12bitonic_sortPmS_l
	jmp	.L122
.L204:
	lea	r11, 1[rax]
	mov	QWORD PTR [rsp], rax
	mov	r13, QWORD PTR 40[rsp]
	mov	rbx, r9
	mov	rax, r11
	mov	QWORD PTR 8[rsp], rbp
	mov	r12, QWORD PTR 64[rsp]
	sar	rax
	mov	rsi, QWORD PTR 72[rsp]
	add	rsi, QWORD PTR 16[rsp]
	lea	r15, -1[rax]
	.p2align 4,,10
	.p2align 3
.L127:
	lea	edi, 1[r15+r15]
	movsx	rdx, edi
	cmp	r11, rdx
	jle	.L130
	movsx	rcx, r15d
	test	edi, edi
	jns	.L125
	jmp	.L130
	.p2align 4,,10
	.p2align 3
.L208:
	sal	rdx, 3
	lea	rbp, 0[r13+rdx]
	mov	r14, QWORD PTR 0[rbp]
	cmp	r14, r9
	jbe	.L158
	mov	r9, r14
	mov	r10, rbp
	mov	rax, rdx
.L129:
	sal	rcx, 3
	lea	rdi, 0[r13+rcx]
	mov	rdx, QWORD PTR [rdi]
	cmp	rdx, r9
	ja	.L130
	add	rax, rsi
	mov	QWORD PTR [rdi], r9
	add	rcx, rsi
	mov	QWORD PTR [r10], rdx
	mov	rdi, QWORD PTR [rax]
	mov	rdx, QWORD PTR [rcx]
	mov	QWORD PTR [rcx], rdi
	lea	edi, 1[r8+r8]
	mov	QWORD PTR [rax], rdx
	test	edi, edi
	js	.L130
	movsx	rdx, edi
	cmp	r11, rdx
	jle	.L130
	movsx	rcx, r8d
.L125:
	lea	rax, 0[0+rdx*8]
	lea	r8d, 2[rcx+rcx]
	lea	r10, 0[r13+rax]
	movsx	rdx, r8d
	mov	r9, QWORD PTR [r10]
	cmp	r11, rdx
	jg	.L208
.L158:
	mov	r8d, edi
	jmp	.L129
	.p2align 4,,10
	.p2align 3
.L130:
	sub	r15, 1
	cmp	r15, -1
	jne	.L127
	mov	rbp, QWORD PTR 8[rsp]
	mov	rdi, QWORD PTR [rsp]
	.p2align 4,,10
	.p2align 3
.L128:
	mov	rax, QWORD PTR 0[r13]
	mov	rdx, QWORD PTR 0[r13+rdi*8]
	mov	QWORD PTR 0[r13], rdx
	mov	QWORD PTR 0[r13+rdi*8], rax
	mov	rax, QWORD PTR [rsi]
	mov	rdx, QWORD PTR [rsi+rdi*8]
	mov	QWORD PTR [rsi], rdx
	mov	QWORD PTR [rsi+rdi*8], rax
	cmp	rdi, 1
	jle	.L131
	mov	r11d, 1
	xor	eax, eax
	mov	edx, 1
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L209:
	sal	r8, 3
	lea	r14, 0[r13+r8]
	mov	r15, QWORD PTR [r14]
	cmp	r15, r9
	jbe	.L160
	mov	r9, r15
	mov	r10, r14
	mov	rdx, r8
.L132:
	sal	rax, 3
	lea	r11, 0[r13+rax]
	mov	r8, QWORD PTR [r11]
	cmp	r8, r9
	ja	.L202
	add	rdx, rsi
	add	rax, rsi
	mov	QWORD PTR [r11], r9
	lea	r11d, 1[rcx+rcx]
	mov	QWORD PTR [r10], r8
	mov	r9, QWORD PTR [rdx]
	mov	r8, QWORD PTR [rax]
	mov	QWORD PTR [rax], r9
	mov	QWORD PTR [rdx], r8
	movsx	rdx, r11d
	cmp	rdi, rdx
	jle	.L202
	movsx	rax, ecx
.L134:
	lea	ecx, 2[rax+rax]
	sal	rdx, 3
	lea	r10, 0[r13+rdx]
	movsx	r8, ecx
	mov	r9, QWORD PTR [r10]
	cmp	rdi, r8
	jg	.L209
.L160:
	mov	ecx, r11d
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L202:
	sub	rdi, 1
	jmp	.L128
.L131:
	sub	rdi, 1
	test	rdi, rdi
	jg	.L128
	jmp	.L122
.L207:
	add	rax, rsi
	jmp	.L139
	.size	_Z9sort_loopPmPPcllll, .-_Z9sort_loopPmPPcllll
	.text
	.p2align 4
	.globl	_Z11_AVX512SortPmPPcllPb
	.type	_Z11_AVX512SortPmPPcllPb, @function
_Z11_AVX512SortPmPPcllPb:
	endbr64
	push	rbx
	mov	rbx, r8
	test	rdi, rdi
	je	.L211
	test	rsi, rsi
	je	.L211
	test	dl, 7
	je	.L217
.L211:
	mov	BYTE PTR [rbx], 0
	pop	rbx
	ret
	.p2align 4,,10
	.p2align 3
.L217:
	test	rdx, rdx
	jle	.L211
	test	rcx, rcx
	jle	.L211
	mov	r9, rcx
	xor	r8d, r8d
	mov	rcx, rdx
	xor	edx, edx
	call	_Z9sort_loopPmPPcllll
	mov	BYTE PTR [rbx], al
	pop	rbx
	ret
	.size	_Z11_AVX512SortPmPPcllPb, .-_Z11_AVX512SortPmPPcllPb
	.section	.rodata
	.align 64
.LC0:
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	0
	.quad	1
	.quad	2
	.quad	3
	.align 64
.LC1:
	.quad	2
	.quad	3
	.quad	0
	.quad	1
	.quad	6
	.quad	7
	.quad	4
	.quad	5
	.align 64
.LC2:
	.quad	1
	.quad	0
	.quad	3
	.quad	2
	.quad	5
	.quad	4
	.quad	7
	.quad	6
	.align 64
.LC3:
	.quad	7
	.quad	6
	.quad	5
	.quad	4
	.quad	3
	.quad	2
	.quad	1
	.quad	0
	.section	.rodata.cst1,"aM",@progbits,1
.LC4:
	.byte	-16
.LC5:
	.byte	-52
.LC6:
	.byte	-86
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
