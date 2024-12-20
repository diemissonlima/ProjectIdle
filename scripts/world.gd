extends Control

@export_category("Objetos")
@export var background: TextureRect
@export var timer_contador: Timer
@export var timer_player_attack: Timer
@export var spawn_position: Marker2D

@export_category("Labels")
@export var label_stage: Label
@export var label_contador: Label
@export var label_gold: Label
@export var label_avg_stage: Label
@export var label_player_atk: Label
@export var label_upgrade_ataque_cost: Label
@export var label_upgrade_time_cost: Label

@export_category("Buttons")
@export var increase_attack: Button

@export_category("Variaveis")
@export var enemy_list: Array[PackedScene]

var contador: int
var estagio: int = 1
var upgrade_ataque_cost: int = 250
var upgrade_time_cost: int = 250
var x_upgrade_ataque: int = 1
var x_upgrade_time: int = 1

var enemy


func _ready() -> void:
	load_background() # carrega o background do estagio
	spawn_enemy() # spawna o inimigo
	start_timer() # inicia os contadores de estagio e ataque do player


func _process(_delta: float) -> void:
	set_stage_label() # atualiza constantemente o label de vida do inimigo


func spawn_enemy() -> void: # função que realiza o spawn do inimigo
	enemy = enemy_list.pick_random().instantiate() # seleciona um inimigo aleatorio da lista
	enemy.global_position = spawn_position.global_position # seta a posicao do inimigo na tela
	get_tree().root.call_deferred("add_child", enemy) # adiciona o inimigo à cena


func set_stage_label() -> void:
	label_stage.text = "Stage: " + str(World.estagio) # label que exibe o estagio atual
	label_gold.text = "Gold: " + str(Player.gold)
	label_avg_stage.text = "Maior Estagio: " + str(World.avg_estagio)
	label_player_atk.text = "Ataque: " + str(Player.damage)
	label_upgrade_ataque_cost.text = "Ataque: " + str(upgrade_ataque_cost) + " Gold"
	label_upgrade_time_cost.text = "Tempo: " + str(upgrade_time_cost) + " Gold"
	
	if World.contador > 9:
		label_contador.text = "00:" + str(World.contador) # label do timer do estagio
	else:
		label_contador.text = "00:0" + str(World.contador) # label do timer do estagio


func killer_enemy() -> void:
	enemy.queue_free() # deleta o inimigo da cena
	
	var drop_gold = randi_range(100, 100) * World.estagio
	Player.gold += drop_gold
	
	World.contador = 5 # reseta o contador para o timer padrao
	World.estagio += 1 # incrementa o estagio em + 1
	
	if World.estagio > World.avg_estagio:
		World.avg_estagio = World.estagio
	
	spawn_enemy() # spawna o inimigo
	load_background() # carrega um novo background
	
	
	timer_contador.start() # reinicia o contador do estagio


func start_timer() -> void: # inicia os contadores
	timer_contador.start() # inicia o contador do estagio
	World.contador = 5
	
	timer_player_attack.start() # inicia o timer de ataque do player, padrao 1s


func take_enemy_damage(_damage: int) -> void: # causa dano ao inimigo
	enemy.health -= _damage # diminui a vida em funcao do dano do player
	
	if enemy.health <= 0: # se a vida chegar a zero, chama a função de matar o inimigo
		killer_enemy()


func load_background() -> void: # carrega o background do estagio
	background.texture = load("res://assets/backgrounds/Horizontal/" + str(randi_range(1, 32)) + ".png")


func reload_battle() -> void: # função que recarrega a batalha
	World.estagio -= 1 # volta ao estagio em que o player consegue derrotar o inimigo
	
	spawn_enemy() # spawna o inimigo
	start_timer() # starta os contadores de estagio e ataque do player


func _on_timer_player_attack_timeout() -> void: # sinal que é chamado quando o timer de ataque zera
	Player.alter_attack() # modifica os valores de ataque
	
	if Player.critical_attack: # verifica se o ataque é crítico
		take_enemy_damage(Player.damage * 2) # dobra o dano causado
		Player.critical_attack = false # muda a flag para nao causa sempre dano critico
		
	else:
		take_enemy_damage(Player.damage) # causa dano ao inimigo


func _on_timer_timeout() -> void: # sinal que é chamado quando o timer do estagio zera
	World.contador -= 1 # diminui o contador do estagio em - 1
	
	# condição atendida caso o player nao derrote o inimigo dentro do tempo limite
	if World.contador == 0 and enemy.health > 0:
		timer_contador.stop() # para o contador do estagio
		timer_player_attack.stop() # para o contador de ataque do player
		enemy.queue_free() # deleta o inimigo atual
		
		reload_battle() # chama a função de recarregar a batalha
		return
	
	timer_contador.start() # e reinicia, criando um loop até chegar a 0


func _on_increase_ataque_pressed() -> void:
	if upgrade_ataque_cost > Player.gold:
		return
	
	x_upgrade_ataque += 1
	
	Player.gold -= upgrade_ataque_cost
	Player.damage += 1
	
	upgrade_ataque_cost = x_upgrade_ataque * 250


func _on_increase_time_pressed() -> void:
	if upgrade_time_cost > Player.gold:
		return
	
	x_upgrade_time += 1
	
	Player.gold -= upgrade_time_cost
	World.contador += 1
	
	upgrade_time_cost = x_upgrade_time * 250
