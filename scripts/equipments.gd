extends Control


@export_category("Objetos")
@export var weapon_container: GridContainer
@export var shield_container: GridContainer

var item_level_dict: Dictionary = {
	"1": 10, "2": 15, "3": 20, "4": 25, "5": 30,
	"6": 35, "7": 40, "8": 45, "9": 50, "10": 55,
	"11": 60, "12": 65, "13": 70, "14": 75, "15": 80,
	"16": 85, "17": 90, "18": 95, "19": 100, "20": 105
}
var data_equipment: Dictionary = Data.data_management["equipments"]


func _ready() -> void:
	load_equipment("weapon")
	load_equipment("shield")


func load_equipment(type: String) -> void:
	var target_container: Dictionary = {
		"weapon": weapon_container,
		"shield": shield_container
	}
	
	for slot in target_container[type].get_children():
		if not data_equipment[type][slot.name.to_lower()]["is_locked"]:
			slot.get_node("BG/Level").text = "Lv " + str(data_equipment[type][slot.name.to_lower()]["level"])
			slot.get_node("BG/ProgressBar").max_value = item_level_dict[str(
				data_equipment[type][slot.name.to_lower()]["level"]
			)]
			slot.get_node("BG/ProgressBar").value = data_equipment[type][slot.name.to_lower()]["progress"]
			slot.get_node("BG/ProgressBar/Progress").text = str(
				data_equipment[type][slot.name.to_lower()]["progress"]
				) + " / " + str(item_level_dict[str(
					data_equipment[type][slot.name.to_lower()]["level"])]
					)
			slot.get_node("BG/Sprite").modulate.a = 1.0
			slot.get_node("BG/Lock").visible = false
			slot.get_node("BG/Level").visible = true
			slot.get_node("BG/ProgressBar").visible = true


func add_item(type: String, slot: String, item_data: Dictionary) -> void:
	if data_equipment[type][slot]["is_locked"]:
		data_equipment[type][slot]["is_locked"] = false
		data_equipment[type][slot]["progress"] = 1
	else:
		data_equipment[type][slot]["progress"] += 1
	
	print(type)
	print("-=-=-=-=-=-=-=-=-=-=-=-=")


func _on_close_pressed() -> void:
	visible = false
	weapon_container.visible = true
	shield_container.visible = false


func _on_sword_tab_pressed() -> void:
	weapon_container.visible = true
	shield_container.visible = false


func _on_shield_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = true
