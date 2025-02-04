extends Control

@export_category("Objetos")
@export var game_time: Label
@export var average_stage: Label
@export var total_gold: Label
@export var total_resets: Label
@export var monster_kill: Label
@export var points: Label
@export var dps_boost: Label
@export var gold_boost: Label
@export var prestige_boost: Label
@export var critical_chance: Label
@export var critical_damage: Label


func update_label() -> void:
	var raids: Dictionary = Data.data_management["raids"]
	var upgrade: Dictionary = Data.data_management["upgrades"]
	var equipments: Dictionary = Player.equipped_items
	
	var total_gold_boost = (
		raids["raid_gold"]["multiplier"] + upgrade["gold"]["multiplier"] \
		+ equipments["weapon"]["bonus_attributes"]["gold"] \
		+ equipments["shield"]["bonus_attributes"]["gold"] \
		+ equipments["ring"]["bonus_attributes"]["gold"] \
		+ equipments["necklace"]["bonus_attributes"]["gold"]
		) * 100
		
	var total_dps_boost = (
		raids["raid_damage"]["multiplier"] + upgrade["damage"]["multiplier"] \
		+ equipments["weapon"]["bonus_attributes"]["damage"] \
		+ equipments["shield"]["bonus_attributes"]["damage"] \
		+ equipments["ring"]["bonus_attributes"]["damage"] \
		+ equipments["necklace"]["bonus_attributes"]["damage"]
		) * 100
		
	var total_prestige_boost = (
		upgrade["prestige_points"]["multiplier"] \
		+ equipments["weapon"]["bonus_attributes"]["prestige_points"] \
		+ equipments["shield"]["bonus_attributes"]["prestige_points"] \
		+ equipments["ring"]["bonus_attributes"]["prestige_points"] \
		+ equipments["necklace"]["bonus_attributes"]["prestige_points"]
		) * 100
	
	var total_c_damage_boost = (
		raids["raid_critical"]["multiplier"] + upgrade["critical_damage"]["multiplier"] \
		+ equipments["weapon"]["bonus_attributes"]["critical_damage"] \
		+ equipments["shield"]["bonus_attributes"]["critical_damage"] \
		+ equipments["ring"]["bonus_attributes"]["critical_damage"] \
		+ equipments["necklace"]["bonus_attributes"]["critical_damage"]
		) * 100
		
	var total_critical_chance = (Player.critical_chance + upgrade["critical_chance"]["multiplier"]) * 100
	
	game_time.text = "Gametime: " + format_gameplay_time()
	average_stage.text = "Highest Stage: " + str(World.avg_estagio)
	total_gold.text = "Total Gold: " + World.format_number(World.gold_gain)
	total_resets.text = "Total Resets: " + str(World.reset)
	monster_kill.text = "Enemy Kills: " + str(World.kills)
	points.text = "Points: " + str(Player.points)
	dps_boost.text = "DPS Boost: +" + str(total_dps_boost) + "%"
	gold_boost.text = "Gold Boost: +" + str(total_gold_boost) + "%"
	prestige_boost.text = "P. Points Boost: +" + str(total_prestige_boost) + "%"
	critical_damage.text = "Critical Damage: +" + str(total_c_damage_boost) + "%"
	critical_chance.text = "Critical Chance: +" + str(total_critical_chance) + "%"


func format_gameplay_time() -> String:
	var hours = int(World.gameplay_time) / 3600
	var minutes = (int(World.gameplay_time) % 3600) / 60
	var seconds = int(World.gameplay_time) % 60
	
	if hours <= 0:
		return "%02dm : %02ds" % [minutes, seconds]
	
	return "%02d : %02d : %02d" % [hours, minutes, seconds]


func _on_close_pressed() -> void:
	self.hide()
