extends Node

var file_path: String = "res://save/save.dat"

var data_management: Dictionary = {
	"world": {
		"game_time": 0.0,
		"battle_time": 5,
		"current_stage": 1,
		"highest_stage": 1,
	},
	
	"player": {
		"ataque": 2.0,
		"attack_speed": 1.0,
		"gold": 0,
		"x_upgrade_ataque": 1,
		"x_upgrade_time": 1,
		"skills": {
			"increase_attack": {
				"multiplier": 1.5,
				"duration": 30.0,
				"cooldown": 150.0
			},
			
			"increase_gold": {
				"multiplier": 1.5,
				"duration": 30.0,
				"cooldown": 150.0
			},
			
			"increase_critical": {
				"critical_chance": 0.05,
				"multiplier": 2.0,
				"duration": 30.0,
				"cooldown": 150.0
			}
		}
	}
}


func save_data() -> void:
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	
	file.store_string(JSON.stringify(data_management))
	file.close()


func load_data() -> void:
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var save = JSON.parse_string(file.get_as_text())
		data_management = save
		
		file.close()

func _notification(what: int) -> void:
	if what == 1006:
		get_tree().quit()
		save_data()
