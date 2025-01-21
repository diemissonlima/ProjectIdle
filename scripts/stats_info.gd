extends Control

@export_category("Objetos")
@export var game_time: Label
@export var average_stage: Label
@export var total_gold: Label
@export var total_resets: Label
@export var monster_kill: Label
@export var dps_boost: Label
@export var gold_boost: Label
@export var critical_chance: Label


func update_label() -> void:
	var raids: Dictionary = Data.data_management["raids"]
	var upgrade: Dictionary = Data.data_management["upgrades"]
	
	var total_gold_boost = (raids["raid_gold"]["multiplier"] + upgrade["gold"]["multiplier"]) * 100
	var total_dps_boost = (raids["raid_damage"]["multiplier"] + upgrade["damage"]["multiplier"]) * 100
	var total_c_damage_boost = (raids["raid_critical"]["multiplier"] + upgrade["critical_damage"]["multiplier"]) * 100
	
	game_time.text = "Gametime: " + format_gameplay_time()
	average_stage.text = "Highest Stage: " + str(World.avg_estagio)
	total_gold.text = "Total Gold: " + World.format_number(World.gold_gain)
	total_resets.text = "Total Resets: " + str(World.reset)
	monster_kill.text = "Monster Kill: " + str(World.kills)
	dps_boost.text = "DPS Boost: +" + str(total_dps_boost) + "%"
	gold_boost.text = "Gold Boost: +" + str(total_gold_boost) + "%"
	critical_chance.text = "Critical Damage: +" + str(total_c_damage_boost) + "%"


func format_gameplay_time() -> String:
	var hours = int(World.gameplay_time) / 3600
	var minutes = (int(World.gameplay_time) % 3600) / 60
	var seconds = int(World.gameplay_time) % 60
	
	if hours <= 0:
		return "%02dm : %02ds" % [minutes, seconds]
	
	return "%02dh : %02dm : %02ds" % [hours, minutes, seconds]


func _on_close_pressed() -> void:
	self.hide()
