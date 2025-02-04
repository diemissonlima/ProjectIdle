extends Control


@export_category("Objetos")
@export var weapon_container: GridContainer
@export var shield_container: GridContainer
@export var ring_container: GridContainer
@export var necklace_container: GridContainer

@export_category("Bonus Info")
@export var bonus_damage: Label
@export var bonus_gold: Label
@export var bonus_critical_damage: Label
@export var bonus_prestige_points: Label

var item_level_dict: Dictionary = {
	"1": 2, "2": 3, "3": 4, "4": 5, "5": 6,
	"6": 7, "7": 8, "8": 9, "9": 10, "10": 11,
	"11": 12, "12": 13, "13": 14, "14": 15, "15": 16,
	"16": 17, "17": 18, "18": 19, "19": 20, "20": 21
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
	show_bonus_item()


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
	
	var keys: Array = []
	for key in data_equipment[container][button_name.to_lower()]["atributtes"].keys():
		keys.append(key)
	
	item_name.text = get_rarity_item(button_name.to_lower()) + " " + \
		container.capitalize() + " Lv " + str(data_equipment[container][button_name.to_lower()]["level"])
		
	atributte_1.text = "+ " \
	+ str(data_equipment[container][button_name.to_lower()]["atributtes"][keys[0]] * 100) \
	+ "% " + keys[0].capitalize()
	
	atributte_2.text = "+ " \
	+ str(data_equipment[container][button_name.to_lower()]["atributtes"][keys[1]] * 100) \
	+ "% " + keys[1].capitalize()


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


func add_item(item_data: Dictionary) -> void:
	var equipment_type: String = item_data["type"]
	var slot: String = item_data["slot"]
	
	if data_equipment[equipment_type][slot]["is_locked"]:
		data_equipment[equipment_type][slot]["is_locked"] = false
		data_equipment[equipment_type][slot]["progress"] = 1
		data_equipment[equipment_type][slot]["atributtes"] = item_data["atributtes"]
	else:
		data_equipment[equipment_type][slot]["progress"] += 1
		if data_equipment[equipment_type][slot]["progress"] == item_level_dict[str(data_equipment[equipment_type][slot]["level"])]:
			upgrade_level_item(data_equipment[equipment_type][slot], equipment_type, item_data["rarity"])
		
	load_equipment(equipment_type)


func upgrade_level_item(slot_data: Dictionary, type: String, rarity: String) -> void:
	var upgrade: float = 0.0
	var keys: Array = []
	
	slot_data["level"] += 1
	slot_data["progress"] = 0
	
	match rarity:
		"Commom":
			upgrade = 0.15
		"Uncommom":
			upgrade = 0.30
		"elite":
			upgrade = 0.45
		"epic":
			upgrade = 0.60
		"legendary":
			upgrade = 0.75
	
	for key in slot_data["atributtes"].keys():
		keys.append(key)
	
	slot_data["atributtes"][keys[0]] += upgrade
	slot_data["atributtes"][keys[1]] += upgrade
	
	show_bonus_item()


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
		
	show_bonus_item()


func show_bonus_item() -> void:
	var damage: float = 0.0
	var gold: float = 0.0
	var critical_damage: float = 0.0
	var prestige_points: float = 0.0
	
	for key in Player.equipped_items:
		damage += Player.equipped_items[key]["bonus_attributes"]["damage"]
		gold += Player.equipped_items[key]["bonus_attributes"]["gold"]
		critical_damage += Player.equipped_items[key]["bonus_attributes"]["critical_damage"]
		prestige_points += Player.equipped_items[key]["bonus_attributes"]["prestige_points"]
	
	bonus_damage.text = "+ " + str(damage * 100) + "% Damage"
	bonus_gold.text = "+ " + str(gold * 100) + "% Gold"
	bonus_critical_damage.text = "+ " + str(critical_damage * 100) + "% Critical Damage"
	bonus_prestige_points.text = "+ " + str(prestige_points * 100) + "% Prestige Points"


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
