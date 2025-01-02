extends Control

@export_category("Labels")
@export var label_time_offline: Label
@export var label_gold_per_second: Label
@export var label_total_goldfarm: Label


func _ready() -> void:
	if Data.data_management["world"]["exit_time"].is_empty():
		visible = false
	else:
		visible = true


func show_label_info(info: Array) -> void:
	label_time_offline.text = "Tempo Offline: " + str(info[0][0]) + " segundos"
	label_gold_per_second.text = "Gold por segundo: " + str(info[0][1])
	label_total_goldfarm.text = "Farm de Gold Offline: " + str(info[0][2])


func _on_button_ok_pressed() -> void:
	visible = false
