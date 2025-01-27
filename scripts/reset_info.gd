extends Control

@export_category("Objetos")
@export var label_rewards: Label
@export var button_reset: TextureButton
@export var button_close: TextureButton


func update_label_rewards(value: int) -> void:
	label_rewards.text = "+ " + World.format_number(value) + " Pontos de Prestígio"


func _on_reset_pressed() -> void:
	get_tree().call_group("world", "reset")
	self.hide()


func _on_button_close_pressed() -> void:
	self.hide()
