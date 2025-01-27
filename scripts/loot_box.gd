extends Control

@export var loot_box: VBoxContainer
@export var max_messages: int = 5
@export var font: Font


func add_message(message: String, color: Color = Color.WHITE) -> void:
	var new_label = RichTextLabel.new()
	new_label.bbcode_enabled = true
	new_label.text = "[color=%s]%s[/color]" % [color.to_html(), message]
	new_label.scroll_active = false
	new_label.scroll_following = false
	
	new_label.custom_minimum_size = Vector2(18, 19)
	new_label.add_theme_font_override("normal_font", font)
	new_label.add_theme_font_size_override("normal_font_size", 16)
	new_label.add_theme_constant_override("outline_size", 6)
	
	loot_box.add_child(new_label)
	
	await get_tree().create_timer(1.5).timeout
	loot_box.get_child(0).queue_free()
