extends Control

@export_category("Labels")
@export var label_time_offline: Label
@export var label_gold_per_second: Label
@export var label_total_goldfarm: Label


func _ready() -> void:
	if Data.data_management["world"]["exit_time"] == 0:
		visible = false
	else:
		calculate_offline_gold()
		visible = true


func show_label_info(info: Array) -> void:
	label_time_offline.text = "Tempo Offline: " + str(info[0][0]) + " segundos"
	label_gold_per_second.text = "Gold por segundo: " + str(info[0][1])
	label_total_goldfarm.text = "Farm de Gold Offline: " + str(info[0][2])


func calculate_offline_gold() -> void:
	if Data.data_management["world"]["exit_time"] == 0:
		return
		
	var max_offline_gold: int = 28800 # 8 horas
	var last_time_exit: int = Data.data_management["world"]["exit_time"]
	
	var current_time = Time.get_datetime_dict_from_system()
	var current_time_converted = Time.get_unix_time_from_datetime_dict(current_time)
	
	var time_offline: int = current_time_converted - last_time_exit
	
	if time_offline >= max_offline_gold:
		time_offline = max_offline_gold
	
	if time_offline > 0:
		var gold_per_second = Player.damage * 0.1
		var gold_earned = int(time_offline * gold_per_second)
		var info: Array
		
		info.append([time_offline, gold_per_second, gold_earned])
		show_label_info(info)
		
		Player.gold += gold_earned


func _on_button_ok_pressed() -> void:
	visible = false
