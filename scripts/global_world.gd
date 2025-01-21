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


func _notification(what: int) -> void:
	if what == 1006:
		save_data()
