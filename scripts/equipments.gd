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
var selected_item
var selected_button


func _ready() -> void:
	connect_button_signal()
	load_equipment("weapon")
	load_equipment("shield")


func connect_button_signal() -> void:
	for button in weapon_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in shield_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))


func on_button_pressed(button: TextureButton) -> void:
	show_item_info(button.get_parent().name, button.name) # tentar passando o button ao inves de o nome
	selected_button = button
	$Background/ItemInfo.visible = true


func show_item_info(container: String, button_name: String) -> void:
	var item_texture: TextureRect = $Background/ItemInfo/BGColor/BGItemInfo/Sprite
	var item_name: Label = $Background/ItemInfo/BGInfo/ItemName
	var atributte_1: Label = $Background/ItemInfo/BGInfo/Atributte1
	var atributte_2: Label = $Background/ItemInfo/BGInfo/Atributte2
	
	if container == "WeaponContainer":
		container = "weapon"
	elif container == "ShieldContainer":
		container = "shield"
	
	selected_item = data_equipment[container][button_name.to_lower()]
	
	item_texture.texture = load(
		data_equipment[container][button_name.to_lower()]["path"]
		)
	
	get_rarity_item(button_name.to_lower())
	
	if container == "weapon":
		item_name.text = get_rarity_item(button_name.to_lower()) + " " + \
		container.capitalize() + " Lv " + str(data_equipment[container][button_name.to_lower()]["level"])
		atributte_1.text = "Damage: + " \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["damage"] * 100) + "%"
		atributte_2.text = "Critical Damage: + " \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["critical_damage"] * 100) + "%"
		
	elif container == "shield":
		item_name.text = get_rarity_item(button_name.to_lower()) + " " + \
		container.capitalize() + " Lv " + str(data_equipment[container][button_name.to_lower()]["level"])
		atributte_1.text =  "Gold: + " \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["gold"] * 100) + "%"
		atributte_2.text = "Prestige Points: + " \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["prestige_points"] * 100) + "%"


func get_rarity_item(slot_name: String) -> String:
	var commom: Array = ["slot1", "slot2", "slot3", "slot4", "slot5"]
	var uncommom: Array = ["slot6", "slot7", "slot8", "slot9", "slot10"]
	var elite: Array = ["slot11", "slot12"]
	var epic: Array = ["slot13", "slot14"]
	var legendary: Array = ["slot15"]
	
	if slot_name in commom:
		return "Commom"
	elif slot_name in uncommom:
		return "Uncommom"
	elif slot_name in elite:
		return "Elite"
	elif slot_name in epic:
		return "Epic"
	elif slot_name in legendary:
		return "Legendary"
	
	return ""


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
			slot.disabled = false
		
		if data_equipment[type][slot.name.to_lower()]["is_equipped"]:
			slot.get_node("BG/Equipped").visible = true
			if type == "weapon":
				Player.equipped_weapon = slot.name
			elif type == "shield":
				Player.equipped_shield = slot.name


func add_item(type: String, slot: String, item_data: Dictionary) -> void:
	if data_equipment[type][slot]["is_locked"]:
		data_equipment[type][slot]["is_locked"] = false
		data_equipment[type][slot]["progress"] = 1
	else:
		data_equipment[type][slot]["progress"] += 1
		if data_equipment[type][slot]["progress"] == item_level_dict[str(data_equipment[type][slot]["level"])]:
			upgrade_level_item(data_equipment[type][slot])
	
	load_equipment(type)


func upgrade_level_item(slot_data: Dictionary) -> void:
	slot_data["level"] += 1
	slot_data["progress"] = 0
	
	#print("Antes: ", slot_data)
	
	if slot_data["atributtes"].has("damage"):
		slot_data["atributtes"]["damage"] += 0.01
		slot_data["atributtes"]["critical_damage"] += 0.01
		
	elif slot_data["atributtes"].has("gold"):
		slot_data["atributtes"]["gold"] += 0.01
		slot_data["atributtes"]["prestige_points"] += 0.01
		
	#print("Depois: ", slot_data)
	#print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=")


func _on_equip_item_pressed() -> void:
	selected_button.get_node("BG/Equipped").visible = true
	selected_item["is_equipped"] =  true
	
	if selected_button.get_parent().name == "WeaponContainer":
		Player.equipped_weapon = selected_button.name
	elif selected_button.get_parent().name == "ShieldContainer":
		Player.equipped_shield = selected_button.name


func _on_unequip_item_pressed() -> void:
	selected_button.get_node("BG/Equipped").visible = false
	selected_item["is_equipped"] =  false
	
	if selected_button.get_parent().name == "WeaponContainer":
		Player.equipped_weapon = ""
	elif selected_button.get_parent().name == "ShieldContainer":
		Player.equipped_shield = ""


func _on_close_pressed() -> void:
	visible = false
	$Background/ItemInfo.visible = false
	weapon_container.visible = true
	shield_container.visible = false


func _on_sword_tab_pressed() -> void:
	weapon_container.visible = true
	shield_container.visible = false


func _on_shield_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = true
