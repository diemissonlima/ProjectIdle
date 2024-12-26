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

@export_category("Skills - Critical")
@export var btn_increase_critical: TextureButton
@export var label_increase_critical: Label
@export var increase_critical_duration: Timer
@export var increase_critical_cooldown: Timer

var timer: float


func _process(_delta: float) -> void:
	show_label_timer()


func _ready() -> void:
	for btn in get_tree().get_nodes_in_group("btns_skill"):
		btn.pressed.connect(on_button_pressed.bind(btn))
		btn.get_node("Duration").timeout.connect(on_timer_duration_timeout.bind(btn))
		btn.get_node("Cooldown").timeout.connect(on_timer_cooldown_timeout.bind(btn))
		
	var data = Data.data_management["player"]["skills"]
	increase_attack_cooldown.start(data["increase_attack"]["aux_cooldown"])
	increase_gold_cooldown.start(data["increase_gold"]["aux_cooldown"])
	increase_critical_cooldown.start(data["increase_critical"]["aux_cooldown"])
	
	if increase_attack_cooldown.time_left > 0:
		btn_increase_attack.disabled = true
		btn_increase_attack.self_modulate = Color(0.3, 0.3, 0.3)
		label_increase_attack.show()


func show_label_timer() -> void:
	if increase_attack_duration.time_left > 0:
		label_increase_attack.text = "%.0f" % increase_attack_duration.time_left
	if increase_attack_cooldown.time_left > 0:
		label_increase_attack.text = "%.0f" % increase_attack_cooldown.time_left
	
	if increase_gold_duration.time_left > 0:
		label_increase_gold.text = "%.0f" % increase_gold_duration.time_left
	if increase_gold_cooldown.time_left > 0:
		label_increase_gold.text = "%.0f" % increase_gold_cooldown.time_left
		
	if increase_critical_duration.time_left > 0:
		label_increase_critical.text = "%.0f" % increase_critical_duration.time_left
	if increase_critical_cooldown.time_left > 0:
		label_increase_critical.text = "%.0f" % increase_critical_cooldown.time_left


func on_button_pressed(button: TextureButton) -> void:
	button.disabled = true
	button.self_modulate = Color(0.3, 0.3, 0.3)
	
	match button.name:
		"IncreaseAttack":
			increase_attack_duration.start(Player.increase_attack_duration)
			Player.damage *= Player.increase_attack_multiplier
			label_increase_attack.show()
			
		"IncreaseGold":
			World.gold_skill_on = true
			increase_gold_duration.start(Player.increase_gold_duration)
			label_increase_gold.show()
		
		"IncreaseCritical":
			Player.critical_chance *= Data.data_management["player"]["skills"]["increase_critical"]["multiplier"]
			increase_critical_duration.start(Player.increase_critical_duration)
			label_increase_critical.show()


func on_timer_duration_timeout(button: TextureButton) -> void:
	match button.name:
		"IncreaseAttack":
			Player.damage = Player.default_damage
			increase_attack_cooldown.start(Player.increase_attack_cooldown)
		
		"IncreaseGold":
			increase_gold_cooldown.start(Player.increase_gold_cooldown)
			World.gold_skill_on = false
		
		"IncreaseCritical":
			Player.critical_chance /= Data.data_management["player"]["skills"]["increase_critical"]["multiplier"]
			increase_critical_cooldown.start(Player.increase_critical_cooldown)


func on_timer_cooldown_timeout(button: TextureButton) -> void:
	button.self_modulate = Color(1.0, 1.0, 1.0)
	button.disabled = false
	button.get_node("Label").hide()


func _notification(what: int) -> void:
	if what == 1006:
		var data = Data.data_management["player"]["skills"]
		
		if increase_attack_duration.time_left > 0:
			Player.damage /= Player.increase_attack_multiplier
		if increase_critical_duration.time_left > 0:
			Player.critical_chance /= data["increase_critical"]["multiplier"]
		if increase_attack_cooldown.time_left > 0:
			data["increase_attack"]["aux_cooldown"] = float(increase_attack_cooldown.time_left)
		
		get_tree().quit()
		Player.save_data()
