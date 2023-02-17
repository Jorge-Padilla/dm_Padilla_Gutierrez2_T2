###################################################
##        Jorge Alberto Padilla Gutierrez        ##
##              matriz_x_vector.asm              ##
###################################################
.data
	vector:	.word 1 2 3 4
	row_0:	.word 1 2 3 4
	row_1:	.word 5 6 7 8
	row_2:	.word 9 10 11 12
	row_3:	.word 13 14 15 16
	result:	.word 0 0 0 0

.text
# int vector[4] = { 1, 2, 3, 4 };
auipc	s0, 0xfc10
addi	s0, s0, 0x00
# int row[4][4]
# int row[0][4] = { 1, 2, 3, 4 };
auipc	s1, 0xfc10
addi	s1, s1, 0x08
# int row[1][4] = { 5, 6, 7, 8 };
auipc	s2, 0xfc10
addi	s2, s2, 0x10
# int row[2][4] = { 9, 10, 11, 12 };
auipc	s3, 0xfc10
addi	s3, s3, 0x18
# int row[3][4] = { 13, 14, 15, 16 };
auipc	s4, 0xfc10
addi	s4, s4, 0x20
# int result[4] = { 0, 0, 0, 0 };
auipc	s5, 0xfc10
addi	s5, s5, 0x28
# int rows = 4
addi	s6, zero, 4
# int colums = 4
addi	s7, zero, 4

jal	ra, __main
jal	zero, __end

# int main(void) {
__main:
	# for (i = 0; i < rows; i++) {
	addi	s8, zero, 0
	__for1:
	slt	t0, s8, s6
	beq	t0, zero, __out1
	__loop1:
		# result[i] = DotProduct(vector, row[i]);
		slli	t1, s8, 2
		slli	t2, s8, 4
		add	s9, t1, s5
		add	t3, t2, s1
		addi	sp, sp, -4
		sw	ra, 0(sp)
		addi	a2, s0, 0
		addi	a3, t3, 0
		jal	ra, __DotProduct
		lw	ra, 0(sp)
		addi	sp, sp, 4
		sw	a0, 0(s9)
	# }
	addi	s8, s8, 1
	jal	zero, __for1
	# return 0;
	__out1:
	addi	a0, zero, 0
	jalr	zero, ra, 0
# }

# int DotProduct(int[] a, int[] b) [
__DotProduct:
	# int dot = 0
	addi	s10, zero, 0
	# for (i = 0; i < colums; i++) {
	addi	s11, zero, 0
	__for2:
	slt	t0, s11, s7
	beq	t0, zero, __out2
	__loop2:
		# dot = dot + ProductFunction(a[i], b[i]);
		slli	t1, s11, 2
		add	t2, t1, a2
		add	t3, t1, a3
		addi	sp, sp, -12
		sw	ra, 8(sp)
		sw	a2, 4(sp)
		sw	a3, 0(sp)
		lw	a2, 0(t2)
		lw	a3, 0(t3)
		jal	ra, __ProductFunction
		lw	a3, 0(sp)
		lw	a2, 4(sp)
		lw	ra, 8(sp)
		addi	sp, sp, 12
		add	s10, s10, a0
	# }
	addi	s11, s11, 1
	jal	zero, __for2
	# return dot;
	__out2:
	addi	a0, s10, 0
	jalr	zero, ra, 0
# }

# int ProductFunction(int a, int b) {
__ProductFunction:
	# return(a*b);
	mul	a0, a2, a3
	jalr	zero, ra, 0
# }

# nop
__end:
addi	zero, zero, 0x0