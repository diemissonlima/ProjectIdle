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
	game_time.text = "Tempo Jogado: " + format_gameplay_time()
	average_stage.text = "Maior Estagio: " + str(World.avg_estagio)
	total_gold.text = "Total Gold: " + World.format_number(World.gold_gain)
	total_resets.text = "Total Resets: " + str(World.reset)
	monster_kill.text = "Mobs Mortos: " + str(World.kills)
	dps_boost.text = "DPS Boost: +" + str(Data.data_management["raids"]["raid_damage"]["multiplier"] * 100) + "%"
	gold_boost.text = "Gold Boost: +" + str(Data.data_management["raids"]["raid_gold"]["multiplier"] * 100) + "%"
	critical_chance.text = "Dano Crítico: +" + str(
		(Player.increase_criticaldamage_multiplier + Data.data_management["raids"]["raid_critical"]["multiplier"]) * 100) + "%"


func format_gameplay_time() -> String:
	var hours = int(World.gameplay_time) / 3600
	var minutes = (int(World.gameplay_time) % 3600) / 60
	var seconds = int(World.gameplay_time) % 60
	
	if hours <= 0:
		return "%02dm : %02ds" % [minutes, seconds]
	
	return "%02dh : %02dm : %02ds" % [hours, minutes, seconds]


func _on_close_pressed() -> void:
	self.hide()
