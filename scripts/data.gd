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
		"ataque": 10.0,
		"default_damage": 10.0,
		"attack_speed": 0.5,
		"gold": 0,
		"skill_points": 0,
		"prestige_points": 0,
		"x_upgrade_ataque": 1,
		"x_upgrade_time": 1,
		"skills": {
			"increase_attack": {
				"level": 1,
				"multiplier": 0.5,
				"duration": 0.0,
				"cooldown": 0.0,
			},
			
			"increase_gold": {
				"level": 1,
				"multiplier": 0.5,
				"duration": 0.0,
				"cooldown": 0.0,
			},
			
			"increase_critical_damage": {
				"level": 1,
				"multiplier": 0.5,
				"duration": 0.0,
				"cooldown": 0.0,
			},
			
			"increase_attackspeed": {
				"level": 1,
				"multiplier": 0.25,
				"duration": 0.0,
				"cooldown": 0.0,
			}
		}
	},
	
	"statistics": {
		"kills": 0,
		"gold_gain": 0,
		"monster": {
			"enemy_1": 0,
			"enemy_2": 0,
			"enemy_3": 0,
			"enemy_4": 0,
			"enemy_5": 0,
			"enemy_6": 0,
			"enemy_7": 0,
			"enemy_8": 0,
			"enemy_9": 0,
			"enemy_10": 0,
			"enemy_11": 0,
			"enemy_12": 0,
			"enemy_13": 0,
			"enemy_14": 0,
			"enemy_15": 0,
			"enemy_16": 0,
			"enemy_17": 0,
			"enemy_18": 0,
			"enemy_19": 0,
			"enemy_20": 0,
			"enemy_21": 0,
			"enemy_22": 0,
			"enemy_23": 0,
			"enemy_24": 0,
			"enemy_25": 0,
			"enemy_26": 0,
			"enemy_27": 0,
			"enemy_28": 0,
			"enemy_29": 0,
		}
	},
	
	"raids": {
		"raid_damage": {
			"level": 1,
			"hp": 5000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_gold": {
			"level": 1,
			"hp": 3500,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_critical": {
			"level": 1,
			"hp": 3500,
			"multiplier": 0.0,
			"time_left": 0.0
		}
	},
	
	"upgrades": {
		"damage": {
			"level": 0,
			"multiplier": 0.0
		},
		
		"gold": {
			"level": 0,
			"multiplier": 0.0
		},
		
		"critical_damage": {
			"level": 0,
			"multiplier": 0.0
		},
		
		"critical_chance": {
			"level": 0,
			"multiplier": 0.0
		},
		
		"raid_time": {
			"level": 0,
			"multiplier": 0
		},
		
		"prestige_points": {
			"level": 0,
			"multiplier": 0
		},
		
		"skill_duration": {
			"level": 0,
			"multiplier": 45
		},
		
		"skill_cooldown": {
			"level": 0,
			"multiplier": 180
		}
	},
	
	"equipments": {
		"weapon": {
			"slot1": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"damage": 0,
					"critical_damage": 0,
				},
				"progress": 0
			}
		},
		
		"shield": {
			"slot1": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"level": 1,
				"atributtes": {
					"gold": 0,
					"prestige_points": 0
				},
				"progress": 0
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
				"multiplier": 0.5,
				"duration": 0.0,
				"cooldown": 0.0,
			},
			
			"increase_gold": {
				"level": 1,
				"multiplier": 0.5,
				"duration": 0.0,
				"cooldown": 0.0,
			},
			
			"increase_critical_damage": {
				"level": 1,
				"multiplier": 0.5,
				"duration": 0.0,
				"cooldown": 0.0,
			},
			
			"increase_attackspeed": {
				"level": 1,
				"multiplier": 0.25,
				"duration": 0.0,
				"cooldown": 0.0,
			}
		}
	},
	
	"statistics": {
		"kills": 0,
		"gold_gain": 0,
		"monster": {
			"enemy_1": 0,
			"enemy_2": 0,
			"enemy_3": 0,
			"enemy_4": 0,
			"enemy_5": 0,
			"enemy_6": 0,
			"enemy_7": 0,
			"enemy_8": 0,
			"enemy_9": 0,
			"enemy_10": 0,
			"enemy_11": 0,
			"enemy_12": 0,
			"enemy_13": 0,
			"enemy_14": 0,
			"enemy_15": 0,
			"enemy_16": 0,
			"enemy_17": 0,
			"enemy_18": 0,
			"enemy_19": 0,
			"enemy_20": 0,
			"enemy_21": 0,
			"enemy_22": 0,
			"enemy_23": 0,
			"enemy_24": 0,
			"enemy_25": 0,
			"enemy_26": 0,
			"enemy_27": 0,
			"enemy_28": 0,
			"enemy_29": 0,
		}
	},
	
	"raids": {
		"raid_damage": {
			"level": 1,
			"hp": 5000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_gold": {
			"level": 1,
			"hp": 3500,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_critical": {
			"level": 1,
			"hp": 3500,
			"multiplier": 0.0,
			"time_left": 0.0
		}
	},
	
	"upgrades": {
		"damage": {
			"level": 0,
			"multiplier": 0.0
		},
		
		"gold": {
			"level": 0,
			"multiplier": 0.0
		},
		
		"critical_damage": {
			"level": 0,
			"multiplier": 0.0
		},
		
		"critical_chance": {
			"level": 0,
			"multiplier": 0.0
		},
		
		"raid_time": {
			"level": 0,
			"multiplier": 0
		},
		
		"prestige_points": {
			"level": 0,
			"multiplier": 0
		},
		
		"skill_duration": {
			"level": 0,
			"multiplier": 45
		},
		
		"skill_cooldown": {
			"level": 0,
			"multiplier": 180
		}
	}
}


func _notification(what: int) -> void:
	if what == 1006:
		get_tree().quit()
		save_data()
