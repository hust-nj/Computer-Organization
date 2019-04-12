#############################################################
#中断演示程序，简单走马灯测试，按下1号键用数字1循环移位测试
#中断演示程序，简单走马灯测试，按下2号键用数字2循环移位测试
#最右侧显示数据是循环计数
#这只是中断服务程序演示程序，方便大家检查中断嵌套，
#设计时需要考虑开中断，关中断，设置中断屏蔽字如何用软件指令实现，如何保护现场，中断隐指令需要多少周期
#############################################################
.text
# 开中断
	mfc0 $t1, $0
	addi $t1, $zero, 1
	mtc0 $t1, $0

	addi $sp, $zero 512

# 设置中断屏蔽字	
	addi $t1, $zero, 0
	mtc0 $t1, $2

start:
	addi $s0,$zero,1 
	addi $s3,$zero,0

	addi $t0,$0,8    
	addi $t1,$0,1
	left:
	sll $s3, $s3, 4
	or $s3, $s3, $s0

	add    $a0,$0,$s3       # display $s3
	addi   $v0,$0,34         # system call for LED display 
	syscall                 # display 
	sub $t0,$t0,$t1
	bne $t0,$0, left
	j start


interrupt1_func:

nop
# 保护现场
addi $sp, $sp, -4
sw 	 $sp, 0($sp)

# 保护EPC
mfc0 $ra, $1
addi $sp, $sp, -4
sw	 $ra, 0($sp)

# 开中断
mfc0 $t1, $0
addi $t1, $zero, 1
mtc0 $t1, $0

addi $s6,$zero,1       #中断号1,2,3   不同中断号显示值不一样

addi $s4,$zero,6      #循环次数初始值  
addi $s5,$zero,1       #计数器累加值

Int1_Loop:
add $s0,$zero,$s6

Int1_LeftShift:       

sll $s0, $s0, 4  
or $s3,$s0,$s4
add    $a0,$0,$s3       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   

bne $s0, $zero, Int1_LeftShift
sub $s4,$s4,$s5      #循环次数递减
bne $s4, $zero, Int1_Loop

# 关中断
mfc0 $t1, $0
addi $t1, $zero, 0
mtc0 $t1, $0

# 恢复EPC
lw 	 $ra, 0($sp)
addiu $sp, $sp, 4
mtc0  $ra, $1

lw   $sp, 0($sp)
addiu $sp, $sp, 4

eret
#----------------------------------------------------
interrupt2_func:

nop
# 保护现场
addi $sp, $sp, -4
sw 	 $sp, 0($sp)

# 保护EPC
mfc0 $ra, $1
addi $sp, $sp, -4
sw	 $ra, 0($sp)

# 开中断
mfc0 $t1, $0
addi $t1, $zero, 1
mtc0 $t1, $0

addi $s6,$zero,2       #中断号1,2,3   不同中断号显示值不一样

addi $s4,$zero,6      #循环次数初始值  
addi $s5,$zero,1       #计数器累加值

Int2_Loop:
add $s0,$zero,$s6

Int2_LeftShift:       

sll $s0, $s0, 4  
or $s3,$s0,$s4
add    $a0,$0,$s3       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   

bne $s0, $zero, Int2_LeftShift
sub $s4,$s4,$s5      #循环次数递减
bne $s4, $zero, Int2_Loop

# 关中断
mfc0 $t1, $0
addi $t1, $zero, 0
mtc0 $t1, $0

# 恢复EPC
lw 	 $ra, 0($sp)
addiu $sp, $sp, 4
mtc0  $ra, $1

lw   $sp, 0($sp)
addiu $sp, $sp, 4

eret
#--------------------------------------------------------------
interrupt3_func:

nop
# 保护现场
addi $sp, $sp, -4
sw 	 $sp, 0($sp)

# 保护EPC
mfc0 $ra, $1
addi $sp, $sp, -4
sw	 $ra, 0($sp)

# 开中断
mfc0 $t1, $0
addi $t1, $zero, 1
mtc0 $t1, $0

addi $s6,$zero,3       #中断号1,2,3   不同中断号显示值不一样

addi $s4,$zero,6      #循环次数初始值  
addi $s5,$zero,1       #计数器累加值

Int3_Loop:
add $s0,$zero,$s6

Int3_LeftShift:       

sll $s0, $s0, 4  
or $s3,$s0,$s4
add    $a0,$0,$s3       #display $s0
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.   

bne $s0, $zero, Int3_LeftShift
sub $s4,$s4,$s5      #循环次数递减
bne $s4, $zero, Int3_Loop

# 关中断
mfc0 $t1, $0
addi $t1, $zero, 0
mtc0 $t1, $0

# 恢复EPC
lw 	 $ra, 0($sp)
addiu $sp, $sp, 4
mtc0  $ra, $1

lw   $sp, 0($sp)
addiu $sp, $sp, 4

eret