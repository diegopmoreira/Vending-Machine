#	Trabalho Pratico Final
#	Sale Automatic Machine
# Diego Moreira e Gabriel Soares

.data
	
	# Mensagens de menu
	
	msg_menu: .asciiz "\n Entre com a opcao que deseja: \n 1- Inserir Credito:\n 2- Saldo de Creditos\n 3- Selecionar Produto:\n 4- Retirar Vale Credito:\n 5- Entrar Como Admnistrador:\n 6- Sair:\n"
	msg_menuCred: .asciiz "\n Indique o valor total que esta sendo inserido. \n "
	msg_saldo: .asciiz "\n O seu saldo de credito atual e: "
	msg_menuProduto: .asciiz "\n Entre com a opcao que deseja: \n 1- Chocolate \n 2- Salgadinhos \n 3- Bolachas \n 4- Bebidas \n  "
	msg_retiraCred: .asciiz "\n Vale-credito emitido com sucesso.\n"
	msg_menuAdm: .asciiz "\n Ola, Administrador! \n Entre com a opcao que deseja: \n 1- Alterar Estoque \n 2- Visualizar Estoque \n 3- Alterar valor de produto \n 4- Voltar ao Menu Principal \n"
	msg_autenticaAdm: .asciiz "\n Entre com sua senha: "
	msg_senhaErro: .asciiz "\n Senha incorreta. \n"
	msg_admIns: .asciiz "\n Informe a quantidade que deseja inserir ou retirar (para retirar basta inserir o numero negativo): \n"
	msg_admVis: .asciiz "\n Quantidade do produto selecionado em estoque: \n"
	msg_selecChoco: .asciiz "\n Entre com a opcao que deseja: \n 1- Diamante Negro \n 2- Suflair \n 3- Bis \n 4- Chokito \n 5- Laka \n "
	msg_selecSalg: .asciiz "\n Entre com a opcao que deseja: \n 1- Cheetos \n 2- Pingo d'ouro Churrasco \n 3- Pingo d'ouro Bacon \n 4- Fandangos Queijo \n 5- Fandangos Presunto \n "
	msg_selecBol: .asciiz "\n Entre com a opcao que deseja: \n 1-Traquinas Morango \n 2-Traquinas Chocolate \n 3-Bono \n 4-Negresco Eclipse \n 5-Negresco Tradicional \n "
	msg_selecBeb: .asciiz "\n Entre com a opcao que deseja: \n 1-Coca-cola \n 2-Pepsi \n 3-Sprite \n 4-Fanta \n 5-Agua \n  "
	msg_semEst: .asciiz "\n Não há mais deste produto em estoque. Selecione outro produto por favor ou informe o Administrador. \n"
	msg_credIns: .asciiz "\n Credito insuficiente. Selecione outro produto ou insira mais creditos. \n"
	msg_valor: .asciiz "\n Informe o novo valor do produto:\n"
	msg_preco: .asciiz "\n Seu gasto foi de :\n"
	
	# Senha administrador para autenticacao
	val_senha: .word 123
	
	# Saldo de creditos
	val_saldo: .word 0
	
	# Estoque inicial
		
		# Chocolates
	
	p_diam: .word 5
	p_sufl: .word 5
	p_bis: .word 5
	p_chok: .word 5
	p_laka: .word 5
	
		# Salgados
	
	p_chee: .word 5
	p_pchu: .word 5
	p_pbac: .word 5
	p_fque: .word 5
	p_fpre: .word 5
		
		# Bolachas
		
	p_tmor: .word 5
	p_tcho: .word 5
	p_bono: .word 5
	p_necl: .word 5
	p_ntra: .word 5
	
		# Bebidas
	
	p_coca: .word 5
	p_peps: .word 5
	p_spri: .word 5
	p_fant: .word 5
	p_agua: .word 5
	
	
	# Valores dos produtos
	
	
		# Chocolates
	
	val_diam: .word 1
	val_sufl: .word 1
	val_bis: .word 1
	val_chok: .word 1
	val_laka: .word 1
	
		# Salgados
	
	val_chee: .word 1
	val_pchu: .word 1
	val_pbac: .word 1
	val_fque: .word 1
	val_fpre: .word 1
		
		# Bolachas
		
	val_tmor: .word 1
	val_tcho: .word 1
	val_bono: .word 1
	val_necl: .word 1
	val_ntra: .word 1
	
		# Bebidas
	
	val_coca: .word 1
	val_peps: .word 1
	val_spri: .word 1
	val_fant: .word 1
	val_agua: .word 1
	
.text



# Menu inicial dispoe das opcoes para o usuario



menu:
	la $a0, msg_menu
	li $v0, 51
	syscall
	beq $a0, 1, jal_menuCred
	nop
	beq $a0, 2, jal_saldo
	nop
	beq $a0, 3, jal_menuProduto
	nop
	beq $a0, 4, jal_retiraCred
	nop
	beq $a0, 5, jal_menuAdm
	nop
	beq $a0, 6, sair
	nop
	j menu
	nop



# Chamadas jal

jal_menuCred:
	jal menuCred
	nop
	j menu
	nop

jal_saldo:
	jal saldo
	nop
	j menu
	nop

jal_menuProduto:
	jal menuProduto
	nop
	j menu
	nop

jal_retiraCred:
	jal retiraCred
	nop
	j menu
	nop

jal_menuAdm:
	jal autentica
	nop
	j menu
	nop


	
# informa na tela para indicar o valor que esta sendo inserido

menuCred:
	la $a0, msg_menuCred
	li $v0, 51
	syscall
	lw $t1, val_saldo
	add $t1, $t1, $a0
	sw $t1, val_saldo
	jr $ra
	nop

# apenas mostra na tela o total de credito
	
saldo:
	la $a0, msg_saldo
	lw $a1, val_saldo
	li $v0, 56
	syscall
	jr $ra
	nop
	

# apenas zera o saldo supondo que esta devolvendo em vale credito a sobra	

retiraCred:
	sw $zero, val_saldo
	jr $ra
	nop

# funcao que pega o valor do estoque do produto armazena em t1 e seu endereco para gravar em t2

menuProduto:
	la $a0, msg_menuProduto
	li $v0, 51
	syscall
	beq $a0, 1, selecChoco
	nop
	beq $a0, 2, selecSalg
	nop
	beq $a0, 3, selecBol
	nop
	beq $a0, 4, selecBeb
	nop
	
selecChoco: 
	la $a0, msg_selecChoco
	li $v0, 51
	syscall
	beq $a0, 1, diam_t1
	nop
	beq $a0, 2, sufl_t1
	nop
	beq $a0, 3, bis_t1
	nop
	beq $a0, 4, laka_t1
	nop
	beq $a0, 5, chok_t1
	nop

diam_t1:
	lw $t1, p_diam
	la $t2, p_diam

	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_diam
	
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	beqz $t1, sem_est
	nop
	
	lw $t3, val_diam
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_diam
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_diam
		li $v0, 56
		syscall
		
		jr $ra
		nop

sufl_t1:
	lw $t1, p_sufl
	la $t2, p_sufl
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_sufl
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_sufl
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_sufl
		
		la $a0, msg_preco
		lw $a1, val_sufl
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

bis_t1:
	lw $t1, p_bis
	la $t2, p_bis
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_bis
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_bis
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_bis
		
		la $a0, msg_preco
		lw $a1, val_bis
		li $v0, 56
		syscall
		
		jr $ra
		nop
	
	jr $ra
	nop

laka_t1:
	lw $t1, p_laka
	la $t2, p_laka
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_laka
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_laka
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_laka
		
		la $a0, msg_preco
		lw $a1, val_laka
		li $v0, 56
		syscall
		
		jr $ra
		nop
	
	jr $ra
	nop

chok_t1:
	lw $t1, p_chok
	la $t2, p_chok
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_chok
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_chok
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_chok
		
		la $a0, msg_preco
		lw $a1, val_chok
		li $v0, 56
		syscall
		jr $ra
		nop

	jr $ra
	nop

selecSalg:
	la $a0, msg_selecSalg
	li $v0, 51
	syscall
	beq $a0, 1, chee_t1
	nop
	beq $a0, 2, pchu_t1
	nop
	beq $a0, 3, pbac_t1
	nop
	beq $a0, 4, fque_t1
	nop
	beq $a0, 5, fpre_t1
	nop

chee_t1:
	lw $t1, p_chee
	la $t2, p_chee
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_chee
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_chee
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_chee
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_chee
		li $v0, 56
		syscall
		
		jr $ra
		nop
	
	jr $ra
	nop

pchu_t1:
	lw $t1, p_pchu
	la $t2, p_pchu
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_pchu
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_pchu
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_pchu
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_pchu
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

pbac_t1:
	lw $t1, p_pbac
	la $t2, p_pbac
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_pbac
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_pbac
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_pbac
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_pbac
		li $v0, 56
		syscall
		
		jr $ra
		nop
	
	jr $ra
	nop

fque_t1:
	lw $t1, p_fque
	la $t2, p_fque
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_fque
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_fque
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_fque
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_fque
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

fpre_t1:
	lw $t1, p_fpre
	la $t2, p_fpre
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_fpre
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_fpre
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_fpre
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_fpre
		li $v0, 56
		syscall
		
		jr $ra
		nop
	
	jr $ra
	nop

selecBol:
	la $a0, msg_selecBol
	li $v0, 51
	syscall
	beq $a0, 1, tmor_t1
	nop
	beq $a0, 2, tcho_t1
	nop
	beq $a0, 3, bono_t1
	nop
	beq $a0, 4, necl_t1
	nop
	beq $a0, 5, ntra_t1
	nop

tmor_t1:
	lw $t1, p_tmor
	la $t2, p_tmor
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_tmor
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_tmor
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_tmor
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_tmor
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

tcho_t1:
	lw $t1, p_tcho
	la $t2, p_tcho
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_tcho
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_tcho
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_tcho
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_tcho
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

bono_t1:
	lw $t1, p_bono
	la $t2, p_bono
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_bono
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_bono
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_bono
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_bono
		li $v0, 56
		syscall
		
		jr $ra
		nop
	
	jr $ra
	nop

necl_t1:
	lw $t1, p_necl
	la $t2, p_necl
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_necl
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_necl
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_necl
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_necl
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

ntra_t1:
	lw $t1, p_ntra
	la $t2, p_ntra
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_ntra
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_ntra
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_ntra
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_ntra
		li $v0, 56
		syscall
		
		jr $ra
		nop
	
	jr $ra
	nop

selecBeb:
	la $a0, msg_selecBeb
	li $v0, 51
	syscall
	beq $a0, 1, coca_t1
	nop
	beq $a0, 2, peps_t1
	nop
	beq $a0, 3, spri_t1
	nop
	beq $a0, 4, fant_t1
	nop
	beq $a0, 5, agua_t1
	nop

coca_t1:
	lw $t1, p_coca
	la $t2, p_coca
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_coca
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_coca
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_coca
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_coca
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

peps_t1:
	lw $t1, p_peps
	la $t2, p_peps
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_peps
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_peps
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_peps
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_peps
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

spri_t1:
	lw $t1, p_spri
	la $t2, p_spri
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_spri
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_spri
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_spri
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_spri
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

fant_t1:
	lw $t1, p_fant
	la $t2, p_fant
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_fant
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_fant
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_fant
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_fant
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

agua_t1:
	lw $t1, p_agua
	la $t2, p_agua
	
	bnez $s5, saida_adm #Verifica se a chamada foi feito por algum comando do adm, se for n�o entra na proxima parte
	nop
	
	la $t7, val_agua
	bnez $s6, saida_mud #Verifica se a chamada foi para mudan�a de estoque
	nop
	
	lw $t3, val_agua
	lw $t4, val_saldo
	slt $t5, $t4, $t3
	bnez $t5, sem_saldo
	nop
		sub $t4, $t4, $t3
		sw $t4, val_saldo
		addi $t1, $t1, -1
		sw $t1, p_agua
		
		la $a0, msg_preco #Imprime o Custo da compra
		lw $a1, val_agua
		li $v0, 56
		syscall
		
		jr $ra
		nop

	jr $ra
	nop

sem_saldo:
	la $a0, msg_credIns
	li $v0, 56
	syscall	
	
	jr $ra
	nop
	
sem_est:
	la $a0, msg_semEst
	li $v0, 56
	syscall
	
	jr $ra
	nop

saida_adm:
	addi $s5, $zero, 0
	
	jr $ra
	nop
	
saida_mud:
	addi $s6, $zero, 0
	
	jr $ra
	nop
	



# modo administrador testa senha caso errada retorna para o menu principal
# INICIO DO MODO ADMINISTRADOR A PARTIR DAQUI O $RA SEMPRE LEVA DE VOLTA PARA O MENU PRINCIPAL

autentica:
	la $a0, msg_autenticaAdm
	li $v0, 51
	syscall
	lw $t1, val_senha
	beq $t1, $a0, menuAdm
	nop
	la $a0, msg_senhaErro
	li $v0, 56
	syscall
	jr $ra
	nop

# verifica opcao que o adm ira tomar

menuAdm:
	la $a0, msg_menuAdm
	li $v0, 51
	syscall
	beq $a0, 1, alteraEst
	nop
	beq $a0, 2, visuEst
	nop
	beq $a0, 3, alteraPre
	nop
	jr $ra
	nop
 # chama a funcao menuproduto e altera o produto selecionado

 alteraEst:
	move $t3, $ra
	addi $s5, $zero, 1
	jal menuProduto
	nop
	move $ra, $t3
	la $a0, msg_admIns
	li $v0, 51
	syscall
	add $t1, $t1, $a0
	sw $t1, 0($t2)
	jr $ra
	nop

visuEst:
	move $t3, $ra
	addi $s5, $zero, 1
	jal menuProduto
	nop
	move $ra, $t3
	la $a0, msg_admVis
	move $a1, $t1
	li $v0, 56
	syscall
	jr $ra


alteraPre:

	move $t3, $ra
	addi $s6, $zero, 1
	jal menuProduto
	nop
	
	move $ra, $t3
	la $a0, msg_valor
	li $v0, 51
	syscall
	sw $a0, 0($t7)
	jr $ra
	nop




sair:
	nop
	
