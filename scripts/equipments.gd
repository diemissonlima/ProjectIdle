extends Control


@export_category("Objetos")
@export var weapon_container: GridContainer
@export var shield_container: GridContainer
@export var ring_container: GridContainer
@export var necklace_container: GridContainer

var item_level_dict: Dictionary = {
	"1": 10, "2": 15, "3": 20, "4": 25, "5": 30,
	"6": 35, "7": 40, "8": 45, "9": 50, "10": 55,
	"11": 60, "12": 65, "13": 70, "14": 75, "15": 80,
	"16": 85, "17": 90, "18": 95, "19": 100, "20": 105
}
var data_equipment: Dictionary = Data.data_management["equipments"]
var selected_item
var selected_button
var equipment_type: String = ""


func _ready() -> void:
	connect_button_signal()
	load_equipment("weapon")
	load_equipment("shield")
	load_equipment("ring")
	load_equipment("necklace")


func drop_item() -> void:
	var rng: float = 0.0
	var slot: String = ""
	var equipment_type: String = ""
	var rarity: String = ""
	
	var slot_list: Array = []
	var item_attribute: Array = [
		"damage", "critical_damage", "prestige_points", "gold"
	]
	var type_list: Array = [
		"weapon", "shield", "ring", "necklace"
	]
	var attribute_range: Array = []
	
	var item_attribute_1: String = item_attribute.pick_random()
	var item_attribute_2: String = item_attribute.pick_random()
	
	var item_info: Dictionary = {}
	
	
	rng = randf()
	if rng > 0.0 and rng <= 0.75:
		rarity = "Commom"
		slot_list = ["slot1", "slot2", "slot3", "slot4", "slot5"]
		attribute_range = [30, 50]
	elif rng > 0.75 and rng <= 0.90:
		rarity = "Uncommom"
		slot_list = ["slot6", "slot7", "slot8", "slot9", "slot10"]
		attribute_range = [51, 80]
	elif rng > 0.90 and rng <= 0.95:
		rarity = "Elite"
		slot_list = ["slot11", "slot12"]
		attribute_range = [81, 100]
		rarity = "Epic"
		slot_list = ["slot13", "slot14"]
		attribute_range = [101, 150]
	elif rng > 0.99 and rng <= 1.0:
		rarity = "Legendary"
		slot_list = ["slot15"]
		attribute_range = [151, 200]
	
	while item_attribute_2 == item_attribute_1:
		item_attribute_2 = item_attribute.pick_random()
		if item_attribute_2 != item_attribute_1:
			break
	
	var attribute_value_1: float = (randi_range(attribute_range[0], attribute_range[1]) / 100.0)
	var attribute_value_2: float = (randi_range(attribute_range[0], attribute_range[1]) / 100.0)
	
	slot = slot_list.pick_random()
	equipment_type = type_list.pick_random()
	
	item_info = {
		"slot": slot,
		"rarity": rarity,
		"type": equipment_type,
		"atributtes": {
			item_attribute_1: attribute_value_1,
			item_attribute_2: attribute_value_2
		}
	}
	
	print(item_info)
	
	Data.data_management["equipments"][equipment_type][slot.to_lower()]["atributtes"] = (
		item_info["atributtes"]
	)


func connect_button_signal() -> void:
	for button in weapon_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in shield_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in ring_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in necklace_container.get_children():
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
	
	match container:
		"WeaponContainer":
			container = "weapon"
		"ShieldContainer":
			container = "shield"
		"RingContainer":
			container = "ring"
		"NecklaceContainer":
			container = "necklace"
	
	equipment_type = container
	selected_item = data_equipment[container][button_name.to_lower()]
	
	item_texture.texture = load(
		data_equipment[container][button_name.to_lower()]["path"]
		)
	
	get_rarity_item(button_name.to_lower())
	
	if container == "weapon":
		item_name.text = get_rarity_item(button_name.to_lower()) + " " + \
		container.capitalize() + " Lv " + str(data_equipment[container][button_name.to_lower()]["level"])
		atributte_1.text = "+" \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["damage"] * 100) + "% Damage"
		atributte_2.text = "+" \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["critical_damage"] * 100) + "% Critical Damage"
		
	elif container == "shield":
		item_name.text = get_rarity_item(button_name.to_lower()) + " " + \
		container.capitalize() + " Lv " + str(data_equipment[container][button_name.to_lower()]["level"])
		atributte_1.text =  "+" \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["gold"] * 100) + "% Gold"
		atributte_2.text = "+" \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["prestige_points"] * 100) + "% Prestige Points"
		
	elif container == "ring":
		item_name.text = get_rarity_item(button_name.to_lower()) + " " + \
		container.capitalize() + " Lv " + str(data_equipment[container][button_name.to_lower()]["level"])
		atributte_1.text =  "+" \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["critical_damage"] * 100) + "% Critical Damage"
		atributte_2.text = "+" \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["prestige_points"] * 100) + "% Prestige Points"
		
	elif container == "necklace":
		item_name.text = get_rarity_item(button_name.to_lower()) + " " + \
		container.capitalize() + " Lv " + str(data_equipment[container][button_name.to_lower()]["level"])
		atributte_1.text =  "+" \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["damage"] * 100) + "% Damage"
		atributte_2.text = "+" \
		+ str(data_equipment[container][button_name.to_lower()]["atributtes"]["gold"] * 100) + "% Gold"


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
		"shield": shield_container,
		"ring": ring_container,
		"necklace": necklace_container
	}
	
	for slot in target_container[type].get_children():
		if not data_equipment[type][slot.name.to_lower()]["is_locked"]:
			slot.get_node("BG/Level").text = "Lv " + str(data_equipment[type][slot.name.to_lower()]["level"])
			slot.get_node("BG/ProgressBar").max_value = 10
			slot.get_node("BG/ProgressBar").value = data_equipment[type][slot.name.to_lower()]["progress"]
			slot.get_node("BG/ProgressBar/Progress").text = str(
				data_equipment[type][slot.name.to_lower()]["progress"]
				) + " / " + str(10)
			slot.get_node("BG/Sprite").modulate.a = 1.0
			slot.get_node("BG/Lock").visible = false
			slot.get_node("BG/Level").visible = true
			slot.get_node("BG/ProgressBar").visible = true
			slot.disabled = false
		
		if data_equipment[type][slot.name.to_lower()]["is_equipped"]:
			slot.get_node("BG/Equipped").visible = true
			
			match type:
				"weapon":
					Player.handler_item("equip", "weapon", slot.name)
				"shield":
					Player.handler_item("equip", "shield", slot.name)
				"ring":
					Player.handler_item("equip", "ring", slot.name)
				"necklace":
					Player.handler_item("equip", "necklace", slot.name)
					
		else:
			slot.get_node("BG/Equipped").visible = false


func add_item(type: String, slot: String, item_data: Dictionary) -> void:
	if data_equipment[type][slot]["is_locked"]:
		data_equipment[type][slot]["is_locked"] = false
		data_equipment[type][slot]["progress"] = 1
	else:
		data_equipment[type][slot]["progress"] += 1
		if data_equipment[type][slot]["progress"] == 10:
			upgrade_level_item(data_equipment[type][slot], type, get_rarity_item(slot))
	
	load_equipment(type)


func upgrade_level_item(slot_data: Dictionary, type: String, rarity: String) -> void:
	var upgrade: float = 0.0
	
	slot_data["level"] += 1
	slot_data["progress"] = 0
	
	match rarity:
		"Commom":
			upgrade = 0.10
		"Uncommom":
			upgrade = 0.20
		"elite":
			upgrade = 0.30
		"epic":
			upgrade = 0.40
		"legendary":
			upgrade = 0.50
	
	match type:
		"weapon":
			slot_data["atributtes"]["damage"] += upgrade
			slot_data["atributtes"]["critical_damage"] += upgrade
		"shield":
			slot_data["atributtes"]["gold"] += upgrade
			slot_data["atributtes"]["prestige_points"] += upgrade
		"ring":
			slot_data["atributtes"]["critical_damage"] += upgrade
			slot_data["atributtes"]["prestige_points"] += upgrade
		"necklace":
			slot_data["atributtes"]["gold"] += upgrade
			slot_data["atributtes"]["damage"] += upgrade


func _on_equip_item_pressed() -> void:
	selected_button.get_node("BG/Equipped").visible = true
	selected_item["is_equipped"] =  true
	
	if Player.equipped_items[equipment_type]["slot"] == "":
		Player.handler_item("equip", equipment_type, selected_button.name)
	
	elif selected_button.name == Player.equipped_items[equipment_type]["slot"]:
		return
		
	else:
		Player.handler_item("unequip", equipment_type, Player.equipped_items[equipment_type]["slot"])
		Player.handler_item("equip", equipment_type, selected_button.name)


func _on_close_pressed() -> void:
	visible = false
	$Background/ItemInfo.visible = false
	weapon_container.visible = true
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = false


func _on_sword_tab_pressed() -> void:
	weapon_container.visible = true
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_shield_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = true
	ring_container.visible = false
	necklace_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_ring_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = true
	necklace_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_necklace_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = true
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false
