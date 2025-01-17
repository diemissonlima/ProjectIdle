extends Control

@export_category("Objetos")
@export var background: TextureRect
@export var timer_batalha: Timer
@export var timer_player_attack: Timer
@export var spawn_position: Marker2D

@export_category("Labels")
@export var label_stage: Label
@export var label_substage: Label
@export var label_contador: Label
@export var label_gold: Label
@export var label_skill_points: Label
@export var label_prestige_points: Label
@export var label_player_atk: Label
@export var label_popup_gold: Label
@export var label_upgrade_ataque_cost: Label
@export var label_upgrade_time_cost: Label

@export_category("Labels - Status")
@export var label_gameplay_time: Label
@export var label_avg_stage: Label
@export var label_total_gold: Label
@export var label_resets: Label
@export var label_monster_kill: Label
@export var label_gold_boost: Label
@export var label_dps_boost: Label
@export var label_critical_chance: Label

@export_category("Buttons")
@export var increase_attack: TextureButton
@export var increase_battle_time: TextureButton
@export var btn_next_stage: TextureButton

@export_category("Variaveis")
@export var enemy_list: Array[PackedScene]
@export var enemy_list2: Array[PackedScene]

var reset_target: int = 50
var timer_farm: float = 0.5
var stop_progress: bool = false
var raid_fight: bool = false

var enemy


func _ready() -> void:
	load_background() # carrega o background do estagio
	set_label_upgrade() # seta as labels que informa o custo do upgrade
	spawn_enemy() # spawna o inimigo
	timer_player_attack.start(Player.attack_speed)
	
	if World.stage_progress == 10:
		timer_batalha.start(World.battle_time)
		label_contador.show()
		label_substage.hide()


func _process(delta: float) -> void:
	World.gameplay_time += delta
	set_stage_label() # atualiza constantemente o label de vida do inimigo
	set_label_upgrade()


func start_timer() -> void: # inicia os contadores
	timer_player_attack.start(Player.attack_speed) # inicia o timer de ataque do player, padrao 1s
	timer_batalha.start(World.battle_time) # inicia o contador do estagio


func spawn_enemy() -> void: # função que realiza o spawn do inimigo
	enemy = enemy_list2.pick_random().instantiate() # seleciona um inimigo aleatorio da lista
	enemy.global_position = spawn_position.global_position # seta a posicao do inimigo na tela
	get_tree().root.call_deferred("add_child", enemy) # adiciona o inimigo à cena


func spawn_boss_raid(enemy_path: String) -> void:
	enemy = load(enemy_path).instantiate()
	enemy.global_position = spawn_position.global_position # seta a posicao do inimigo na tela
	get_tree().root.call_deferred("add_child", enemy) # adiciona o inimigo à cena


func set_stage_label() -> void:
	label_stage.text = "Stage: " + str(World.estagio) # exibe o estagio atual
	label_substage.text = str(World.stage_progress) + " / 10"
	label_gold.text = "Gold: " + World.format_number(Player.gold) # exibe o gold
	label_skill_points.text = "S.Points: " + str(Player.skill_points)
	label_prestige_points.text = "P.Points: " + World.format_number(round(Player.prestige_points))
	label_player_atk.text = "DPS: " + World.format_number(round(Player.damage_total)) # exibe ataque do player
	
	update_timer_display() # chama função pra atualizar a label de tempo de batalha


func set_label_upgrade() -> void:
	label_upgrade_ataque_cost.text = "DPS: " + World.format_number(Player.x_upgrade_ataque * 250) # Exibe custo upgrade ataque
	label_upgrade_time_cost.text = "Tempo: " + World.format_number(Player.x_upgrade_time * 350) # exibe custo upgrade tempo de batalha


func update_timer_display() ->  void: # função pra atualizar label de batalha
	var minutes = int(timer_batalha.time_left) / 60 # converte o time_left do timer pra minutos
	var seconds = int(timer_batalha.time_left) % 60 # converte o time_left do timer pra segundos

	label_contador.text = String("%02d : %02d" % [int(minutes), int(seconds)]) # formata a string


func take_enemy_damage(_damage: float) -> void: # causa dano ao inimigo
	enemy.health -= _damage # diminui a vida em funcao do dano do player
	
	if enemy.health <= 0: # se a vida chegar a zero, chama a função de matar o inimigo
		killer_enemy(enemy.enemy_type)


func killer_enemy(enemy_type) -> void:
	if enemy_type == 2: # boss raid damage
		var raid_level: int = Data.data_management["raids"]["raid_damage"]["level"]
		Player.skill_points += 5
		
		if raid_level % 5 == 0:
			Data.data_management["raids"]["raid_damage"]["multiplier"] += 0.5
		
		Data.data_management["raids"]["raid_damage"]["level"] += 1
		get_tree().call_group("raids_management", "update_cooldown_raid", "raid_damage")
	
	if enemy_type == 3: # boss raid gold
		Player.skill_points += 1
		Data.data_management["raids"]["raid_gold"]["multiplier"] += 0.1
		
		Data.data_management["raids"]["raid_gold"]["level"] += 1
		get_tree().call_group("raids_management", "update_cooldown_raid", "raid_gold")
	
	if enemy_type == 4: # boss raid citical
		Player.skill_points += 1
		Data.data_management["raids"]["raid_critical"]["multiplier"] += 0.01
		
		Data.data_management["raids"]["raid_critical"]["level"] += 1
		get_tree().call_group("raids_management", "update_cooldown_raid", "raid_critical")
	
	get_tree().call_group("enemy", "next_health")
	raid_fight = false
	Player.gold += enemy.dropped_gold
	show_popup_gold(enemy.dropped_gold)
	
	World.kills += 1
	World.gold_gain += enemy.dropped_gold
	
	enemy.queue_free() # deleta o inimigo da cena
	load_background() # carrega um novo background
	
	
	#if enemy.enemy_type == 0 or enemy.enemy_type == 1:
	if not stop_progress:
		if enemy.enemy_type == 0 or enemy.enemy_type == 1:
			World.stage_progress += 1
		if World.stage_progress > 10:
			if World.estagio % 5 == 0:
				Player.skill_points += 1
				
			World.estagio += 1 # incrementa o estagio em + 1
			World.stage_progress = 1
			
		if World.stage_progress == 10:
			timer_batalha.start(World.battle_time)
			
			label_contador.show()
			label_substage.hide()
		else:
			label_contador.hide()
			label_substage.show()
			timer_batalha.stop()
			
		spawn_enemy() # spawna o inimigo
	else:
		reload_battle()
		return
	
	if World.estagio > World.avg_estagio:
		World.avg_estagio = World.estagio


func show_popup_gold(value: int) -> void:
	label_popup_gold.show()
	label_popup_gold.text = "+ " + World.format_number(value)
	await get_tree().create_timer(0.4).timeout
	label_popup_gold.hide()


func load_background() -> void: # carrega o background do estagio
	background.texture = load("res://assets/backgrounds/Horizontal/" + str(randi_range(1, 32)) + ".png")


func reload_battle() -> void:
	btn_next_stage.show()
	label_contador.hide()
	
	if not raid_fight:
		stop_progress = true
	else:
		if World.stage_progress == 10:
			timer_batalha.start(World.battle_time)
			btn_next_stage.hide()
			label_contador.show()
		else:
			btn_next_stage.hide()
			label_contador.hide()
			label_substage.show()
	
	if stop_progress:
		if World.stage_progress == 10:
			World.stage_progress -= 1
	
	raid_fight = false
	
	spawn_enemy() # spawna o inimigo
	timer_player_attack.start(Player.attack_speed)


func prestige_points() -> int:
	var base_points: int = (World.estagio - reset_target) / 10 + 1
	var scaling_factor: float = 1.10
	var points: float = base_points * pow(scaling_factor, base_points)
	
	return points
	
	#var base_health: float = 10.0  # Vida inicial
	#var scaling_factor: float = 1.10  # Fator de crescimento exponencial
	#max_health = base_health * pow(scaling_factor, World.estagio)


func reset() -> void:
	btn_next_stage.hide()
	label_contador.show()
	stop_progress = false
	Player.prestige_points += prestige_points()
	World.estagio = 1
	
	World.reset += 1
	timer_batalha.stop() # para o contador do estagio
	label_contador.hide()
	World.stage_progress = 1
	enemy.queue_free() # deleta o inimigo atual
	
	spawn_enemy() # spawna o inimigo
	timer_player_attack.start() # para o contador de ataque do player


func get_datetime() -> void:
	var current_time = Time.get_datetime_dict_from_system()
	var time = Time.get_unix_time_from_datetime_dict(current_time)
	
	Data.data_management["world"]["exit_time"] = time


func stop_battle(raid_type: String) -> void:
	timer_batalha.stop()
	timer_player_attack.stop()
	enemy.queue_free()
	
	var enemy_path: String = ""
	
	match raid_type:
		"raid_damage":
			enemy_path = "res://scenes/boss_raids/raid_boss_damage.tscn"
			
		"raid_gold":
			enemy_path = "res://scenes/boss_raids/raid_boss_gold.tscn"
			
		"raid_critical":
			enemy_path = "res://scenes/boss_raids/raid_boss_critical.tscn"
	
	spawn_boss_raid(enemy_path)
	start_raid_battle()


func start_raid_battle() -> void:
	raid_fight = true
	timer_batalha.start(10.0)
	timer_player_attack.start(Player.attack_speed)
	
	label_substage.hide()
	label_contador.show()


func _on_timer_player_attack_timeout() -> void: # sinal que é chamado quando o timer de ataque zera
	Player.alter_attack() # modifica os valores de ataque
	
	if Player.critical_attack: # verifica se o ataque é crítico
		take_enemy_damage(Player.damage_total * 2) # dobra o dano causado
		Player.critical_attack = false # muda a flag para nao causar sempre dano critico
		
	else:
		take_enemy_damage(Player.damage_total) # causa dano normal ao inimigo
	
	if Player.attackspeed_skill_on:
		timer_player_attack.start(Player.attack_speed)
	else:
		timer_player_attack.start(Player.attack_speed)


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
	Player.default_damage += 1
	# Exibe custo upgrade ataque
	label_upgrade_ataque_cost.text = "Ataque: " + World.format_number(Player.x_upgrade_ataque * 250)


func _on_increase_time_pressed() -> void:
	var upgrade_cost = Player.x_upgrade_time * 350
	
	if upgrade_cost > Player.gold:
		return
	
	Player.gold -= upgrade_cost
	
	Player.x_upgrade_time += 1
	World.battle_time += 1
	
	# exibe custo upgrade tempo de batalha
	label_upgrade_time_cost.text = "Tempo: " + World.format_number(Player.x_upgrade_time * 350)


func _on_reset_pressed() -> void:
	if World.estagio <= reset_target:
		return
	
	get_tree().call_group("reset_info", "update_label_rewards", prestige_points())
	$Interface/ResetInfo.show()


func _on_next_stage_pressed() -> void:
	enemy.queue_free()
	spawn_enemy()
	stop_progress = false
	btn_next_stage.hide()
	
	if World.stage_progress == 9:
		World.stage_progress += 1
		timer_batalha.start(World.battle_time)
		timer_player_attack.start(Player.attack_speed)
		label_contador.show()
		label_substage.hide()


func _on_raides_pressed() -> void:
	get_tree().call_group("raids_management", "update_label")
	$Interface/Raids.show()


func _on_stats_pressed() -> void:
	get_tree().call_group("stats_info", "update_label")
	$Interface/StatsInfo.show()


func _notification(what: int) -> void:
	if what == 1006:
		get_datetime()
		Data.save_data()
