extends Control


@export_category("Objetos")
@export var weapon_container: GridContainer
@export var shield_container: GridContainer
@export var ring_container: GridContainer
@export var necklace_container: GridContainer
@export var armor_container: GridContainer
@export var helm_container: GridContainer
@export var glove_container: GridContainer
@export var boot_container: GridContainer
@export var belt_container: GridContainer

@export var progress_bar: TextureProgressBar
@export var drop_item_level_label: Label
@export var current_exp_drop_level: Label
@export var drop_chance_container: VBoxContainer

var drop_item_level_dict: Dictionary = {
	"1": 10, "2": 15, "3": 20, "4": 25, "5": 30,
	"6": 35, "7": 40, "8": 45, "9": 50, "10": 60
}

var item_level_dict: Dictionary = {
	"1": 1, "2": 2, "3": 3, "4": 4, "5": 5,
	"6": 6, "7": 7, "8": 8, "9": 9, "10": 10,
	"11": 11, "12": 12, "13": 13, "14": 14, "15": 15,
	"16": 16, "17": 17, "18": 18, "19": 19, "20": 20
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
	load_equipment("armor")
	load_equipment("helm")
	load_equipment("glove")
	load_equipment("boot")
	load_equipment("belt")
	
	show_item_level_drop()
	show_drop_chance()


func connect_button_signal() -> void:
	for button in weapon_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in shield_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in ring_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in necklace_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in armor_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
		
	for button in helm_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in glove_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in boot_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))
	
	for button in belt_container.get_children():
		button.pressed.connect(on_button_pressed.bind(button))


func on_button_pressed(button: TextureButton) -> void:
	var sprite_path: String = button.get_node("BG/Sprite").texture.resource_path
	show_item_info(button.get_parent().name, button.name, sprite_path) # tentar passando o button ao inves de o nome
	selected_button = button
	$Background/ItemInfo.visible = true


func show_item_info(container: String, button_name: String, sprite_path: String) -> void:
	var item_texture: TextureRect = $Background/ItemInfo/BGColor/BGItemInfo/Sprite
	var item_name: RichTextLabel = $Background/ItemInfo/BGInfo/ItemName
	var atributte_1: Label = $Background/ItemInfo/BGInfo/Atributte1
	var atributte_2: Label = $Background/ItemInfo/BGInfo/Atributte2
	var rarity: String = get_rarity_item(button_name.to_lower())
	var text_color: Color = Color.WHITE
	
	match container:
		"WeaponContainer":
			container = "weapon"
		"ShieldContainer":
			container = "shield"
		"RingContainer":
			container = "ring"
		"NecklaceContainer":
			container = "necklace"
		"ArmorContainer":
			container = "armor"
		"HelmContainer":
			container = "helm"
		"GloveContainer":
			container = "glove"
		"BootContainer":
			container = "boot"
		"BeltContainer":
			container = "belt"
	
	equipment_type = container
	selected_item = data_equipment[container][button_name.to_lower()]
	
	item_texture.texture = load(sprite_path)
	
	var keys: Array = []
	for key in data_equipment[container][button_name.to_lower()]["atributtes"].keys():
		keys.append(key)
		
	if rarity == "Commom":
		$Background/ItemInfo/BGColor.color = Color(0, 255, 255)
		text_color = Color(0, 255, 255)
	elif rarity == "Uncommom":
		$Background/ItemInfo/BGColor.color = Color(0, 255, 0)
		text_color = Color(0, 255, 0)
	elif rarity == "Elite":
		$Background/ItemInfo/BGColor.color = Color(255, 0, 255)
		text_color = Color(255, 0, 255)
	elif rarity == "Epic":
		$Background/ItemInfo/BGColor.color = Color(255, 255, 0)
		text_color = Color(255, 255, 0)
	elif rarity == "Legendary":
		$Background/ItemInfo/BGColor.color = Color(255, 0, 0)
		text_color = Color(255, 0, 0)
	
	item_name.text = "[center][color=%s]%s[/color][/center]" % [
		text_color.to_html(), rarity + " " + container.capitalize() + " Lvl " \
		+ str(data_equipment[container][button_name.to_lower()]["level"])
		]
	
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
		"necklace": necklace_container,
		"armor": armor_container,
		"helm": helm_container,
		"glove": glove_container,
		"boot": boot_container,
		"belt": belt_container
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
				"armor":
					Player.handler_item("equip", "armor", slot.name)
				"helm":
					Player.handler_item("equip", "helm", slot.name)
				"glove":
					Player.handler_item("equip", "glove", slot.name)
				"boot":
					Player.handler_item("equip", "boot", slot.name)
				"belt":
					Player.handler_item("equip", "belt", slot.name)
					
		else:
			slot.get_node("BG/Equipped").visible = false


func add_item(item_data: Dictionary) -> void:
	var equipment_type: String = item_data["type"]
	var slot: String = item_data["slot"]
	
	if data_equipment[equipment_type][slot]["is_locked"]:
		data_equipment[equipment_type][slot]["is_locked"] = false
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
			upgrade = 1.50
		"Uncommom":
			upgrade = 2.0
		"elite":
			upgrade = 4.0
		"epic":
			upgrade = 7.5
		"legendary":
			upgrade = 10.0
	
	for key in slot_data["atributtes"].keys():
		keys.append(key)
	
	slot_data["atributtes"][keys[0]] += upgrade
	slot_data["atributtes"][keys[1]] += upgrade


func show_item_level_drop() -> void:
	if World.current_exp_item_drop >= drop_item_level_dict[str(World.item_drop_level)]:
		World.item_drop_level += 1
		World.current_exp_item_drop = 0
		show_drop_chance()
	
	drop_item_level_label.text = "Item Level: " + str(World.item_drop_level)
	current_exp_drop_level.text = str(World.current_exp_item_drop) + " / " \
	+ str(drop_item_level_dict[str(World.item_drop_level)])
	
	progress_bar.max_value = drop_item_level_dict[str(World.item_drop_level)]
	progress_bar.value = World.current_exp_item_drop


func show_drop_chance() -> void:
	var probability: Dictionary = World.rarity_level_probability[World.item_drop_level]
	
	for child in drop_chance_container.get_children():
		match child.name.to_lower():
			"commom":
				child.text = "Comum: " + str(
					probability["commom"] * 100
				) + "%"
				
			"uncommom":
				child.text = "Incomum: " + str(
					(probability["uncommom"] * 100) - (probability["commom"] * 100)
				) + "%"
			
			"elite":
				if probability["elite"] == 0.0:
					child.text = "Elite: " + str(0) + "%"
				else:
					child.text = "Elite: " + str(
						(probability["elite"] * 100) - (probability["uncommom"] * 100)
					) + "%"
				
			"epic":
				if probability["epic"] == 0.0:
					child.text = "Épico: " + str(0) + "%"
				else:
					child.text = "Épico: " + str(
						(probability["epic"] * 100) - (probability["elite"] * 100)
					) + "%"
				
			"legendary":
				if probability["legendary"] == 0.0:
					child.text = "Lendário: " + str(0) + "%"
				else:
					child.text = "Lendário: " + str(
						(probability["legendary"] * 100) - (probability["epic"] * 100)
					) + "%"


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
	armor_container.visible = false
	helm_container.visible = false
	glove_container.visible = false
	boot_container.visible = false
	belt_container.visible = false


func _on_sword_tab_pressed() -> void:
	weapon_container.visible = true
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = false
	armor_container.visible = false
	helm_container.visible = false
	glove_container.visible = false
	boot_container.visible = false
	belt_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_shield_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = true
	ring_container.visible = false
	necklace_container.visible = false
	armor_container.visible = false
	helm_container.visible = false
	glove_container.visible = false
	boot_container.visible = false
	belt_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_ring_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = true
	necklace_container.visible = false
	armor_container.visible = false
	helm_container.visible = false
	glove_container.visible = false
	boot_container.visible = false
	belt_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_necklace_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = true
	armor_container.visible = false
	helm_container.visible = false
	glove_container.visible = false
	boot_container.visible = false
	belt_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_armor_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = false
	armor_container.visible = true
	helm_container.visible = false
	glove_container.visible = false
	boot_container.visible = false
	belt_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_helm_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = false
	armor_container.visible = false
	helm_container.visible = true
	glove_container.visible = false
	boot_container.visible = false
	belt_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_glove_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = false
	armor_container.visible = false
	helm_container.visible = false
	glove_container.visible = true
	boot_container.visible = false
	belt_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_boot_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = false
	armor_container.visible = false
	helm_container.visible = false
	glove_container.visible = false
	boot_container.visible = true
	belt_container.visible = false
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_belt_tab_pressed() -> void:
	weapon_container.visible = false
	shield_container.visible = false
	ring_container.visible = false
	necklace_container.visible = false
	armor_container.visible = false
	helm_container.visible = false
	glove_container.visible = false
	boot_container.visible = false
	belt_container.visible = true
	
	if $Background/ItemInfo.visible == true:
		$Background/ItemInfo.visible = false


func _on_status_mouse_entered() -> void:
	$Background/Title.hide()
	
	$Background/ItemLevel.show()
	$Background/ProgressBar.show()
	$Background/DropChance.show()


func _on_status_mouse_exited() -> void:
	$Background/Title.show()
	
	$Background/ItemLevel.hide()
	$Background/ProgressBar.hide()
	$Background/DropChance.hide()
