extends Node

var gameplay_time: float = 0.0
var battle_time: int = 5
var battle_time_raid: int = 10
var estagio: int = 1
var stage_progress: int = 1
var avg_estagio: int = 1
var reset: int = 0
var kills: int = 0
var gold_gain: float = 0.0

var current_exp_item_drop: int = 0
var item_drop_level: int = 1

var rarity_level_probability: Dictionary = {
	1: {
		"commom": 0.75, "uncommom": 1.0, "elite": 0.0, "epic": 0.0, "legendary": 0.0
	},
	2: {
		"commom": 0.70, "uncommom": 1.0, "elite": 0.0, "epic": 0.0, "legendary": 0.0
	},
	3: {
		"commom": 0.65, "uncommom": 0.99, "elite": 1.0, "epic": 0.0, "legendary": 0.0
	},
	4: {
		"commom": 0.60, "uncommom": 0.98, "elite": 1.0, "epic": 0.0, "legendary": 0.0
	},
	5: {
		"commom": 0.58, "uncommom": 0.97, "elite": 1.0, "epic": 0.0, "legendary": 0.0
	},
	6: {
		"commom": 0.56, "uncommom": 0.96, "elite": 0.99, "epic": 1.0, "legendary": 0.0
	},
	7: {
		"commom": 0.54, "uncommom": 0.94, "elite": 0.98, "epic": 1.0, "legendary": 0.0
	},
	8: {
		"commom": 0.52, "uncommom": 0.92, "elite": 0.97, "epic": 1.0, "legendary": 0.0
	},
	9: {
		"commom": 0.51, "uncommom": 0.91, "elite": 0.96, "epic": 1.0, "legendary": 0.0
	},
	10: {
		"commom": 0.50, "uncommom": 0.90, "elite": 0.95, "epic": 0.99, "legendary": 1.0
	}
}

func _ready() -> void:
	load_data()
	gameplay_time = Data.data_management["world"]["game_time"]


func load_data() -> void:
	Data.load_data()
	var data = Data.data_management["world"]
	
	gameplay_time = data["game_time"]
	battle_time = data["battle_time"]
	estagio = data["current_stage"]
	stage_progress = data["stage_progress"]
	avg_estagio = data["highest_stage"]
	reset = data["reset"]
	current_exp_item_drop = data["current_exp_item_drop"]
	item_drop_level = data["item_drop_level"]
	
	kills = Data.data_management["statistics"]["kills"]
	gold_gain = Data.data_management["statistics"]["gold_gain"]


func save_data() -> void:
	var data = Data.data_management["world"]
	
	data["game_time"] = gameplay_time
	data["battle_time"] = battle_time
	data["current_stage"] = estagio
	data["stage_progress"] = stage_progress
	data["highest_stage"] = avg_estagio
	data["reset"] = reset
	data["current_exp_item_drop"] = current_exp_item_drop
	data["item_drop_level"] = item_drop_level
	
	Data.data_management["statistics"]["kills"] = kills
	Data.data_management["statistics"]["gold_gain"] = gold_gain
	
	Data.save_data()


func format_number(value: float) -> String:
	var suffixes = [
		"", "K", "M", "B", "T", "a", "b", "c", "d", "e", "f", "g", "h", 
		"i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", 
		"x", "y", "z", "aa", "ab", "ac", "ad", "ae", "af", "ag", "ah", "ai", "aj", 
		"ak", "al", "am", "an", "ao", "ap", "aq", "ar", "as", "at", "au", "av", 
		"aw", "ax", "ay", "az", "ba", "bb", "bc", "bd", "be", "bf", "bg", "bh",
		"bi", "bj", "bk", "bl", "bm", "bn", "bo", "bp", "bq", "br", "bs", "bt",
		"bu", "bv", "bw", "bx", "by", "bz"
	]
	
	var index = 0
	while value >= 1000 and index < suffixes.size() - 1:
		value /= 1000
		index += 1
	
	value = int(value * 10 + 0.5) / 10.0
	var formatted_value = str(value if fmod(value, 1) != 0 else int(value))
	
	return formatted_value + suffixes[index]


func format_number_separator(number: String) -> String:
	var num = int(number)
	var formatted = []
	var num_str = str(num)
	var count = 0
	
	for i in range(num_str.length() -1, -1, -1):
		formatted.push_front(num_str[i])
		count += 1
		if count % 3 == 0 and i != 0:
			formatted.push_front(".")
	
	return "".join(formatted)


func _notification(what: int) -> void:
	if what == 1006:
		save_data()
