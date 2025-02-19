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
		"level": 1,
		"current_exp": 0,
		"gold": 0,
		"skill_points": 0,
		"prestige_points": 0,
		"x_upgrade_ataque": 1,
		"x_upgrade_time": 1,
		"skills": {
			"increase_attack": {
				"level": 1,
				"multiplier": 1.0,
				"duration": 0.0,
				"cooldown": 0.0,
			},
			
			"increase_gold": {
				"level": 1,
				"multiplier": 1.0,
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
		"itens_dropped": 0,
		"monster": {}
	},
	
	"raids": {
		"raid_damage": {
			"level": 1,
			"hp": 50000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_gold": {
			"level": 1,
			"hp": 50000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_critical": {
			"level": 1,
			"hp": 50000,
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
					"damage": 0.35,
					"critical_damage": 0.35,
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.36,
					"critical_damage": 0.36,
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.37,
					"critical_damage": 0.37,
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.38,
					"critical_damage": 0.38,
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01e.png",
				"level": 1,
				"atributtes": {
					"damage": 0.40,
					"critical_damage": 0.40,
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.50,
					"critical_damage": 0.50,
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.51,
					"critical_damage": 0.51,
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.52,
					"critical_damage": 0.52,
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.53,
					"critical_damage": 0.53,
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02e.png",
				"level": 1,
				"atributtes": {
					"damage": 0.55,
					"critical_damage": 0.55,
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.65,
					"critical_damage": 0.65,
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.75,
					"critical_damage": 0.75,
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.85,
					"critical_damage": 0.85,
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03d.png",
				"level": 1,
				"atributtes": {
					"damage": 1.0,
					"critical_damage": 1.0,
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03e.png",
				"level": 1,
				"atributtes": {
					"damage": 2.0,
					"critical_damage": 2.0,
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
					"gold": 0.35,
					"prestige_points": 0.35
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.36,
					"prestige_points": 0.36
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.37,
					"prestige_points": 0.37
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.38,
					"prestige_points": 0.38
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.40,
					"prestige_points": 0.40
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.50,
					"prestige_points": 0.50
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.51,
					"prestige_points": 0.51
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.52,
					"prestige_points": 0.52
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.53,
					"prestige_points": 0.53
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.55,
					"prestige_points": 0.55
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.65,
					"prestige_points": 0.65
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.75,
					"prestige_points": 0.75
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.85,
					"prestige_points": 0.85
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03d.png",
				"level": 1,
				"atributtes": {
					"gold": 1.0,
					"prestige_points": 1.0
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03e.png",
				"level": 1,
				"atributtes": {
					"gold": 2.0,
					"prestige_points": 2.0
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
					"critical_damage": 0.35,
					"prestige_points": 0.35
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.36,
					"prestige_points": 0.36
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.37,
					"prestige_points": 0.37
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.38,
					"prestige_points": 0.38
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.40,
					"prestige_points": 0.40
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.50,
					"prestige_points": 0.50
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.51,
					"prestige_points": 0.51
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.52,
					"prestige_points": 0.52
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.53,
					"prestige_points": 0.53
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.55,
					"prestige_points": 0.55
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.65,
					"prestige_points": 0.65
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.75,
					"prestige_points": 0.75
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.85,
					"prestige_points": 0.85
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 1.0,
					"prestige_points": 1.0
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 2.0,
					"prestige_points": 2.0
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
					"gold": 0.35,
					"damage": 0.35
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.36,
					"damage": 0.36
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.37,
					"damage": 0.37
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.38,
					"damage": 0.38
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.40,
					"damage": 0.40
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.50,
					"damage": 0.50
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.51,
					"damage": 0.51
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.52,
					"damage": 0.52
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.53,
					"damage": 0.53
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.55,
					"damage": 0.55
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.65,
					"damage": 0.65
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.75,
					"damage": 0.75
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.85,
					"damage": 0.85
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03d.png",
				"level": 1,
				"atributtes": {
					"gold": 1.0,
					"damage": 1.0
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03e.png",
				"level": 1,
				"atributtes": {
					"gold": 2.0,
					"damage": 2.0
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
		"ataque": 10.0,
		"default_damage": 10.0,
		"attack_speed": 0.5,
		"level": 1,
		"current_exp": 0,
		"gold": 0,
		"skill_points": 0,
		"prestige_points": 0,
		"x_upgrade_ataque": 1,
		"x_upgrade_time": 1,
		"skills": {
			"increase_attack": {
				"level": 1,
				"multiplier": 1.0,
				"duration": 0.0,
				"cooldown": 0.0,
			},
			
			"increase_gold": {
				"level": 1,
				"multiplier": 1.0,
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
		"itens_dropped": 0,
		"monster": {}
	},
	
	"raids": {
		"raid_damage": {
			"level": 1,
			"hp": 50000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_gold": {
			"level": 1,
			"hp": 50000,
			"multiplier": 0.0,
			"time_left": 0.0
		},
		
		"raid_critical": {
			"level": 1,
			"hp": 50000,
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
					"damage": 0.35,
					"critical_damage": 0.35,
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.36,
					"critical_damage": 0.36,
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.37,
					"critical_damage": 0.37,
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.38,
					"critical_damage": 0.38,
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_01e.png",
				"level": 1,
				"atributtes": {
					"damage": 0.40,
					"critical_damage": 0.40,
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.50,
					"critical_damage": 0.50,
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.51,
					"critical_damage": 0.51,
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.52,
					"critical_damage": 0.52,
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02d.png",
				"level": 1,
				"atributtes": {
					"damage": 0.53,
					"critical_damage": 0.53,
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_02e.png",
				"level": 1,
				"atributtes": {
					"damage": 0.55,
					"critical_damage": 0.55,
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03a.png",
				"level": 1,
				"atributtes": {
					"damage": 0.65,
					"critical_damage": 0.65,
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03b.png",
				"level": 1,
				"atributtes": {
					"damage": 0.75,
					"critical_damage": 0.75,
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03c.png",
				"level": 1,
				"atributtes": {
					"damage": 0.85,
					"critical_damage": 0.85,
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03d.png",
				"level": 1,
				"atributtes": {
					"damage": 1.0,
					"critical_damage": 1.0,
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/sword_03e.png",
				"level": 1,
				"atributtes": {
					"damage": 2.0,
					"critical_damage": 2.0,
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
					"gold": 0.35,
					"prestige_points": 0.35
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.36,
					"prestige_points": 0.36
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.37,
					"prestige_points": 0.37
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.38,
					"prestige_points": 0.38
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_01e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.40,
					"prestige_points": 0.40
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.50,
					"prestige_points": 0.50
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.51,
					"prestige_points": 0.51
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.52,
					"prestige_points": 0.52
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.53,
					"prestige_points": 0.53
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_02e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.55,
					"prestige_points": 0.55
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.65,
					"prestige_points": 0.65
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.75,
					"prestige_points": 0.75
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.85,
					"prestige_points": 0.85
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03d.png",
				"level": 1,
				"atributtes": {
					"gold": 1.0,
					"prestige_points": 1.0
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/shield_03e.png",
				"level": 1,
				"atributtes": {
					"gold": 2.0,
					"prestige_points": 2.0
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
					"critical_damage": 0.35,
					"prestige_points": 0.35
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.36,
					"prestige_points": 0.36
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.37,
					"prestige_points": 0.37
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.38,
					"prestige_points": 0.38
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_01e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.40,
					"prestige_points": 0.40
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.50,
					"prestige_points": 0.50
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.51,
					"prestige_points": 0.51
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.52,
					"prestige_points": 0.52
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.53,
					"prestige_points": 0.53
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_02e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.55,
					"prestige_points": 0.55
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03a.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.65,
					"prestige_points": 0.65
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03b.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.75,
					"prestige_points": 0.75
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03c.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 0.85,
					"prestige_points": 0.85
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03d.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 1.0,
					"prestige_points": 1.0
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/ring_03e.png",
				"level": 1,
				"atributtes": {
					"critical_damage": 2.0,
					"prestige_points": 2.0
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
					"gold": 0.35,
					"damage": 0.35
				},
				"progress": 0
			},
			"slot2": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.36,
					"damage": 0.36
				},
				"progress": 0
			},
			"slot3": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.37,
					"damage": 0.37
				},
				"progress": 0
			},
			"slot4": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.38,
					"damage": 0.38
				},
				"progress": 0
			},
			"slot5": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_01e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.40,
					"damage": 0.40
				},
				"progress": 0
			},
			"slot6": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.50,
					"damage": 0.50
				},
				"progress": 0
			},
			"slot7": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.51,
					"damage": 0.51
				},
				"progress": 0
			},
			"slot8": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.52,
					"damage": 0.52
				},
				"progress": 0
			},
			"slot9": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02d.png",
				"level": 1,
				"atributtes": {
					"gold": 0.53,
					"damage": 0.53
				},
				"progress": 0
			},
			"slot10": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_02e.png",
				"level": 1,
				"atributtes": {
					"gold": 0.55,
					"damage": 0.55
				},
				"progress": 0
			},
			"slot11": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03a.png",
				"level": 1,
				"atributtes": {
					"gold": 0.65,
					"damage": 0.65
				},
				"progress": 0
			},
			"slot12": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03b.png",
				"level": 1,
				"atributtes": {
					"gold": 0.75,
					"damage": 0.75
				},
				"progress": 0
			},
			"slot13": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03c.png",
				"level": 1,
				"atributtes": {
					"gold": 0.85,
					"damage": 0.85
				},
				"progress": 0
			},
			"slot14": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03d.png",
				"level": 1,
				"atributtes": {
					"gold": 1.0,
					"damage": 1.0
				},
				"progress": 0
			},
			"slot15": {
				"is_locked": true,
				"is_equipped": false,
				"path": "res://assets/items/necklace_03e.png",
				"level": 1,
				"atributtes": {
					"gold": 2.0,
					"damage": 2.0
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
