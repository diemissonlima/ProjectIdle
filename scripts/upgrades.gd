extends Control

@export_category("Boxes")
@export var box_damage: TextureRect
@export var box_gold: TextureRect
@export var box_critical_damage: TextureRect
@export var box_raid_time: TextureRect
@export var box_prestige_points: TextureRect
@export var box_skill_duration: TextureRect
@export var box_skill_cooldown: TextureRect

@export_category("Tabs")
@export var tab_1: TextureButton
@export var tab_2: TextureButton

var data: Dictionary = Data.data_management["upgrades"]


func _ready() -> void:
	connect_buttons()


func connect_buttons() -> void:
	for button in get_tree().get_nodes_in_group("upgrades"):
		button.pressed.connect(on_button_pressed.bind(button.name))


func on_button_pressed(button_name: String) -> void:
	match button_name:
		"IncreaseDamage":
			if Player.prestige_points < int(box_damage.get_node("IncreaseDamage/Cost").text):
				return
			
			Player.prestige_points -= int(box_damage.get_node("IncreaseDamage/Cost").text)
			data["damage"]["level"] += 1
			data["damage"]["multiplier"] += 0.15
			
		"IncreaseGold":
			if Player.prestige_points < int(box_gold.get_node("IncreaseGold/Cost").text):
				return
			
			Player.prestige_points -= int(box_gold.get_node("IncreaseGold/Cost").text)
			data["gold"]["level"] += 1
			data["gold"]["multiplier"] += 0.25
			
		"IncreaseCriticalDamage":
			if Player.prestige_points < int(box_critical_damage.get_node("IncreaseCriticalDamage/Cost").text):
				return
			
			Player.prestige_points -= int(box_critical_damage.get_node("IncreaseCriticalDamage/Cost").text)
			data["critical_damage"]["level"] += 1
			data["critical_damage"]["multiplier"] += 0.05
			
		"IncreaseRaidTime":
			if Player.prestige_points < int(box_raid_time.get_node("IncreaseRaidTime/Cost").text):
				return
			
			Player.prestige_points -= int(box_raid_time.get_node("IncreaseRaidTime/Cost").text)
			data["raid_time"]["level"] += 1
			data["raid_time"]["multiplier"] += 1
		
		"IncreasePrestigePoints":
			if Player.prestige_points < int(box_prestige_points.get_node("IncreasePrestigePoints/Cost").text):
				return
			
			Player.prestige_points -= int(box_prestige_points.get_node("IncreasePrestigePoints/Cost").text)
			data["prestige_points"]["level"] += 1
			data["prestige_points"]["multiplier"] += 0.10
		
		"IncreaseSkillDuration":
			if Player.prestige_points < int(box_skill_duration.get_node("IncreaseSkillDuration/Cost").text):
				return
			
			Player.prestige_points -= int(box_skill_duration.get_node("IncreaseSkillDuration/Cost").text)
			data["skill_duration"]["level"] += 1
			data["skill_duration"]["multiplier"] += 1
			
		"DecreaseSkillCooldown":
			if Player.prestige_points < int(box_skill_cooldown.get_node("DecreaseSkillCooldown/Cost").text):
				return
			
			Player.prestige_points -= int(box_skill_cooldown.get_node("DecreaseSkillCooldown/Cost").text)
			data["skill_cooldown"]["level"] += 1
			data["skill_cooldown"]["multiplier"] += 1
	
	update_label()


func update_label() -> void:
	box_damage.get_node("BGIcon/Level").text = "Lv " + str(data["damage"]["level"])
	box_damage.get_node("BGDescription/VBoxContainer/Current").text = "- Current: +" + str(data["damage"]["multiplier"] * 100) + "%"
	box_damage.get_node("IncreaseDamage/Cost").text = str(round(
		calculate_upgrade_cost(7, 1.25, data["damage"]["level"])))
	
	box_gold.get_node("BGIcon/Level").text = "Lv " + str(data["gold"]["level"])
	box_gold.get_node("BGDescription/VBoxContainer/Current").text = "- Current: +" + str(data["gold"]["multiplier"] * 100) + "%"
	box_gold.get_node("IncreaseGold/Cost").text = str(round(
		calculate_upgrade_cost(5, 1.20, data["gold"]["level"])
	))
	
	box_critical_damage.get_node("BGIcon/Level").text = "Lv " + str(data["critical_damage"]["level"])
	box_critical_damage.get_node("BGDescription/VBoxContainer/Current").text = "- Current: +" + str(data["critical_damage"]["multiplier"] * 100) + "%"
	box_critical_damage.get_node("IncreaseCriticalDamage/Cost").text = str(round(
		calculate_upgrade_cost(10, 1.20, data["critical_damage"]["level"])
	))
	
	box_raid_time.get_node("BGIcon/Level").text = "Lv " + str(data["raid_time"]["level"])
	box_raid_time.get_node("BGDescription/VBoxContainer/Current").text = "- Current: +" + str(data["raid_time"]["multiplier"]) + "s"
	box_raid_time.get_node("IncreaseRaidTime/Cost").text = str(round(
		calculate_upgrade_cost(15, 1.30, data["raid_time"]["level"])
	))
	
	box_prestige_points.get_node("BGIcon/Level").text = "Lv " + str(data["prestige_points"]["level"])
	box_prestige_points.get_node("BGDescription/VBoxContainer/Current").text = "- Current: +" + str(data["prestige_points"]["multiplier"] * 100) + "%"
	box_prestige_points.get_node("IncreasePrestigePoints/Cost").text = str(round(
		calculate_upgrade_cost(15, 1.25, data["prestige_points"]["level"])
	))
	
	box_skill_duration.get_node("BGIcon/Level").text = "Lv " + str(data["skill_duration"]["level"])
	box_skill_duration.get_node("BGDescription/VBoxContainer/Current").text = "- Current: +" + str(data["skill_duration"]["multiplier"]) + "s"
	box_skill_duration.get_node("IncreaseSkillDuration/Cost").text = str(round(
		calculate_upgrade_cost(20, 1.35, data["skill_duration"]["level"])
	))
	
	box_skill_cooldown.get_node("BGIcon/Level").text = "Lv " + str(data["skill_cooldown"]["level"])
	box_skill_cooldown.get_node("BGDescription/VBoxContainer/Current").text = "- Current: -" + str(data["skill_cooldown"]["multiplier"]) + "s"
	box_skill_cooldown.get_node("DecreaseSkillCooldown/Cost").text = str(round(
		calculate_upgrade_cost(20, 1.35, data["skill_cooldown"]["level"])
	))


func calculate_upgrade_cost(upgrade_cost_base: int, scaling_factor: float, level: int) -> float:
	var upgrade_cost = upgrade_cost_base * pow(
		scaling_factor, level
	)
	
	return upgrade_cost


func _on_close_pressed() -> void:
	self.hide()
	$Background/VBoxContainer2.hide()
	$Background/VBoxContainer.show()


func _on_tab_1_pressed() -> void:
	$Background/VBoxContainer2.hide()
	$Background/VBoxContainer.show()


func _on_tab_2_pressed() -> void:
	$Background/VBoxContainer2.show()
	$Background/VBoxContainer.hide()
