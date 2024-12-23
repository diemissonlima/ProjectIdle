extends Control

@export_category("Objetos")
@export var background: TextureRect
@export var timer_batalha: Timer
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
@export var increase_battle_time: Button

@export_category("Variaveis")
@export var enemy_list: Array[PackedScene]

var enemy


func _ready() -> void:
	load_background() # carrega o background do estagio
	set_label_upgrade() # seta as labels que informa o custo do upgrade
	spawn_enemy() # spawna o inimigo
	start_timer() # inicia os contadores de estagio e ataque do player


func _process(delta: float) -> void:
	World.gameplay_time += delta
	set_stage_label() # atualiza constantemente o label de vida do inimigo


func format_gameplay_time() -> String:
	var hours = int(World.gameplay_time) / 3600
	var minutes = (int(World.gameplay_time) % 3600) / 60
	var seconds = int(World.gameplay_time) % 60
	
	return "%02d:%02d:%02d" % [hours, minutes, seconds]


func start_timer() -> void: # inicia os contadores
	timer_batalha.start(World.battle_time) # inicia o contador do estagio
	timer_player_attack.start() # inicia o timer de ataque do player, padrao 1s


func spawn_enemy() -> void: # função que realiza o spawn do inimigo
	enemy = enemy_list.pick_random().instantiate() # seleciona um inimigo aleatorio da lista
	enemy.global_position = spawn_position.global_position # seta a posicao do inimigo na tela
	get_tree().root.call_deferred("add_child", enemy) # adiciona o inimigo à cena


func set_stage_label() -> void:
	label_stage.text = "Stage: " + str(World.estagio) # exibe o estagio atual
	label_gold.text = "Gold: " + str(Player.gold) # exibe o gold 
	label_avg_stage.text = "Maior Estagio: " + str(World.avg_estagio) # maior estagio alcancado
	label_player_atk.text = "Ataque: " + "%0.f" % Player.damage # exibe ataque do player
	$Labels/LabelGameTime.text = "Tempo de Jogo: \n" + format_gameplay_time()
	
	update_timer_display() # chama função pra atualizar a label de tempo de batalha


func set_label_upgrade() -> void:
	label_upgrade_ataque_cost.text = "Ataque: " + str(Player.x_upgrade_ataque * 250) + " Gold" # Exibe custo upgrade ataque
	label_upgrade_time_cost.text = "Tempo: " + str(Player.x_upgrade_time * 250) + " Gold" # exibe custo upgrade tempo de batalha


func update_timer_display() ->  void: # função pra atualizar label de batalha
	var minutes = int(timer_batalha.time_left) / 60 # converte o time_left do timer pra minutos
	var seconds = int(timer_batalha.time_left) % 60 # converte o time_left do timer pra segundos

	label_contador.text = String("%02d:%02d" % [int(minutes), int(seconds)]) # formata a string


func killer_enemy() -> void:
	enemy.queue_free() # deleta o inimigo da cena
	
	drop() # chama a função de drop
	
	# World.contador = 5 # reseta o contador para o timer padrao
	World.estagio += 1 # incrementa o estagio em + 1
	
	if World.estagio > World.avg_estagio:
		World.avg_estagio = World.estagio
	
	spawn_enemy() # spawna o inimigo
	load_background() # carrega um novo background
	
	timer_batalha.start(World.battle_time) # reinicia o contador do estagio
	
	save_data()


func drop() -> void: # função de drop de recursos
	var drop_gold = randi_range(1, 15) * World.estagio
	Player.gold += drop_gold
	
	save_data()


func take_enemy_damage(_damage: float) -> void: # causa dano ao inimigo
	enemy.health -= _damage # diminui a vida em funcao do dano do player
	
	if enemy.health <= 0: # se a vida chegar a zero, chama a função de matar o inimigo
		killer_enemy()


func load_background() -> void: # carrega o background do estagio
	background.texture = load("res://assets/backgrounds/Horizontal/" + str(randi_range(1, 32)) + ".png")


func reload_battle() -> void: # função que recarrega a batalha
	World.estagio -= 1 # volta ao estagio em que o player consegue derrotar o inimigo
	
	spawn_enemy() # spawna o inimigo
	start_timer() # starta os contadores de estagio e ataque do player
	
	save_data()


func save_data() -> void:
	Player.save_data()
	World.save_data()


func _on_timer_player_attack_timeout() -> void: # sinal que é chamado quando o timer de ataque zera
	Player.alter_attack() # modifica os valores de ataque
	
	if Player.critical_attack: # verifica se o ataque é crítico
		take_enemy_damage(Player.damage * 2) # dobra o dano causado
		Player.critical_attack = false # muda a flag para nao causar sempre dano critico
		
	else:
		take_enemy_damage(Player.damage) # causa dano normal ao inimigo


func _on_timer_timeout() -> void: # sinal que é chamado quando o timer do estagio zera
	# condição atendida caso o player nao derrote o inimigo dentro do tempo limite
	if enemy.health > 0:
		timer_batalha.stop() # para o contador do estagio
		timer_player_attack.stop() # para o contador de ataque do player
		enemy.queue_free() # deleta o inimigo atual
		
		reload_battle() # chama a função de recarregar a batalha
		return
	
	timer_batalha.start(World.battle_time) # reinicia o tempo de batalha


func _on_increase_ataque_pressed() -> void:
	var upgrade_cost = Player.x_upgrade_ataque * 250
	
	if upgrade_cost > Player.gold:
		return
	
	Player.gold -= upgrade_cost
	
	Player.x_upgrade_ataque += 1
	Player.damage += 1
	
	# Exibe custo upgrade ataque
	label_upgrade_ataque_cost.text = "Ataque: " + str(Player.x_upgrade_ataque * 250) + " Gold"
	
	save_data()


func _on_increase_time_pressed() -> void:
	var upgrade_cost = Player.x_upgrade_time * 250
	
	if upgrade_cost > Player.gold:
		return
	
	Player.gold -= upgrade_cost
	
	Player.x_upgrade_time += 1
	World.battle_time += 1
	
	# exibe custo upgrade tempo de batalha
	label_upgrade_time_cost.text = "Tempo: " + str(Player.x_upgrade_time * 250) + " Gold"
	
	save_data()
