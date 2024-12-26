extends Node

var gameplay_time: float = 0.0
var battle_time: int = 5
var estagio: int = 1
var avg_estagio: int = 1
var reset: int = 0

var gold_skill_on: bool = false


func _ready() -> void:
	load_data()


func _process(_delta: float) -> void:
	Data.data_management["world"]["game_time"] = World.gameplay_time


func load_data() -> void:
	Data.load_data()
	var data = Data.data_management["world"]
	
	gameplay_time = data["game_time"]
	battle_time = data["battle_time"]
	estagio = data["current_stage"]
	avg_estagio = data["highest_stage"]
	reset = data["reset"]


func save_data() -> void:
	var data = Data.data_management["world"]
	
	data["game_time"] = gameplay_time
	data["battle_time"] = battle_time
	data["current_stage"] = estagio
	data["highest_stage"] = avg_estagio
	data["reset"] = reset
	
	Data.save_data()
