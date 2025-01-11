extends Control

@export_category("Raid - Damage")
@export var raid_damage_name: Label
@export var raid_damage_gain: Label
@export var raid_damage_hp: Label
@export var raid_damage_time_left: Label
@export var raid_damage_cooldown: Timer

@export_category("Raid - Gold")
@export var raid_gold_name: Label
@export var raid_gold_gain: Label
@export var raid_gold_hp: Label
@export var raid_gold_time_left: Label
@export var raid_gold_cooldown: Timer

@export_category("Raid - Critical")
@export var raid_critical_name: Label
@export var raid_critical_gain: Label
@export var raid_critical_hp: Label
@export var raid_critical_time_left: Label
@export var raid_critical_cooldown: Timer


func _ready() -> void:
	for j in get_tree().get_nodes_in_group("raids"):
		get_info(j)
	
	raid_damage_name.text = "Dragon Lvl " + str(Data.data_management["raids"]["raid_damage"]["level"])
	raid_damage_gain.text = "Dano Herói + " + str(Data.data_management["raids"]["raid_damage"]["multiplier"] * 100) + "%"
	raid_damage_hp.text = "HP: " + str(Data.data_management["raids"]["raid_damage"]["hp"])
	if Data.data_management["raids"]["raid_damage"]["time_left"] > 0:
		raid_damage_cooldown.start(Data.data_management["raids"]["raid_damage"]["time_left"])
		
	raid_gold_name.text = "Dragon Lvl " + str(Data.data_management["raids"]["raid_gold"]["level"])
	raid_gold_gain.text = "Gold drop + " + str(Data.data_management["raids"]["raid_gold"]["multiplier"] * 100) + "%"
	raid_gold_hp.text = "HP: " + str(Data.data_management["raids"]["raid_gold"]["hp"])
	if Data.data_management["raids"]["raid_gold"]["time_left"] > 0:
		raid_gold_cooldown.start(Data.data_management["raids"]["raid_gold"]["time_left"])
		
	raid_critical_name.text = "Dragon Lvl " + str(Data.data_management["raids"]["raid_critical"]["level"])
	raid_critical_gain.text = "Chance Crítico + " + str(Data.data_management["raids"]["raid_critical"]["multiplier"] * 100) + "%"
	raid_critical_hp.text = "HP: " + str(Data.data_management["raids"]["raid_critical"]["hp"])
	if Data.data_management["raids"]["raid_critical"]["time_left"] > 0:
		raid_critical_cooldown.start(Data.data_management["raids"]["raid_critical"]["time_left"])


func _process(delta: float) -> void:
	if raid_damage_cooldown.time_left > 0:
		raid_damage_time_left.text = "Próxima Raide:\n" + convert_time_cooldown(float(raid_damage_cooldown.time_left))
	
	if raid_gold_cooldown.time_left > 0:
		raid_gold_time_left.text = "Próxima Raide:\n" + convert_time_cooldown(float(raid_gold_cooldown.time_left))
	
	if raid_critical_cooldown.time_left > 0:
		raid_critical_time_left.text = "Próxima Raide:\n" + convert_time_cooldown(float(raid_critical_cooldown.time_left))


func convert_time_cooldown(time_left: float) -> String:
	var minutes = (int(time_left) % 3600) / 60
	var seconds = int(time_left) % 60
	
	return "%02dm : %02ds" % [minutes, seconds]


func get_info(object: TextureRect) -> void:
	match object.name:
		"BackgroundDano":
			pass
			
		"BackgroundGold":
			pass
			
		"BackgroundCritical":
			pass


func _on_texture_button_pressed() -> void:
	self.hide()
