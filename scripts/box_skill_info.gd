extends Control

@export_category("Objetos")
@export var label_skill_name: Label
@export var label_skill_description: Label
@export var label_upgrade_cost: Label

var skill_name: String = ""

var skill_level_dict: Dictionary = {
	"2": 1, "3": 2, "4": 3, "5": 5, 
	"6": 8, "7": 12, "8": 20, "9": 32, 
	"10": 52
}

var data = Data.data_management["player"]["skills"]
var upgrade_cost: int = 0


func get_skill_info(button: TextureButton) -> void:
	var skill_icon: String
	
	match button.name:
		"IncreaseAttack":
			skill_name = "Attack"
			skill_icon = "res://assets/skills/03.png"
			label_skill_name.text = "Increase Attack Damage Lvl " + str(data["increase_attack"]["level"])
			label_skill_description.text = "Aumenta o Dano causado em " + str(data["increase_attack"]["multiplier"]) + "x por 30 segundos"
			upgrade_cost = skill_level_dict[str(data["increase_attack"]["level"] + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"IncreaseGold":
			skill_name = "Gold"
			skill_icon = "res://assets/skills/47.png"
			label_skill_name.text = "Increase Drop Gold Lvl " + str(data["increase_gold"]["level"])
			label_skill_description.text = "Aumenta o drop de Gold em " + str(data["increase_gold"]["multiplier"]) + "x por 30 segundos"
			upgrade_cost = skill_level_dict[str(data["increase_gold"]["level"] + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"IncreaseCritical":
			skill_name = "Critical Chance"
			skill_icon = "res://assets/skills/07.png"
			label_skill_name.text = "Increase Critical Chance Lvl " + str(data["increase_critical"]["level"])
			label_skill_description.text = "Aumenta a Chance de Crítico em " + str(data["increase_critical"]["multiplier"]) + "x por 30 segundos"
			upgrade_cost = skill_level_dict[str(data["increase_critical"]["level"] + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
	$SkillIcon.texture = load(skill_icon)


func increase_skill() -> void:
	var skill_points: int = Player.skill_points
	
	match skill_name:
		"Attack":
			upgrade_cost = skill_level_dict[str(data["increase_attack"]["level"] + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			if skill_points >= upgrade_cost:
				Player.increase_attack_duration += 1
			
		"Gold":
			upgrade_cost = skill_level_dict[str(data["increase_gold"]["level"] + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			if skill_points >= upgrade_cost:
				Player.increase_gold_duration += 1
			
		"Critical Chance":
			upgrade_cost = skill_level_dict[str(data["increase_critical"]["level"] + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			if skill_points >= upgrade_cost:
				Player.increase_critical_duration += 1


func _on_btn_close_pressed() -> void:
	self.hide()


func _on_increase_skill_pressed() -> void:
	increase_skill()
