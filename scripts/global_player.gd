extends Node

# atributos
var level: int = 1
var current_exp: float = 0.0
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
var points: int
var skill_points: int

# itens equipados
var equipped_items: Dictionary = {
	"weapon": {
		"slot": "",
		"bonus_attributes": {
			"damage": 0.0,
			"critical_damage": 0.0,
			"gold": 0.0,
			"prestige_points": 0.0
		}
	},
	"shield": {
		"slot": "",
		"bonus_attributes": {
			"damage": 0.0,
			"critical_damage": 0.0,
			"gold": 0.0,
			"prestige_points": 0.0
		}
	},
	"ring": {
		"slot": "",
		"bonus_attributes": {
			"damage": 0.0,
			"critical_damage": 0.0,
			"gold": 0.0,
			"prestige_points": 0.0
		}
	},
	"necklace": {
		"slot": "",
		"bonus_attributes": {
			"damage": 0.0,
			"critical_damage": 0.0,
			"gold": 0.0,
			"prestige_points": 0.0
		}
	}
}

# skills
var attack_skill_level: int = 1
var increase_attack_multiplier: float = 1.25

var gold_skill_level: int = 1
var increase_gold_multiplier: float = 1.5

var criticaldamage_skill_level: int = 1
var increase_criticaldamage_multiplier: float = 2.0

var attackspeed_skill_level: int = 1
var increase_attackspeed_multiplier: float = 1.25

var skill_duration: float = 0.0
var skill_duration_level: int = 1
var skill_cooldown: float = 0.0
var skill_cooldown_level: int = 1
var x_upgrade_ataque: int = 1
var x_upgrade_time: int = 1

var gold_skill_on: bool = false
var attackspeed_skill_on: bool = false
var critical_damage_skill_on: bool = false
var damage_skill_on: bool = false

var level_dict: Dictionary = {
	"1": 500, "2": 625, "3": 781, "4": 976, "5": 1220,
	"6": 1525, "7": 1907, "8": 2384, "9": 2980, "10": 3725,
	"11": 4656, "12": 5820, "13": 7275, "14": 9093, "15": 11366,
	"16": 14207, "17": 17759, "18": 22199, "19": 27749, "20": 34687
}


func _ready() -> void:
	load_data()
	damage_total = damage + bonus_damage


func load_data() -> void:
	Data.load_data()
	var data = Data.data_management["player"]
	var data_skills = data["skills"]
	var data_upgrade = Data.data_management["upgrades"]
	
	level = data["level"]
	current_exp = data["current_exp"]
	damage = data["ataque"]
	default_damage = data["default_damage"]
	attack_speed = data["attack_speed"]
	gold = data["gold"]
	skill_points = data["skill_points"]
	prestige_points = data["prestige_points"]
	points = Data.data_management["statistics"]["points"]
	x_upgrade_ataque = data["x_upgrade_ataque"]
	x_upgrade_time = data["x_upgrade_time"]
	skill_duration = data_upgrade["skill_duration"]["multiplier"]
	skill_duration_level = data_upgrade["skill_duration"]["level"]
	skill_cooldown = data_upgrade["skill_cooldown"]["multiplier"]
	skill_cooldown_level = data_upgrade["skill_cooldown"]["level"]
	
	attack_skill_level = data_skills["increase_attack"]["level"]
	increase_attack_multiplier = data_skills["increase_attack"]["multiplier"]
	
	attackspeed_skill_level = data_skills["increase_attackspeed"]["level"]
	increase_attackspeed_multiplier = data_skills["increase_attackspeed"]["multiplier"]
	
	gold_skill_level = data_skills["increase_gold"]["level"]
	increase_gold_multiplier = data_skills["increase_gold"]["multiplier"]
	
	criticaldamage_skill_level = data_skills["increase_critical_damage"]["level"]
	increase_criticaldamage_multiplier = data_skills["increase_critical_damage"]["multiplier"]


func save_data() -> void:
	var data = Data.data_management["player"]
	var data_skills = data["skills"]
	var data_upgrade = Data.data_management["upgrades"]
	
	data["level"] = level
	data["current_exp"] = current_exp
	data["ataque"] = damage
	data["default_damage"] = default_damage
	data["attack_speed"] = attack_speed
	data["gold"] = gold
	data["skill_points"] = skill_points
	data["prestige_points"] = prestige_points
	Data.data_management["statistics"]["points"] = points
	data["x_upgrade_ataque"] = x_upgrade_ataque
	data["x_upgrade_time"] = x_upgrade_time
	data_upgrade["skill_duration"]["multiplier"] = skill_duration
	data_upgrade["skill_duration"]["level"] = skill_duration_level
	data_upgrade["skill_cooldown"]["multiplier"] = skill_cooldown
	data_upgrade["skill_cooldown"]["level"] = skill_cooldown_level
	
	data_skills["increase_attack"]["level"] = attack_skill_level
	data_skills["increase_attack"]["multiplier"] = increase_attack_multiplier
	
	data_skills["increase_attackspeed"]["level"] = attackspeed_skill_level
	data_skills["increase_attackspeed"]["multiplier"] = increase_attackspeed_multiplier
	
	data_skills["increase_gold"]["level"] = gold_skill_level
	data_skills["increase_gold"]["multiplier"] = increase_gold_multiplier
	
	data_skills["increase_critical_damage"]["level"] = criticaldamage_skill_level
	data_skills["increase_critical_damage"]["multiplier"] = increase_criticaldamage_multiplier
	
	Data.save_data()


func update_exp(value: int) -> void:
	current_exp += value
	
	if current_exp >= level_dict[str(level)]:
		var leftover = current_exp - level_dict[str(level)]
		current_exp = leftover
		level += 1
	
	get_tree().call_group("world", "update_expbar")


func handler_item(state: String, equipment_type: String, slot: String) -> void:
	var data_equipment: Dictionary = Data.data_management["equipments"][equipment_type][slot.to_lower()]
	var keys: Array = []
	
	if state == "equip":
		for key in data_equipment["atributtes"].keys():
			keys.append(key)
		
		equipped_items[equipment_type]["slot"] = slot
		equipped_items[equipment_type]["bonus_attributes"][keys[0]] = data_equipment["atributtes"][keys[0]]
		equipped_items[equipment_type]["bonus_attributes"][keys[1]] = data_equipment["atributtes"][keys[1]]
		
	elif state == "unequip":
		data_equipment["is_equipped"] = false
		for key in equipped_items[equipment_type]["bonus_attributes"].keys():
			equipped_items[equipment_type]["bonus_attributes"][key] = 0.0
		
		get_tree().call_group("equipments", "load_equipment", equipment_type)


func alter_attack() -> void:
	var critical_chance_multiplier: float = Data.data_management["upgrades"]["critical_chance"]["multiplier"]
	var raid_damage_multiplier: float = Data.data_management["raids"]["raid_damage"]["multiplier"]
	var upgrade_damage_multiplier: float = Data.data_management["upgrades"]["damage"]["multiplier"]
	var equipment_damage_multiplier: float = (
		equipped_items["weapon"]["bonus_attributes"]["damage"] \
	 	+ equipped_items["shield"]["bonus_attributes"]["damage"] \
		+ equipped_items["ring"]["bonus_attributes"]["damage"] \
		+ equipped_items["necklace"]["bonus_attributes"]["damage"]
	)
	
	var damage_multiplier: float = (
		upgrade_damage_multiplier + equipment_damage_multiplier + raid_damage_multiplier
		) * 100
	
	damage_total = damage + ((damage_multiplier * damage) / 100)
	
	if damage_skill_on:
		var damage_skill_multiplier: float = Data.data_management["player"]["skills"]["increase_attack"]["multiplier"] * 100
		damage_total += (damage_skill_multiplier * damage_total / 100)
	
	var rng: float = randf()
	if rng <= critical_chance + critical_chance_multiplier:
		var upgrade_critical_damage_multiplier: float = Data.data_management["upgrades"]["critical_damage"]["multiplier"]
		var raid_critical_damage_multiplier: float = Data.data_management["raids"]["raid_critical"]["multiplier"]
		var equipment_critical_damage_multiplier: float = (
			equipped_items["weapon"]["bonus_attributes"]["critical_damage"] \
			+ equipped_items["shield"]["bonus_attributes"]["critical_damage"] \
			+ equipped_items["ring"]["bonus_attributes"]["critical_damage"] \
			+ equipped_items["necklace"]["bonus_attributes"]["critical_damage"]
		)
		
		var critical_damage_multiplier: float = (
			upgrade_critical_damage_multiplier + raid_critical_damage_multiplier + equipment_critical_damage_multiplier
			) * 100
		
		bonus_damage = (critical_damage_multiplier * damage_total) / 100
		critical_attack = true


func _notification(what: int) -> void:
	if what == 1006:
		save_data()
