extends Control

@export_category("Objetos")
@export var label_skill_level: Label
@export var label_skill_name: Label
@export var label_skill_description: Label
@export var label_upgrade_cost: Label
@export var label_skill_points: Label

var skill_name: String = ""
var upgrade_cost: int = 10


# função chamada no script skills_management pela função "on_skill_info_button_pressed"
func get_skill_info(button: TextureButton) -> void:
	var skill_icon: String
	label_skill_points.text = str(Player.skill_points)
	
	match button.name:
		"IncreaseAttack":
			skill_name = "Attack"
			skill_icon = "res://assets/skills/03.png"
			label_skill_level.text = "Lvl " + str(Player.attack_skill_level)
			label_skill_name.text = "Increase Attack Damage"
			
			label_skill_description.text = "Aumenta o Dano causado em " \
			+ str(Player.increase_attack_multiplier * 100) + "% por " \
			+ str(Player.skill_duration) + " segundos.
			Cooldown de " + str(Player.skill_cooldown) + " segundos"
			
		"IncreaseGold":
			skill_name = "Gold"
			skill_icon = "res://assets/skills/47.png"
			label_skill_level.text = "Lvl " + str(Player.gold_skill_level)
			label_skill_name.text = "Increase Drop Gold"
			
			label_skill_description.text = "Aumenta o drop de Gold em " \
			+ str(Player.increase_gold_multiplier * 100) + "% por " \
			+ str(Player.skill_duration) + " segundos 
			Cooldow de " + str(Player.skill_cooldown) + " segundos."
		
		"IncreaseCriticalDamage":
			skill_name = "Critical Damage"
			skill_icon = "res://assets/skills/07.png"
			label_skill_level.text = "Lvl " + str(Player.criticaldamage_skill_level)
			label_skill_name.text = "Increase Critical Damage"
			
			label_skill_description.text = "Aumenta o dano crítico em " \
			+ str(Player.increase_criticaldamage_multiplier * 100) + "% por " \
			+ str(Player.skill_duration) + " segundos 
			Cooldown de " + str(Player.skill_cooldown) + " segundos."
		
		"IncreaseAttackSpeed":
			skill_name = "Attack Speed"
			skill_icon = "res://assets/skills/08.png"
			label_skill_level.text = "Lvl " + str(Player.attackspeed_skill_level)
			label_skill_name.text = "Increase Attack Speed"
			
			label_skill_description.text = "Diminui a Velocidade de Ataque em " \
			+ str(Player.increase_attackspeed_multiplier) + "s por " \
			+ str(Player.skill_duration) + " segundos 
			Cooldown de " + str(Player.skill_cooldown) + " segundos."
			
	$SkillIcon.texture = load(skill_icon)


func increase_skill() -> void:
	label_skill_points.text = str(Player.skill_points)
	
	if Player.skill_points < upgrade_cost:
		return
	
	match skill_name:
		"Attack":
			Player.skill_points -= upgrade_cost
			Player.attack_skill_level += 1
			Player.increase_attack_multiplier += 0.50
			
			label_skill_level.text = "Lvl " + str(Player.attack_skill_level)
			label_skill_name.text = "Increase Attack Damage"
			
			label_skill_description.text = "Aumenta o Dano causado em " \
			+ str(Player.increase_attack_multiplier * 100) + "% por " \
			+ str(Player.skill_duration) + " segundos 
			Cooldown de " + str(Player.skill_cooldown) + " segundos."
			
		"Gold":
			Player.skill_points -= upgrade_cost
			Player.gold_skill_level += 1
			Player.increase_gold_multiplier += 0.50
			
			label_skill_level.text = "Lvl " + str(Player.gold_skill_level)
			label_skill_name.text = "Increase Drop Gold"
			
			label_skill_description.text = "Aumenta o drop de Gold em " \
			+ str(Player.increase_gold_multiplier * 100) + "% por " \
			+ str(Player.skill_duration) + " segundos 
			Cooldow de " + str(Player.skill_cooldown) + " segundos."
		
		"Critical Damage":
			Player.skill_points -= upgrade_cost
			Player.criticaldamage_skill_level += 1
			Player.increase_criticaldamage_multiplier += 0.30
			
			label_skill_level.text = "Lvl " + str(Player.criticaldamage_skill_level)
			label_skill_name.text = "Increase Critical Damage"
			
			label_skill_description.text = "Aumenta o dano crítico em " \
			+ str(Player.increase_criticaldamage_multiplier * 100) + "% por " \
			+ str(Player.skill_duration) + " segundos 
			Cooldown de " + str(Player.skill_cooldown) + " segundos."
		
		"Attack Speed":
			Player.skill_points -= upgrade_cost
			Player.attackspeed_skill_level += 1
			
			label_skill_level.text = "Lvl " + str(Player.attackspeed_skill_level)
			label_skill_name.text = "Increase Attack Speed"
			
			label_skill_description.text = "Diminui a Velocidade de Ataque em " \
			+ str(Player.increase_attackspeed_multiplier) + "s por " \
			+ str(Player.skill_duration) + " segundos 
			Cooldown de " + str(Player.skill_cooldown) + " segundos."
		
	label_skill_points.text = str(Player.skill_points)


func _on_btn_close_pressed() -> void:
	self.hide()


func _on_increase_skill_pressed() -> void:
	increase_skill()
