extends Control

@export_category("Raid - Damage")
@export var raid_damage_name: Label
@export var raid_damage_gain: Label
@export var raid_damage_hp: Label
@export var raid_damage_time_left: Label
@export var raid_damage_cooldown: Timer
@export var button_raid_damage: TextureButton

@export_category("Raid - Gold")
@export var raid_gold_name: Label
@export var raid_gold_gain: Label
@export var raid_gold_hp: Label
@export var raid_gold_time_left: Label
@export var raid_gold_cooldown: Timer
@export var button_raid_gold: TextureButton

@export_category("Raid - Critical")
@export var raid_critical_name: Label
@export var raid_critical_gain: Label
@export var raid_critical_hp: Label
@export var raid_critical_time_left: Label
@export var raid_critical_cooldown: Timer
@export var button_raid_critical: TextureButton


func _ready() -> void:
	load_cooldown_raid()
	update_label()


func _process(delta: float) -> void:
	if raid_damage_cooldown.time_left > 0:
		button_raid_damage.hide()
		raid_damage_time_left.text = "Próxima Raide:\n" + convert_time_cooldown(float(raid_damage_cooldown.time_left))
	else:
		raid_damage_time_left.text = "Raide Liberada!!"
		button_raid_damage.show()
	
	if raid_gold_cooldown.time_left > 0:
		button_raid_gold.hide()
		raid_gold_time_left.text = "Próxima Raide:\n" + convert_time_cooldown(float(raid_gold_cooldown.time_left))
	else:
		button_raid_gold.show()
		raid_gold_time_left.text = "Raide Liberada!!"
		
	
	if raid_critical_cooldown.time_left > 0:
		button_raid_critical.hide()
		raid_critical_time_left.text = "Próxima Raide:\n" + convert_time_cooldown(float(raid_critical_cooldown.time_left))
	else:
		button_raid_critical.show()
		raid_critical_time_left.text = "Raide Liberada!!"


func convert_time_cooldown(time_left: float) -> String:
	var minutes = (int(time_left) % 3600) / 60
	var seconds = int(time_left) % 60
	
	return "%02dm : %02ds" % [minutes, seconds]


func load_cooldown_raid() -> void:
	if Data.data_management["raids"]["raid_damage"]["time_left"] > 0:
		raid_damage_cooldown.start(Data.data_management["raids"]["raid_damage"]["time_left"])
	
	if Data.data_management["raids"]["raid_gold"]["time_left"] > 0:
		raid_gold_cooldown.start(Data.data_management["raids"]["raid_gold"]["time_left"])
	
	if Data.data_management["raids"]["raid_critical"]["time_left"] > 0:
		raid_critical_cooldown.start(Data.data_management["raids"]["raid_critical"]["time_left"])


func update_label() -> void:
	raid_damage_name.text = "Dragon Lvl " + str(Data.data_management["raids"]["raid_damage"]["level"])
	raid_damage_gain.text = "Dano Herói + " + str(Data.data_management["raids"]["raid_damage"]["multiplier"] * 100) + "%"
	raid_damage_hp.text = "HP: " + str(round(Data.data_management["raids"]["raid_damage"]["hp"]))
	
	raid_gold_name.text = "Quimera Lvl " + str(Data.data_management["raids"]["raid_gold"]["level"])
	raid_gold_gain.text = "Gold drop + " + str(Data.data_management["raids"]["raid_gold"]["multiplier"] * 100) + "%"
	raid_gold_hp.text = "HP: " + str(round(Data.data_management["raids"]["raid_gold"]["hp"]))
	
	raid_critical_name.text = "Leviatã Lvl " + str(Data.data_management["raids"]["raid_critical"]["level"])
	raid_critical_gain.text = "Chance Crítico + " + str(Data.data_management["raids"]["raid_critical"]["multiplier"] * 100) + "%"
	raid_critical_hp.text = "HP: " + str(round(Data.data_management["raids"]["raid_critical"]["hp"]))


func update_cooldown_raid(raid_type: String) -> void:
	var raid_cooldow: float = 600.0
	
	match raid_type:
		"raid_damage":
			raid_damage_cooldown.start(raid_cooldow)
			
		"raid_gold":
			raid_gold_cooldown.start(raid_cooldow)
			
		"raid_critical":
			raid_critical_cooldown.start(raid_cooldow)


func _on_raid_damage_fight_pressed() -> void:
	self.hide()
	get_tree().call_group("world", "stop_battle", "raid_damage")


func _on_raid_gold_fight_pressed() -> void:
	self.hide()
	get_tree().call_group("world", "stop_battle", "raid_gold")


func _on_raid_critical_fight_pressed() -> void:
	self.hide()
	get_tree().call_group("world", "stop_battle", "raid_critical")


func _on_texture_button_pressed() -> void:
	self.hide()


func _notification(what: int) -> void:
	if what == 1006:
		Data.data_management["raids"]["raid_damage"]["time_left"] = float(raid_damage_cooldown.time_left)
		Data.data_management["raids"]["raid_gold"]["time_left"] = float(raid_gold_cooldown.time_left)
		Data.data_management["raids"]["raid_critical"]["time_left"] = float(raid_critical_cooldown.time_left)
