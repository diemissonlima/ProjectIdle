extends Node

@export_category("Skills - Ataque")
@export var btn_increase_attack: TextureButton
@export var label_increase_attack: Label
@export var increase_attack_duration: Timer
@export var increase_attack_cooldown: Timer

@export_category("Skills - Gold")
@export var btn_increase_gold: TextureButton
@export var label_increase_gold: Label
@export var increase_gold_duration: Timer
@export var increase_gold_cooldown: Timer

@export_category("Skills - CriticalDamage")
@export var btn_increase_criticaldamage: TextureButton
@export var label_increase_criticaldamage: Label
@export var increase_criticaldamage_duration: Timer
@export var increase_criticaldamage_cooldown: Timer

@export_category("Skills - AttackSpeed")
@export var btn_increase_attackspeed: TextureButton
@export var label_increase_attackSpeed: Label
@export var increase_attackspeed_duration: Timer
@export var increase_attackspeed_cooldown: Timer

@export var box_info: Control


func _ready() -> void:
	connect_button_signal()
	load_skill_cooldown()


func _process(_delta: float) -> void:
	show_label_timer()


func connect_button_signal() -> void:
	for btn in get_tree().get_nodes_in_group("btns_skill"):
		btn.pressed.connect(on_button_pressed.bind(btn))
		btn.get_node("Button").pressed.connect(on_skill_info_button_pressed.bind(btn))
		btn.get_node("Duration").timeout.connect(on_timer_duration_timeout.bind(btn))
		btn.get_node("Cooldown").timeout.connect(on_timer_cooldown_timeout.bind(btn))


func load_skill_cooldown() -> void:
	var data = Data.data_management["player"]["skills"]
	
	if data["increase_attack"]["aux_cooldown"] > 0:
		increase_attack_cooldown.start(data["increase_attack"]["aux_cooldown"])
	if data["increase_gold"]["aux_cooldown"] > 0:
		increase_gold_cooldown.start(data["increase_gold"]["aux_cooldown"])
	if data["increase_critical_damage"]["aux_cooldown"] > 0:
		increase_criticaldamage_cooldown.start(data["increase_critical_damage"]["aux_cooldown"])
	if data["increase_attackspeed"]["aux_cooldown"] > 0:
		increase_attackspeed_cooldown.start(data["increase_attackspeed"]["aux_cooldown"])
	
	if data["increase_attack"]["aux_duration"] > 0:
		Player.damage_skill_on = true
		increase_attack_duration.start(data["increase_attack"]["aux_duration"])
	if data["increase_gold"]["aux_duration"] > 0:
		Player.gold_skill_on = true
		increase_gold_duration.start(data["increase_gold"]["aux_duration"])
	if data["increase_critical_damage"]["aux_duration"] > 0:
		Player.critical_damage_skill_on = true
		increase_criticaldamage_duration.start(data["increase_critical_damage"]["aux_duration"])
	if data["increase_attackspeed"]["aux_duration"] > 0:
		Player.attackspeed_skill_on = true
		increase_attackspeed_duration.start(data["increase_attackspeed"]["aux_duration"])
	
	for button in get_tree().get_nodes_in_group("btns_skill"):
		var duration = button.get_node("Duration")
		var cooldown = button.get_node("Cooldown")
		var label = button.get_node("Label")
		
		if duration.time_left > 0:
			button.disabled = true
			button.self_modulate = Color(0.3, 0.3, 0.3)
			label.show()
		
		if cooldown.time_left > 0:
			button.disabled = true
			button.self_modulate = Color(0.3, 0.3, 0.3)
			label.show()


func show_label_timer() -> void:
	for button in get_tree().get_nodes_in_group("btns_skill"):
		var duration = button.get_node("Duration")
		var cooldown = button.get_node("Cooldown")
		var label = button.get_node("Label")
		
		if duration.time_left > 0:
			label.text = "%.0f" % duration.time_left
			
		if cooldown.time_left > 0:
			label.text = "%.0f" % cooldown.time_left


func save_timers_left() -> void:
	var data = Data.data_management["player"]["skills"]
	
	if increase_attack_duration.time_left >= 0:
		data["increase_attack"]["aux_duration"] = float(increase_attack_duration.time_left)
	if increase_gold_duration.time_left >= 0:
		data["increase_gold"]["aux_duration"] = float(increase_gold_duration.time_left)
	if increase_criticaldamage_duration.time_left >= 0:
		data["increase_critical_damage"]["aux_duration"] = float(increase_criticaldamage_duration.time_left)
	if increase_attackspeed_duration.time_left >= 0:
		data["increase_attackspeed"]["aux_duration"] = float(increase_attackspeed_duration.time_left)
		
	if increase_attack_cooldown.time_left >= 0:
		data["increase_attack"]["aux_cooldown"] = float(increase_attack_cooldown.time_left)
	if increase_gold_cooldown.time_left >= 0:
		data["increase_gold"]["aux_cooldown"] = float(increase_gold_cooldown.time_left)
	if increase_criticaldamage_cooldown.time_left >= 0:
		data["increase_critical_damage"]["aux_cooldown"] = float(increase_criticaldamage_cooldown.time_left)
	if increase_attackspeed_cooldown.time_left >= 0:
		data["increase_attackspeed"]["aux_cooldown"] = float(increase_attackspeed_cooldown.time_left)


# envia o botao selecionado para a funcao get_skill_info() no script box_skill_info
func on_skill_info_button_pressed(button: TextureButton) -> void:
	box_info.show()
	get_tree().call_group("box_skill_info", "get_skill_info", button)


func on_button_pressed(button: TextureButton) -> void:
	button.disabled = true
	button.self_modulate = Color(0.3, 0.3, 0.3)
	
	match button.name:
		"IncreaseAttack":
			increase_attack_duration.start(Player.increase_attack_duration)
			Player.damage_skill_on = true
			label_increase_attack.show()
			
		"IncreaseGold":
			Player.gold_skill_on = true
			increase_gold_duration.start(Player.increase_gold_duration)
			label_increase_gold.show()
		
		"IncreaseCriticalDamage":
			Player.critical_damage_skill_on = true
			increase_criticaldamage_duration.start(Player.increase_criticaldamage_duration)
			label_increase_criticaldamage.show()
			
		"IncreaseAttackSpeed":
			Player.attack_speed -= Player.increase_attackspeed_multiplier
			Player.attackspeed_skill_on = true
			
			increase_attackspeed_duration.start(Player.increase_attackspeed_duration)
			label_increase_attackSpeed.show()


func on_timer_duration_timeout(button: TextureButton) -> void:
	match button.name:
		"IncreaseAttack":
			Player.damage = Player.default_damage
			Player.damage_skill_on = false
			increase_attack_cooldown.start(Player.increase_attack_cooldown)
		
		"IncreaseGold":
			increase_gold_cooldown.start(Player.increase_gold_cooldown)
			Player.gold_skill_on = false
		
		"IncreaseCriticalDamage":
			increase_criticaldamage_cooldown.start(Player.increase_criticaldamage_cooldown)
			Player.critical_damage_skill_on = false
			
		"IncreaseAttackSpeed":
			Player.attack_speed = 0.5
			Player.attackspeed_skill_on = false
			increase_attackspeed_cooldown.start(Player.increase_attackspeed_cooldown)


func on_timer_cooldown_timeout(button: TextureButton) -> void:
	button.self_modulate = Color(1.0, 1.0, 1.0)
	button.disabled = false
	button.get_node("Label").hide()


func _notification(what: int) -> void:
	if what == 1006:
		save_timers_left()
		
		Data.save_data()
		get_tree().quit()
