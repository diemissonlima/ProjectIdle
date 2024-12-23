extends Node

# atributos
var damage: float = 2.0
var gold: int
var critical_attack: bool = false
var critical_chance: float = 0.05

# skills
var increase_attack_multiplier: float = 1.0
var increase_attack_duration: int = 10
var increase_attack_cooldown: int = 300

var increase_gold_multiplier: float = 1.0
var increase_gold_duration: int = 10
var increase_gold_cooldown: int = 300

var increase_critical_multiplier: float = 1.0
var increase_critical_duration: int = 10
var increase_critical_cooldown: int = 300

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
	
	increase_gold_multiplier = data["skills"]["increase_gold"]["multiplier"]
	increase_gold_duration = data["skills"]["increase_gold"]["duration"]
	increase_gold_cooldown = data["skills"]["increase_gold"]["cooldown"]
	
	critical_chance = data["skills"]["increase_critical"]["chance"]
	increase_critical_multiplier = data["skills"]["increase_critical"]["multiplier"]
	increase_critical_duration = data["skills"]["increase_critical"]["duration"]
	increase_critical_cooldown = data["skills"]["increase_critical"]["cooldown"]


func save_data() -> void:
	var data = Data.data_management["player"]
	
	data["ataque"] = damage
	data["gold"] = gold
	data["x_upgrade_ataque"] = x_upgrade_ataque
	data["x_upgrade_time"] = x_upgrade_time
	
	data["skills"]["increase_attack"]["multiplier"] = increase_attack_multiplier
	data["skills"]["increase_attack"]["duration"] = increase_attack_duration
	data["skills"]["increase_attack"]["cooldown"] = increase_attack_cooldown
	
	data["skills"]["increase_gold"]["multiplier"] = increase_gold_multiplier
	data["skills"]["increase_gold"]["duration"] = increase_gold_duration
	data["skills"]["increase_gold"]["cooldown"] = increase_gold_cooldown
	
	data["skills"]["increase_critical"]["chance"] = critical_chance
	data["skills"]["increase_critical"]["multiplier"] = increase_critical_multiplier
	data["skills"]["increase_critical"]["duration"] = increase_critical_duration
	data["skills"]["increase_critical"]["cooldown"] = increase_critical_cooldown
	
	Data.save_data()


func alter_attack() -> void:
	var random_number: float = randf()
	
	if random_number <= critical_chance:
		critical_attack = true
