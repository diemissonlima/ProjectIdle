extends Control

@export_category("Objetos")
@export var background: TextureRect
@export var timer_batalha: Timer
@export var timer_player_attack: Timer
@export var timer_save_game: Timer
@export var spawn_position: Marker2D

@export_category("Labels")
@export var label_stage: Label
@export var label_substage: Label
@export var label_contador: Label
@export var label_gold: Label
@export var label_skill_points: Label
@export var label_prestige_points: Label
@export var label_player_atk: Label
@export var label_upgrade_ataque_cost: Label
@export var label_upgrade_time_cost: Label

@export_category("Buttons")
@export var increase_attack: TextureButton
@export var increase_battle_time: TextureButton
@export var btn_next_stage: TextureButton

@export_category("Variaveis")
@export var enemy_list: Array[PackedScene]
@export var enemy_list2: Array[PackedScene]
@export var drop_chance: float

var prestige_points_awarded: int = 0
var reset_target: int = 50
var stop_progress: bool = false
var raid_fight: bool = false

var enemy


func _ready() -> void:
	load_background() # carrega o background do estagio
	set_label_upgrade() # seta as labels que informa o custo do upgrade
	spawn_enemy() # spawna o inimigo
	update_expbar()
	timer_player_attack.start(Player.attack_speed)
	#timer_save_game.start()
	
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
	label_upgrade_ataque_cost.text = "DPS: " + World.format_number(Player.x_upgrade_ataque * 150) + " Gold" # Exibe custo upgrade ataque
	label_upgrade_time_cost.text = "Tempo: " + World.format_number(Player.x_upgrade_time * 250) + " Gold" # exibe custo upgrade tempo de batalha


func update_timer_display() ->  void: # função pra atualizar label de batalha
	var minutes = int(timer_batalha.time_left) / 60 # converte o time_left do timer pra minutos
	var seconds = int(timer_batalha.time_left) % 60 # converte o time_left do timer pra segundos
	
	if enemy.enemy_type == 0 or enemy.enemy_type == 1:
		label_contador.text = String(
			"Boss\n" + "%02d : %02d" % [int(minutes), int(seconds)]
			) # formata a string
	else:
		label_contador.text = String(
			"Raide Boss\n" + "%02d : %02d" % [int(minutes), int(seconds)]
			)


func take_enemy_damage(_damage: float) -> void: # causa dano ao inimigo
	enemy.health -= round(_damage) # diminui a vida em funcao do dano do player
	#enemy.animate_health_bar(round(_damage))
	if enemy.health <= 0: # se a vida chegar a zero, chama a função de matar o inimigo
		enemy.queue_free() # deleta o inimigo da cena
		killer_enemy(enemy.enemy_type)


func killer_enemy(enemy_type) -> void:
	if enemy_type == 2: # boss raid damage
		var raid_level: int = Data.data_management["raids"]["raid_damage"]["level"]
		Player.skill_points += 5
		
		if raid_level % 5 == 0:
			Data.data_management["raids"]["raid_damage"]["multiplier"] += 1.0
		
		Data.data_management["raids"]["raid_damage"]["level"] += 1
		get_tree().call_group("raids_management", "update_cooldown_raid", "raid_damage")
	
	if enemy_type == 3: # boss raid gold
		Player.skill_points += 1
		Data.data_management["raids"]["raid_gold"]["multiplier"] += 0.50
		
		Data.data_management["raids"]["raid_gold"]["level"] += 1
		get_tree().call_group("raids_management", "update_cooldown_raid", "raid_gold")
	
	if enemy_type == 4: # boss raid citical
		Player.skill_points += 1
		Data.data_management["raids"]["raid_critical"]["multiplier"] += 0.30
		
		Data.data_management["raids"]["raid_critical"]["level"] += 1
		get_tree().call_group("raids_management", "update_cooldown_raid", "raid_critical")
	
	get_tree().call_group("enemy", "next_health")
	raid_fight = false
	
	enemy.drop()
	Player.update_exp(enemy.calculate_exp())
	Player.gold += enemy.dropped_gold
	World.gold_gain += enemy.dropped_gold
	
	var rng_drop: float = randf()
	if rng_drop < drop_chance:
		enemy.drop_item()
		
	if enemy_type == 0 or enemy_type == 1:
		Data.data_management["statistics"]["monster"]["enemy_" + str(enemy.id)] += 1
		get_tree().call_group(
			"loot_box", "add_message", "lootbox_1", "+ " \
			+ World.format_number(enemy.dropped_gold) + " gold", Color.GREEN
			)
	
	World.kills += 1
	
	if not stop_progress:
		if enemy.enemy_type == 0 or enemy.enemy_type == 1:
			World.stage_progress += 1
		if World.stage_progress > 10:
			Player.points += World.estagio
			if World.estagio % 5 == 0:
				Player.skill_points += 1
				
				load_background() # carrega um novo background
				
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
	var base_points: int = (World.estagio - reset_target) * 2.0
	var scaling_factor: float = 1.15
	var upgrade_multiplier: float = Data.data_management["upgrades"]["prestige_points"]["multiplier"]
	var equipment_multiplier: float = (
		Player.equipped_items["weapon"]["bonus_attributes"]["prestige_points"] \
		+ Player.equipped_items["shield"]["bonus_attributes"]["prestige_points"] \
		+ Player.equipped_items["ring"]["bonus_attributes"]["prestige_points"] \
		+ Player.equipped_items["necklace"]["bonus_attributes"]["prestige_points"]
	)
	
	var total_multiplier: float = (upgrade_multiplier + equipment_multiplier) * 100
	var points: float = base_points * pow(scaling_factor, World.reset) 
	
	var bonus_points: float = (total_multiplier * points) / 100
	
	return round(points + bonus_points)


func reset() -> void:
	btn_next_stage.hide()
	label_contador.show()
	stop_progress = false
	World.estagio = 1
	World.reset += 1
	Player.prestige_points += prestige_points_awarded
	
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
	var bonus_time = Data.data_management["upgrades"]["raid_time"]["multiplier"]
	
	timer_batalha.start(World.battle_time_raid + bonus_time)
	timer_player_attack.start(Player.attack_speed)
	
	label_substage.hide()
	label_contador.show()


func update_expbar() -> void:
	var progress_bar: TextureProgressBar = $Background/ExpBar
	var exp_label: Label = $Background/ExpBar/ExpLabel
	
	exp_label.text = "Lvl " + str(Player.level) + "  " + str(Player.current_exp) + " / " + str(Player.level_dict[str(Player.level)])
	progress_bar.value = Player.current_exp
	progress_bar.max_value = Player.level_dict[str(Player.level)]


func _on_timer_player_attack_timeout() -> void: # sinal que é chamado quando o timer de ataque zera
	Player.alter_attack() # modifica os valores de ataque
	
	# verifica se o ataque é crítico e a skill de dano critico esta ativa
	if Player.critical_attack and Player.critical_damage_skill_on == true: 
		var bonus_skill_multiplier = Data.data_management["player"]["skills"]["increase_critical_damage"]["multiplier"] * 100
		var bonus_skill_damage = bonus_skill_multiplier * ((Player.damage_total + Player.bonus_damage) / 100)
		var total_damage = Player.damage_total + Player.bonus_damage + bonus_skill_damage
		take_enemy_damage(total_damage)
		Player.critical_attack = false # muda a flag para nao causar sempre dano critico
	
	# verifica se o ataque é crítico e a skill de dano critico NAO esta ativa
	elif Player.critical_attack and Player.critical_damage_skill_on == false:
		take_enemy_damage(Player.damage_total + Player.bonus_damage) # dobra o dano causado
		Player.critical_attack = false # muda a flag para nao causar sempre dano critico
	
	else:
		take_enemy_damage(Player.damage_total)
	
	
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


func _on_timer_save_game_timeout() -> void:
	Player.save_data()
	World.save_data()


func _on_increase_ataque_pressed() -> void:
	var upgrade_cost = Player.x_upgrade_ataque * 150
	
	if upgrade_cost > Player.gold:
		return
	
	Player.gold -= upgrade_cost
	
	Player.x_upgrade_ataque += 1
	Player.damage += 1
	Player.default_damage += 1
	# Exibe custo upgrade ataque
	label_upgrade_ataque_cost.text = "Ataque: " + World.format_number(Player.x_upgrade_ataque * 150) + " Gold"


func _on_increase_time_pressed() -> void:
	var upgrade_cost = Player.x_upgrade_time * 250
	
	if upgrade_cost > Player.gold:
		return
	
	Player.gold -= upgrade_cost
	
	Player.x_upgrade_time += 1
	World.battle_time += 1
	
	# exibe custo upgrade tempo de batalha
	label_upgrade_time_cost.text = "Tempo: " + World.format_number(Player.x_upgrade_time * 250) + " Gold"


func _on_reset_pressed() -> void:
	if World.estagio <= reset_target:
		return
	
	prestige_points_awarded = prestige_points()
	get_tree().call_group("reset_info", "update_label_rewards", prestige_points_awarded)
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


func _on_upgrades_pressed() -> void:
	get_tree().call_group("upgrade_screen", "update_label")
	$Interface/Upgrades.show()


func _on_equips_pressed() -> void:
	$Interface/Equipments.show()


func _notification(what: int) -> void:
	if what == 1006:
		get_datetime()
		Data.save_data()
