extends Node

var damage: int = 2
var gold: int
var critical_attack: bool = false

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


func save_data() -> void:
	var data = Data.data_management["player"]
	
	data["ataque"] = damage
	data["gold"] = gold
	data["x_upgrade_ataque"] = x_upgrade_ataque
	data["x_upgrade_time"] = x_upgrade_time
	
	Data.save_data()


func alter_attack() -> void:
	var chance_critical: float = randf()
	
	if chance_critical >= 0.3 and chance_critical <= 0.5:
		critical_attack = true
