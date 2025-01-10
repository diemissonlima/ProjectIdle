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
	"2": 1, "3": 3, "4": 5, "5": 7, "6": 9, "7": 11, "8": 13, "9": 15, 
	"10": 17, "11": 19, "12": 21, "13": 23, "14": 25, "15": 27, "16": 29, 
	"17": 31, "18": 33, "19": 35, "20": 37, "21": 39, "22": 41, "23": 43, 
	"24": 45, "25": 47, "26": 49, "27": 51, "28": 53, "29": 55, 
	"30": 57, "31": 59, "32": 61, "33": 63, "34": 65, "35": 67,
	"36": 69, "37": 71, "38": 73, "39": 75, "40": 77, "41": 79, 
	"42": 81, "43": 83, "44": 85, "45": 87, "46": 89, 
	"47": 91, "48": 93, "49": 95, "50": 97, "51": 99, 
	#"52": 70065, "53": 87581, "54": 109476, "55": 136846, "56": 171057, 
	#"57": 213821, "58": 267276, "59": 334096, "60": 417619, "61": 522024, 
	#"62": 652530, "63": 815663, "64": 1019579, "65": 1274474, "66": 1593092, 
	#"67": 1991365, "68": 2489206, "69": 3111508, "70": 3889385, "71": 4861731, 
	#"72": 6077163, "73": 7596454, "74": 9495568, "75": 11869460, 
	#"76": 14836825, "77": 18546031, "78": 23182538, "79": 28978173, 
	#"80": 36222716, "81": 45278395, "82": 56597994, "83": 70747493, 
	#"84": 88434366, "85": 110542958, "86": 138178697, "87": 172723371, 
	#"88": 215904214, "89": 269880267, "90": 337350334, "91": 421687918, 
	#"92": 527109897, "93": 658887371, "94": 823609214, "95": 1029511518, 
	#"96": 1286889397, "97": 1608611747, "98": 2010764683, "99": 2513455854, 
	#"100": 3141819818
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
			
			label_skill_description.text = "Aumenta o Dano causado em " \
			+ str(Player.increase_attack_multiplier) + "x por " \
			+ str(Player.increase_attack_duration) + " segundos.
			Cooldown de " + str(Player.increase_attack_cooldown) + " segundos"
			
			upgrade_cost = skill_level[str(Player.attack_skill_level + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"IncreaseGold":
			skill_name = "Gold"
			skill_icon = "res://assets/skills/47.png"
			label_skill_level.text = "Lvl " + str(Player.gold_skill_level)
			label_skill_name.text = "Increase Drop Gold"
			
			label_skill_description.text = "Aumenta o drop de Gold em " \
			+ str(Player.increase_gold_multiplier) + "x por " \
			+ str(Player.increase_gold_duration) + " segundos 
			Cooldow de " + str(Player.increase_gold_cooldown) + " segundos."
			
			upgrade_cost = skill_level[str(Player.gold_skill_level + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"IncreaseCritical":
			skill_name = "Critical Chance"
			skill_icon = "res://assets/skills/07.png"
			label_skill_level.text = "Lvl " + str(Player.critical_skill_level)
			label_skill_name.text = "Increase Critical Chance"
			
			label_skill_description.text = "Aumenta a Chance de Crítico em " \
			+ str(Player.increase_critical_multiplier) + "x por " \
			+ str(Player.increase_critical_duration) + " segundos 
			Cooldown de " + str(Player.increase_critical_cooldown) + " segundos."
			
			upgrade_cost = skill_level[str(Player.critical_skill_level + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
		
		"IncreaseAttackSpeed":
			skill_name = "Attack Speed"
			skill_icon = "res://assets/skills/08.png"
			label_skill_level.text = "Lvl " + str(Player.attackspeed_skill_level)
			label_skill_name.text = "Increase Attack Speed"
			
			label_skill_description.text = "Diminui a Velocidade de Ataque em " \
			+ str(Player.increase_attackspeed_multiplier) + "s por " \
			+ str(Player.increase_attackspeed_duration) + " segundos 
			Cooldown de " + str(Player.increase_attackspeed_cooldown) + " segundos."
			
			upgrade_cost = skill_level[str(Player.attackspeed_skill_level + 1)]
			label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
	$SkillIcon.texture = load(skill_icon)


func increase_skill() -> void:
	label_skill_points.text = "Skill Points: " + str(Player.skill_points)
	
	if Player.skill_points < upgrade_cost:
		return
	
	match skill_name:
		"Attack":
				Player.skill_points -= upgrade_cost
				Player.attack_skill_level += 1
				Player.increase_attack_multiplier += 0.05
				Player.increase_attack_duration += 1
				Player.increase_attack_cooldown -= 1
				
				label_skill_level.text = "Lvl " + str(Player.attack_skill_level)
				label_skill_name.text = "Increase Attack Damage"
				
				label_skill_description.text = "Aumenta o Dano causado em " \
				+ str(Player.increase_attack_multiplier) + "x por " \
				+ str(Player.increase_attack_duration) + " segundos 
				Cooldown de " + str(Player.increase_attack_cooldown) + " segundos."
				
				upgrade_cost = skill_level[str(Player.attack_skill_level + 1)]
				label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"Gold":
				Player.skill_points -= upgrade_cost
				Player.gold_skill_level += 1
				Player.increase_gold_multiplier += 0.05
				Player.increase_gold_duration += 1
				Player.increase_gold_cooldown -= 1
				
				label_skill_level.text = "Lvl " + str(Player.gold_skill_level)
				label_skill_name.text = "Increase Drop Gold"
				
				label_skill_description.text = "Aumenta o drop de Gold em " \
				+ str(Player.increase_gold_multiplier) + "x por " \
				+ str(Player.increase_gold_duration) + " segundos 
				Cooldow de " + str(Player.increase_gold_cooldown) + " segundos."
				
				upgrade_cost = skill_level[str(Player.gold_skill_level + 1)]
				label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
			
		"Critical Chance":
				Player.skill_points -= upgrade_cost
				Player.critical_skill_level += 1
				Player.increase_critical_multiplier += 0.05
				Player.increase_critical_duration += 1
				Player.increase_critical_cooldown -= 1
				
				label_skill_level.text = "Lvl " + str(Player.critical_skill_level)
				label_skill_name.text = "Increase Critical Chance"
				
				label_skill_description.text = "Aumenta a Chance de Crítico em " \
				+ str(Player.increase_critical_multiplier) + "x por " \
				+ str(Player.increase_critical_duration) + " segundos 
				Cooldown de " + str(Player.increase_critical_cooldown) + " segundos."
				
				upgrade_cost = skill_level[str(Player.critical_skill_level + 1)]
				label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
		
		"Attack Speed":
				Player.skill_points -= upgrade_cost
				Player.attackspeed_skill_level += 1
				Player.increase_attackspeed_duration += 1
				Player.increase_attackspeed_cooldown -= 1
				
				label_skill_level.text = "Lvl " + str(Player.attackspeed_skill_level)
				label_skill_name.text = "Increase Attack Speed"
				
				label_skill_description.text = "Diminui a Velocidade de Ataque em " \
				+ str(Player.increase_attackspeed_multiplier) + "s por " \
				+ str(Player.increase_attackspeed_duration) + " segundos 
				Cooldown de " + str(Player.increase_attackspeed_cooldown) + " segundos."
				
				upgrade_cost = skill_level[str(Player.attackspeed_skill_level + 1)]
				label_upgrade_cost.text = "Custo " + str(upgrade_cost) + " Skill Point(s)"
		
	label_skill_points.text = "Skill Points: " + str(Player.skill_points)


func _on_btn_close_pressed() -> void:
	self.hide()


func _on_increase_skill_pressed() -> void:
	increase_skill()
