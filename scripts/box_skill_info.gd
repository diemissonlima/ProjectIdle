extends Control

@export_category("Objetos")
@export var label_skill_level: Label
@export var label_skill_name: Label
@export var label_skill_description: Label
@export var label_upgrade_cost: Label
@export var label_skill_points: Label

var skill_name: String = ""
var upgrade_cost: int = 0

var skill_level: Dictionary = {
	"2": 1, "3": 2, "4": 3, "5": 5, "6": 8, "7": 12, "8": 20, "9": 32, 
	"10": 52, "11": 84, "12": 136, "13": 220, "14": 356, "15": 576
}


# função chamada no script skills_management pela função "on_skill_info_button_pressed"
func get_skill_info(button: TextureButton) -> void:
	var skill_icon: String
	label_skill_points.text = "Skill Points: " + str(Player.skill_points)
	
	match button.name:
		"IncreaseAttack":
			skill_name = "Attack"
			skill_icon = "res://assets/skills/03.png"
			label_skill_level.text = "Lvl " + str(Player.attack_skill_level)
			label_skill_name.text = "Increase Attack Damage"
			label_skill_description.text = "Aumenta o Dano causado em " + str(Player.increase_attack_multiplier) + "x por " + str(Player.increase_attack_duration) + " segundos"
			upgrade_cost = skill_level[str(Player.attack_skill_level + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"IncreaseGold":
			skill_name = "Gold"
			skill_icon = "res://assets/skills/47.png"
			label_skill_level.text = "Lvl " + str(Player.gold_skill_level)
			label_skill_name.text = "Increase Drop Gold"
			label_skill_description.text = "Aumenta o drop de Gold em " + str(Player.increase_gold_multiplier) + "x por " + str(Player.increase_gold_duration) + " segundos"
			upgrade_cost = skill_level[str(Player.gold_skill_level + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"IncreaseCritical":
			skill_name = "Critical Chance"
			skill_icon = "res://assets/skills/07.png"
			label_skill_level.text = "Lvl " + str(Player.critical_skill_level)
			label_skill_name.text = "Increase Critical Chance"
			label_skill_description.text = "Aumenta a Chance de Crítico em " + str(Player.increase_critical_multiplier) + "x por " + str(Player.increase_critical_duration) + " segundos"
			upgrade_cost = skill_level[str(Player.critical_skill_level + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
	$SkillIcon.texture = load(skill_icon)


func increase_skill() -> void:
	label_skill_points.text = "Skill Points: " + str(Player.skill_points)
	
	match skill_name:
		"Attack":
			if Player.skill_points >= upgrade_cost:
				Player.skill_points -= upgrade_cost
				Player.attack_skill_level += 1
				Player.increase_attack_multiplier += 0.05
				Player.increase_attack_duration += 1
				
				label_skill_level.text = "Lvl " + str(Player.attack_skill_level)
				label_skill_name.text = "Increase Attack Damage"
				label_skill_description.text = "Aumenta o Dano causado em " + str(Player.increase_attack_multiplier) + "x por " + str(Player.increase_attack_duration) + " segundos"
				upgrade_cost = skill_level[str(Player.attack_skill_level + 1)]
				label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"Gold":
			if Player.skill_points >= upgrade_cost:
				Player.skill_points -= upgrade_cost
				Player.gold_skill_level += 1
				Player.increase_gold_multiplier += 0.05
				Player.increase_gold_duration += 1
				
				label_skill_level.text = "Lvl " + str(Player.gold_skill_level)
				label_skill_name.text = "Increase Drop Gold"
				label_skill_description.text = "Aumenta o drop de Gold em " + str(Player.increase_gold_multiplier) + "x por " + str(Player.increase_gold_duration) + " segundos"
				upgrade_cost = skill_level[str(Player.gold_skill_level + 1)]
				label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"Critical Chance":
			if Player.skill_points >= upgrade_cost:
				Player.skill_points -= upgrade_cost
				Player.critical_skill_level += 1
				Player.increase_critical_multiplier += 0.05
				Player.increase_critical_duration += 1
				
				label_skill_level.text = "Lvl " + str(Player.critical_skill_level)
				label_skill_name.text = "Increase Critical Chance"
				label_skill_description.text = "Aumenta a Chance de Crítico em " + str(Player.increase_critical_multiplier) + "x por " + str(Player.increase_attack_duration) + " segundos"
				upgrade_cost = skill_level[str(Player.critical_skill_level + 1)]
				label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
		
	label_skill_points.text = "Skill Points: " + str(Player.skill_points)


func _on_btn_close_pressed() -> void:
	self.hide()


func _on_increase_skill_pressed() -> void:
	increase_skill()
