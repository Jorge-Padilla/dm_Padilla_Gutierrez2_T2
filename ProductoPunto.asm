###################################################
##        Jorge Alberto Padilla Gutierrez        ##
##               ProductoPunto.asm               ##
###################################################
.data
	Vector_1:	.word 1 2 3 4 5 6 7 8 9
	Vector_2:	.word -1 2 -3 4 -5 6 -7 8 -9

.text
# int Vector_1[9] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
auipc	s0, 0xfc10
addi	s0, s0, 0x00
# int Vector_2[9] = { -1,2,-3,4,-5,6,-7,8,-9 };
auipc	s1, 0xfc10
addi	s1, s1, 0x1C
# int i = 0;
addi	s2, zero, 0
# int resultado = 0;
addi	s3, zero, 0

jal	ra, __main
jal	zero, __end

# int main(void) {
__main:
	# for (i = 0; i < 9; i++) {
	addi	s2, zero, 0
	__for:
	slti	t0, s2, 9
	beq	t0, zero, __out
	__loop:
		# result = result + ProductFunction(Vector_1[i], Vector_2[i]);
		slli	t1, s2, 2
		add	t2, t1, s0
		add	t3, t1, s1
		addi	sp, sp, -4
		sw	ra, 0(sp)
		lw	a2, 0(t2)
		lw	a3, 0(t3)
		jal	ra, __ProductFunction
		lw	ra, 0(sp)
		addi	sp, sp, 4
		add	s3, s3, a0
	# }
	addi	s2, s2, 1
	jal	zero, __for
	# return 0;
	__out:
	addi	a0, zero, 0
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