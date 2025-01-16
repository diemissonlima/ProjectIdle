extends Control

@export_category("Labels")
@export var label_gametime: Label
@export var label_current_stage: Label
@export var label_max_stage: Label
@export var label_current_gold: Label
@export var label_resets: Label

@export_category("Buttons")
@export var btn_loadgame: Button


func _process(_delta: float) -> void:
	if FileAccess.file_exists("res://save/save.dat"):
		btn_loadgame.disabled = false
	else:
		btn_loadgame.disabled = true


func set_label_info() -> void:
	var data: Dictionary = Data.data_management
	
	label_gametime.text = "Tempo de Jogo: " + get_gametime()
	label_current_stage.text = "Estagio Atual: " + str(data["world"]["current_stage"])
	label_max_stage.text = "Estagio Maximo: " + str(data["world"]["highest_stage"])
	label_current_gold.text = "Gold: " + str(data["player"]["gold"])
	label_resets.text = "Resets: " + str(data["world"]["reset"])


func get_gametime() -> String:
	var gametime: float = Data.data_management["world"]["game_time"]
	var hour = int(gametime / 3600)
	var minute = (int(gametime) % 3600) / 60
	var second = int(gametime) % 60
	
	return "%02d:%02d:%02d" % [hour, minute, second]


func _on_new_game_pressed() -> void:
	if FileAccess.file_exists("res://save/save.dat"):
		$Background/VBoxContainer.hide()
		$Background/VBoxContainer3.show()
		return
		
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_load_game_pressed() -> void:
	set_label_info()
	$Background/Background.show()


func _on_load_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_ok_pressed() -> void:
	Data.delete_savegame()
	$Background/VBoxContainer3.hide()
	$Background/VBoxContainer.show()


func _on_exit_game_pressed() -> void:
	get_tree().quit()
