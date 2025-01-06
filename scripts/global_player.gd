extends Node

# atributos
var damage: float = 5.0
var default_damage: float
var attack_speed: float = 1.0
var critical_attack: bool = false
var critical_chance: float = 0.05

# recursos
var gold: int
var prestige_points: int
var skill_points: int


# skills
var increase_attack_multiplier: float = 1.25
var increase_attack_duration: int = 30
var increase_attack_cooldown: int = 150

var increase_gold_multiplier: float = 1.5
var increase_gold_duration: int = 30
var increase_gold_cooldown: int = 150

var increase_critical_multiplier: float = 2.0
var increase_critical_duration: int = 30
var increase_critical_cooldown: int = 150

var x_upgrade_ataque: int = 1
var x_upgrade_time: int = 1

var gold_skill_on: bool = false


func _ready() -> void:
	load_data()


func load_data() -> void:
	Data.load_data()
	var data = Data.data_management["player"]
	
	damage = data["ataque"]
	default_damage = data["default_damage"]
	attack_speed = data["attack_speed"]
	gold = data["gold"]
	skill_points = data["skill_points"]
	prestige_points = data["prestige_points"]
	x_upgrade_ataque = data["x_upgrade_ataque"]
	x_upgrade_time = data["x_upgrade_time"]
	
	increase_attack_multiplier = data["skills"]["increase_attack"]["multiplier"]
	increase_attack_duration = data["skills"]["increase_attack"]["duration"]
	increase_attack_cooldown = data["skills"]["increase_attack"]["cooldown"]
	
	increase_gold_multiplier = data["skills"]["increase_gold"]["multiplier"]
	increase_gold_duration = data["skills"]["increase_gold"]["duration"]
	increase_gold_cooldown = data["skills"]["increase_gold"]["cooldown"]
	
	critical_chance = data["skills"]["increase_critical"]["critical_chance"]
	increase_critical_multiplier = data["skills"]["increase_critical"]["multiplier"]
	increase_critical_duration = data["skills"]["increase_critical"]["duration"]
	increase_critical_cooldown = data["skills"]["increase_critical"]["cooldown"]


func save_data() -> void:
	var data = Data.data_management["player"]
	var data_skills = data["skills"]
	
	data["ataque"] = damage
	data["default_damage"] = default_damage
	data["attack_speed"] = attack_speed
	data["gold"] = gold
	data["skill_points"] = skill_points
	data["prestige_points"] = prestige_points
	data["x_upgrade_ataque"] = x_upgrade_ataque
	data["x_upgrade_time"] = x_upgrade_time
	
	data_skills["increase_attack"]["multiplier"] = increase_attack_multiplier
	data_skills["increase_attack"]["duration"] = increase_attack_duration
	data_skills["increase_attack"]["cooldown"] = increase_attack_cooldown
	
	data_skills["increase_gold"]["multiplier"] = increase_gold_multiplier
	data_skills["increase_gold"]["duration"] = increase_gold_duration
	data_skills["increase_gold"]["cooldown"] = increase_gold_cooldown
	
	data_skills["increase_critical"]["critical_chance"] = critical_chance
	data_skills["increase_critical"]["multiplier"] = increase_critical_multiplier
	data_skills["increase_critical"]["duration"] = increase_critical_duration
	data_skills["increase_critical"]["cooldown"] = increase_critical_cooldown
	
	Data.save_data()


func alter_attack() -> void:
	var random_number: float = randf()
	
	if random_number <= critical_chance:
		critical_attack = true


func _notification(what: int) -> void:
	if what == 1006:
		save_data()
