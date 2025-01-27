extends Control

@export_category("Labels")
@export var box_damage_level: Label
@export var box_damage_current: Label
@export var box_damage_cost: Label
@export var box_gold_level: Label
@export var box_gold_current: Label
@export var box_gold_cost: Label
@export var box_critical_damage_level: Label
@export var box_critica_damage_current: Label
@export var box_critical_damage_cost: Label
@export var box_critical_chance_level: Label
@export var box_critical_chance_current: Label
@export var box_critical_chance_cost: Label
@export var box_raid_time_level: Label
@export var box_raid_time_current: Label
@export var box_raid_time_cost: Label
@export var box_prestige_points_level: Label
@export var box_prestige_points_current: Label
@export var box_prestige_points_cost: Label
@export var box_skill_duration_level: Label
@export var box_skill_duration_current: Label
@export var box_skill_duration_cost: Label
@export var box_skill_cooldown_level: Label
@export var box_skill_cooldown_current: Label
@export var box_skill_cooldown_cost: Label

var data: Dictionary = Data.data_management["upgrades"]


func _ready() -> void:
	connect_buttons()


func connect_buttons() -> void:
	for button in get_tree().get_nodes_in_group("upgrades"):
		button.pressed.connect(on_button_pressed.bind(button.name))


func on_button_pressed(button_name: String) -> void:
	match button_name:
		"IncreaseDamage":
			if Player.prestige_points < int(box_damage_cost.text):
				return
			
			Player.prestige_points -= int(box_damage_cost.text)
			data["damage"]["level"] += 1
			data["damage"]["multiplier"] += 0.25
			
		"IncreaseGold":
			if Player.prestige_points < int(box_gold_cost.text):
				return
			
			Player.prestige_points -= int(box_gold_cost.text)
			data["gold"]["level"] += 1
			data["gold"]["multiplier"] += 0.50
			
		"IncreaseCriticalDamage":
			if Player.prestige_points < int(box_critical_damage_cost.text):
				return
			
			Player.prestige_points -= int(box_critical_damage_cost.text)
			data["critical_damage"]["level"] += 1
			data["critical_damage"]["multiplier"] += 0.15
			
		"IncreaseRaidTime":
			if Player.prestige_points < int(box_raid_time_cost.text):
				return
			
			Player.prestige_points -= int(box_raid_time_cost.text)
			data["raid_time"]["level"] += 1
			data["raid_time"]["multiplier"] += 1
		
		"IncreasePrestigePoints":
			if Player.prestige_points < int(box_prestige_points_cost.text):
				return
			
			Player.prestige_points -= int(box_prestige_points_cost.text)
			data["prestige_points"]["level"] += 1
			data["prestige_points"]["multiplier"] += 0.25
		
		"IncreaseSkillDuration":
			if Player.prestige_points < int(box_skill_duration_cost.text):
				return
			
			Player.prestige_points -= int(box_skill_duration_cost.text)
			Player.skill_duration_level += 1
			Player.skill_duration += 1
			
		"DecreaseSkillCooldown":
			if Player.prestige_points < int(box_skill_cooldown_cost.text):
				return
			
			Player.prestige_points -= int(box_skill_cooldown_cost.text)
			Player.skill_cooldown_level += 1
			Player.skill_cooldown -= 1
			
		"IncreaseCriticalChance":
			if Player.prestige_points < int(box_critical_chance_cost.text):
				return
			
			Player.prestige_points -= int(box_critical_chance_cost.text)
			data["critical_chance"]["level"] += 1
			data["critical_chance"]["multiplier"] += 0.01
	
	update_label()


func update_label() -> void:
	box_damage_level.text = "Lv " + str(data["damage"]["level"])
	box_damage_current.text = "- Current: +" + str(data["damage"]["multiplier"] * 100) + "%"
	box_damage_cost.text = str(
		round(calculate_upgrade_cost(9, 1.25, data["damage"]["level"]))
		)
	
	box_gold_level.text = "Lv " + str(data["gold"]["level"])
	box_gold_current.text = "- Current: +" + str(data["gold"]["multiplier"] * 100) + "%"
	box_gold_cost.text = str(
		round(calculate_upgrade_cost(7, 1.20, data["gold"]["level"]))
		)
	
	box_critical_damage_level.text = "Lv " + str(data["critical_damage"]["level"])
	box_critica_damage_current.text = "- Current: +" + str(data["critical_damage"]["multiplier"] * 100) + "%"
	box_critical_damage_cost.text = str(
		round(calculate_upgrade_cost(10, 1.20, data["critical_damage"]["level"]))
		)
	
	box_raid_time_level.text = "Lv " + str(data["raid_time"]["level"])
	box_raid_time_current.text = "- Current: +" + str(data["raid_time"]["multiplier"]) + "s"
	box_raid_time_cost.text = str(
		round(calculate_upgrade_cost(15, 1.30, data["raid_time"]["level"]))
		)
	
	box_prestige_points_level.text = "Lv " + str(data["prestige_points"]["level"])
	box_prestige_points_current.text = "- Current: +" + str(data["prestige_points"]["multiplier"] * 100) + "%"
	box_prestige_points_cost.text = str(
		round(calculate_upgrade_cost(15, 1.25, data["prestige_points"]["level"]))
		)
	
	box_skill_duration_level.text = "Lv " + str(Player.skill_duration_level)
	box_skill_duration_current.text = "- Current: " + str(Player.skill_duration) + "s"
	box_skill_duration_cost.text = str(
		round(calculate_upgrade_cost(20, 1.35, Player.skill_duration_level))
		)
	
	box_skill_cooldown_level.text = "Lv " + str(Player.skill_cooldown_level)
	box_skill_cooldown_current.text = "- Current: " + str(Player.skill_cooldown) + "s"
	box_skill_cooldown_cost.text = str(
		round(calculate_upgrade_cost(20, 1.35, Player.skill_cooldown_level))
		)
	
	box_critical_chance_level.text = "Lv " + str(data["critical_chance"]["level"])
	box_critical_chance_current.text = "- Current: " + str(data["critical_chance"]["multiplier"] * 100) + "%"
	box_critical_chance_cost.text = str(
		round(calculate_upgrade_cost(75, 1.30, data["critical_chance"]["level"]))
		)


func calculate_upgrade_cost(upgrade_cost_base: int, scaling_factor: float, level: int) -> float:
	var upgrade_cost = upgrade_cost_base * pow(
		scaling_factor, level
	)
	
	return upgrade_cost


func _on_close_pressed() -> void:
	self.hide()
	$Background/ScrollContainer.set_deferred("scroll_vertical", 0)
