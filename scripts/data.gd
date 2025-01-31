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
		"points": 0,
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
			"hp": 15000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_gold": {
			"level": 1,
			"hp": 12500,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_critical": {
			"level": 1,
			"hp": 10000,
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
				"path": "res://assets/items/sword_01a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.25,
					"critical_damage": 0.25,
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.26,
					"critical_damage": 0.26,
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.27,
					"critical_damage": 0.27,
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.28,
					"critical_damage": 0.28,
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01e.png",
				"level": 1,
				"atributtes": {
					"damage": 0.29,
					"critical_damage": 0.29,
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.35,
					"critical_damage": 0.35,
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.36,
					"critical_damage": 0.36,
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.37,
					"critical_damage": 0.37,
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.38,
					"critical_damage": 0.38,
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02e.png",
				"level": 1,
				"atributtes": {
					"damage": 0.39,
					"critical_damage": 0.39,
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.50,
					"critical_damage": 0.50,
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.55,
					"critical_damage": 0.55,
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.75,
					"critical_damage": 0.75,
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.80,
					"critical_damage": 0.80,
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03e.png",
				"level": 1,
				"atributtes": {
					"damage": 1.5,
					"critical_damage": 1.5,
				},
				"progress": 0
			}
		},
		
		"shield": {
			"slot1": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.25,
					"prestige_points": 0.25
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.26,
					"prestige_points": 0.26
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.27,
					"prestige_points": 0.27
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.28,
					"prestige_points": 0.28
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.29,
					"prestige_points": 0.29
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.35,
					"prestige_points": 0.35
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.36,
					"prestige_points": 0.36
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.37,
					"prestige_points": 0.37
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.38,
					"prestige_points": 0.38
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.39,
					"prestige_points": 0.39
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.50,
					"prestige_points": 0.50
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.55,
					"prestige_points": 0.55
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.75,
					"prestige_points": 0.75
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.80,
					"prestige_points": 0.80
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03e.png",
				"level": 1,
				"atributtes": {
					"gold": 1.5,
					"prestige_points": 1.5
				},
				"progress": 0
			}
		},
		
		"ring": {
			"slot1": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.25,
					"prestige_points": 0.25
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.26,
					"prestige_points": 0.26
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.27,
					"prestige_points": 0.27
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.28,
					"prestige_points": 0.28
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.29,
					"prestige_points": 0.29
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.35,
					"prestige_points": 0.35
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.36,
					"prestige_points": 0.36
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.37,
					"prestige_points": 0.37
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.38,
					"prestige_points": 0.38
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.39,
					"prestige_points": 0.39
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.50,
					"prestige_points": 0.50
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.55,
					"prestige_points": 0.55
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.75,
					"prestige_points": 0.75
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.80,
					"prestige_points": 0.80
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 1.5,
					"prestige_points": 1.5
				},
				"progress": 0
			}
		},
		
		"necklace": {
			"slot1": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.25,
					"damage": 0.25
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.26,
					"damage": 0.26
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.27,
					"damage": 0.27
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.28,
					"damage": 0.28
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.29,
					"damage": 0.29
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.35,
					"damage": 0.35
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.36,
					"damage": 0.36
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.37,
					"damage": 0.37
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.38,
					"damage": 0.38
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.39,
					"damage": 0.39
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.50,
					"damage": 0.50
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.55,
					"damage": 0.55
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.75,
					"damage": 0.75
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.80,
					"damage": 0.80
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03e.png",
				"level": 1,
				"atributtes": {
					"gold": 1.5,
					"damage": 1.5
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
			"hp": 10000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_gold": {
			"level": 1,
			"hp": 5000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_critical": {
			"level": 1,
			"hp": 7500,
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
				"path": "res://assets/items/sword_01a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.10,
					"critical_damage": 0.10,
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.11,
					"critical_damage": 0.11,
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.12,
					"critical_damage": 0.12,
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.13,
					"critical_damage": 0.13,
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01e.png",
				"level": 1,
				"atributtes": {
					"damage": 0.14,
					"critical_damage": 0.14,
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.20,
					"critical_damage": 0.20,
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.21,
					"critical_damage": 0.21,
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.22,
					"critical_damage": 0.22,
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.23,
					"critical_damage": 0.23,
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02e.png",
				"level": 1,
				"atributtes": {
					"damage": 0.24,
					"critical_damage": 0.24,
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.35,
					"critical_damage": 0.35,
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.40,
					"critical_damage": 0.40,
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.50,
					"critical_damage": 0.50,
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.60,
					"critical_damage": 0.60,
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03e.png",
				"level": 1,
				"atributtes": {
					"damage": 1.0,
					"critical_damage": 1.0,
				},
				"progress": 0
			}
		},
		
		"shield": {
			"slot1": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.10,
					"prestige_points": 0.10
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.11,
					"prestige_points": 0.11
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.12,
					"prestige_points": 0.12
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.13,
					"prestige_points": 0.13
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.14,
					"prestige_points": 0.14
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.20,
					"prestige_points": 0.20
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.21,
					"prestige_points": 0.21
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.22,
					"prestige_points": 0.22
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.23,
					"prestige_points": 0.23
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.24,
					"prestige_points": 0.24
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.35,
					"prestige_points": 0.35
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.40,
					"prestige_points": 0.40
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.50,
					"prestige_points": 0.50
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.60,
					"prestige_points": 0.60
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03e.png",
				"level": 1,
				"atributtes": {
					"gold": 1.0,
					"prestige_points": 1.0
				},
				"progress": 0
			}
		},
		
		"ring": {
			"slot1": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.10,
					"prestige_points": 0.10
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.11,
					"prestige_points": 0.11
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.12,
					"prestige_points": 0.12
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.13,
					"prestige_points": 0.13
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.14,
					"prestige_points": 0.14
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.20,
					"prestige_points": 0.20
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.21,
					"prestige_points": 0.21
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.22,
					"prestige_points": 0.22
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.23,
					"prestige_points": 0.23
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.24,
					"prestige_points": 0.24
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.35,
					"prestige_points": 0.35
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.40,
					"prestige_points": 0.40
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.50,
					"prestige_points": 0.50
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.60,
					"prestige_points": 0.60
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 1.0,
					"prestige_points": 1.0
				},
				"progress": 0
			}
		},
		
		"necklace": {
			"slot1": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.10,
					"damage": 0.10
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.11,
					"damage": 0.11
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.12,
					"damage": 0.12
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.13,
					"damage": 0.13
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.14,
					"damage": 0.14
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.20,
					"damage": 0.20
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.21,
					"damage": 0.21
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.22,
					"damage": 0.22
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.23,
					"damage": 0.23
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.24,
					"damage": 0.24
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.35,
					"damage": 0.35
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.40,
					"damage": 0.40
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.50,
					"damage": 0.50
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.60,
					"damage": 0.60
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03e.png",
				"level": 1,
				"atributtes": {
					"gold": 1.0,
					"damage": 1.0
				},
				"progress": 0
			}
		}
	}
}


func _notification(what: int) -> void:
	if what == 1006:
		get_tree().quit()
		save_data()
