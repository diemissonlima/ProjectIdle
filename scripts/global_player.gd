extends Node

# atributos
var damage: int = 2
var gold: int
var critical_attack: bool = false

# skills
var increase_attack_multiplier: float = 1.0
var increase_attack_duration: int = 10
var increase_attack_cooldown: int = 300

var x_upgrade_ataque: int = 1
var x_upgrade_time: int = 1


func _ready() -> void:
	load_data()


func load_data() -> void:
	Data.load_data()
	var data = Data.data_management["player"]
	
	damage = data["ataque"]
	gold = data["gold"]
	x_upgrade_ataque = data["x_upgrade_ataque"]
	x_upgrade_time = data["x_upgrade_time"]
	
	increase_attack_multiplier = data["skills"]["increase_attack"]["multiplier"]
	increase_attack_duration = data["skills"]["increase_attack"]["duration"]
	increase_attack_cooldown = data["skills"]["increase_attack"]["cooldown"]


func save_data() -> void:
	var data = Data.data_management["player"]
	
	data["ataque"] = damage
	data["gold"] = gold
	data["x_upgrade_ataque"] = x_upgrade_ataque
	data["x_upgrade_time"] = x_upgrade_time
	
	data["skills"]["increase_attack"]["multiplier"] = increase_attack_multiplier
	data["skills"]["increase_attack"]["duration"] = increase_attack_duration
	data["skills"]["increase_attack"]["cooldown"] = increase_attack_cooldown
	
	Data.save_data()


func alter_attack() -> void:
	var chance_critical: float = randf()
	
	if chance_critical >= 0.3 and chance_critical <= 0.5:
		critical_attack = true
