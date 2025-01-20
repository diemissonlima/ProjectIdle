extends Node

var file_path: String = "res://save/save.dat"

var data_management: Dictionary = {
	"world": {
		"game_time": 0.0,
		"battle_time": 15,
		"current_stage": 1,
		"stage_progress": 1,
		"highest_stage": 1,
		"reset": 0,
		"exit_time": 0 # tempo que o jogo foi fechado (em segundos)
	},
	
	"player": {
		"ataque": 5.0,
		"default_damage": 5.0,
		"attack_speed": 0.5,
		"gold": 0,
		"skill_points": 0,
		"prestige_points": 0,
		"x_upgrade_ataque": 1,
		"x_upgrade_time": 1,
		"skills": {
			"increase_attack": {
				"level": 1,
				"multiplier": 1.25,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			},
			
			"increase_gold": {
				"level": 1,
				"multiplier": 1.5,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			},
			
			"increase_critical_damage": {
				"level": 1,
				"multiplier": 0.5,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			},
			
			"increase_critical": {
				"level": 1,
				"critical_chance": 0.05,
				"multiplier": 2.0,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			},
			
			"increase_attackspeed": {
				"level": 1,
				"multiplier": 0.25,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			}
		}
	},
	
	"statistics": {
		"kills": 0,
		"gold_gain": 0
	},
	
	"raids": {
		"raid_damage": {
			"level": 1,
			"hp": 1500,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_gold": {
			"level": 1,
			"hp": 1500,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_critical": {
			"level": 1,
			"hp": 1500,
			"multiplier": 0.0,
			"time_left": 0.0
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


func delete_savegame() -> void:
	if FileAccess.file_exists(file_path):
		var dir = DirAccess.open("res://")
		if dir:
			dir.remove_absolute(file_path)
			reset_savegame()
			Player.load_data()
			World.load_data()
	else:
		return


func reset_savegame() -> void:
	data_management = {
	"world": {
		"game_time": 0.0,
		"battle_time": 15,
		"current_stage": 1,
		"stage_progress": 1,
		"highest_stage": 1,
		"reset": 0,
		"exit_time": 0 # tempo que o jogo foi fechado (em segundos)
	},
	
	"player": {
		"ataque": 5.0,
		"default_damage": 5.0,
		"attack_speed": 0.5,
		"gold": 0,
		"skill_points": 0,
		"prestige_points": 0,
		"x_upgrade_ataque": 1,
		"x_upgrade_time": 1,
		"skills": {
			"increase_attack": {
				"level": 1,
				"multiplier": 1.25,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			},
			
			"increase_gold": {
				"level": 1,
				"multiplier": 1.5,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			},
			
			"increase_critical_damage": {
				"level": 1,
				"multiplier": 0.5,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			},
			
			"increase_critical": {
				"level": 1,
				"critical_chance": 0.05,
				"multiplier": 2.0,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			},
			
			"increase_attackspeed": {
				"level": 1,
				"multiplier": 0.25,
				"duration": 30.0,
				"cooldown": 150.0,
				"aux_cooldown": 0.0,
				"aux_duration": 0.0
			}
		}
	},
	
	"statistics": {
		"kills": 0,
		"gold_gain": 0
	},
	
	"raids": {
		"raid_damage": {
			"level": 1,
			"hp": 1500,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_gold": {
			"level": 1,
			"hp": 1500,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_critical": {
			"level": 1,
			"hp": 1500,
			"multiplier": 0.0,
			"time_left": 0.0
		}
	}
}


func _notification(what: int) -> void:
	if what == 1006:
		get_tree().quit()
		save_data()
