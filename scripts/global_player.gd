extends Node

# atributos
var damage: float = 5.0
var damage_total: float
var default_damage: float
var bonus_damage: float
var attack_speed: float = 1.0
var critical_attack: bool = false
var critical_chance: float = 0.05
var bonus_critical_chance: float

# recursos
var gold: int
var prestige_points: int
var skill_points: int


# skills
var attack_skill_level: int = 1
var increase_attack_multiplier: float = 1.25
var increase_attack_duration: int = 30
var increase_attack_cooldown: int = 150

var gold_skill_level: int = 1
var increase_gold_multiplier: float = 1.5
var increase_gold_duration: int = 30
var increase_gold_cooldown: int = 150

var criticaldamage_skill_level: int = 1
var increase_criticaldamage_multiplier: float = 2.0
var increase_criticaldamage_duration: int = 30
var increase_criticaldamage_cooldown: int = 150

var attackspeed_skill_level: int = 1
var increase_attackspeed_multiplier: float = 1.25
var increase_attackspeed_duration: int = 30
var increase_attackspeed_cooldown: int = 150

var x_upgrade_ataque: int = 1
var x_upgrade_time: int = 1

var gold_skill_on: bool = false
var attackspeed_skill_on: bool = false
var critical_damage_skill_on: bool = false


func _ready() -> void:
	load_data()
	damage_total = damage + bonus_damage


func load_data() -> void:
	Data.load_data()
	var data = Data.data_management["player"]
	var data_skills = data["skills"]
	
	damage = data["ataque"]
	default_damage = data["default_damage"]
	attack_speed = data["attack_speed"]
	gold = data["gold"]
	skill_points = data["skill_points"]
	prestige_points = data["prestige_points"]
	x_upgrade_ataque = data["x_upgrade_ataque"]
	x_upgrade_time = data["x_upgrade_time"]
	
	attack_skill_level = data_skills["increase_attack"]["level"]
	increase_attack_multiplier = data_skills["increase_attack"]["multiplier"]
	increase_attack_duration = data_skills["increase_attack"]["duration"]
	increase_attack_cooldown = data_skills["increase_attack"]["cooldown"]
	
	attackspeed_skill_level = data_skills["increase_attackspeed"]["level"]
	increase_attackspeed_multiplier = data_skills["increase_attackspeed"]["multiplier"]
	increase_attackspeed_duration = data_skills["increase_attackspeed"]["duration"]
	increase_attackspeed_cooldown = data_skills["increase_attackspeed"]["cooldown"]
	
	gold_skill_level = data_skills["increase_gold"]["level"]
	increase_gold_multiplier = data_skills["increase_gold"]["multiplier"]
	increase_gold_duration = data_skills["increase_gold"]["duration"]
	increase_gold_cooldown = data_skills["increase_gold"]["cooldown"]
	
	criticaldamage_skill_level = data_skills["increase_critical_damage"]["level"]
	increase_criticaldamage_multiplier = data_skills["increase_critical_damage"]["multiplier"]
	increase_criticaldamage_duration = data_skills["increase_critical_damage"]["duration"]
	increase_criticaldamage_cooldown = data_skills["increase_critical_damage"]["cooldown"]


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
	
	data_skills["increase_attack"]["level"] = attack_skill_level
	data_skills["increase_attack"]["multiplier"] = increase_attack_multiplier
	data_skills["increase_attack"]["duration"] = increase_attack_duration
	data_skills["increase_attack"]["cooldown"] = increase_attack_cooldown
	
	data_skills["increase_attackspeed"]["level"] = attackspeed_skill_level
	data_skills["increase_attackspeed"]["multiplier"] = increase_attackspeed_multiplier
	data_skills["increase_attackspeed"]["duration"] = increase_attackspeed_duration
	data_skills["increase_attackspeed"]["cooldown"] = increase_attackspeed_cooldown
	
	data_skills["increase_gold"]["level"] = gold_skill_level
	data_skills["increase_gold"]["multiplier"] = increase_gold_multiplier
	data_skills["increase_gold"]["duration"] = increase_gold_duration
	data_skills["increase_gold"]["cooldown"] = increase_gold_cooldown
	
	data_skills["increase_critical_damage"]["level"] = criticaldamage_skill_level
	data_skills["increase_critical_damage"]["multiplier"] = increase_criticaldamage_multiplier
	data_skills["increase_critical_damage"]["duration"] = increase_criticaldamage_duration
	data_skills["increase_critical_damage"]["cooldown"] = increase_criticaldamage_cooldown
	
	Data.save_data()


func alter_attack() -> void:
	var rng: float = randf()
	var raid_damage_multiplier: float = Data.data_management["raids"]["raid_damage"]["multiplier"]
	
	var upgrade_critical_damage_multiplier: float = Data.data_management["upgrades"]["critical_damage"]["multiplier"]
	var raid_critical_damage_multiplier: float = Data.data_management["raids"]["raid_critical"]["multiplier"]
	var critical_damage_multiplier: float = upgrade_critical_damage_multiplier + raid_critical_damage_multiplier
	
	bonus_damage = (critical_damage_multiplier * damage_total) / 100
	damage_total = damage + bonus_damage
	
	print("DANO BONUS: ", bonus_damage)
	print("DANO TOTAL: ", damage_total)
	
	if rng <= critical_chance:
		critical_attack = true


func _notification(what: int) -> void:
	if what == 1006:
		save_data()
