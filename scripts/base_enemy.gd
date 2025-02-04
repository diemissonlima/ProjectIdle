extends StaticBody2D
class_name BaseEnemy


@export var id: int

enum EnemyType {
	NORMAL, BOSS, BOSS_RAID_DAMAGE, BOSS_RAID_GOLD, BOSS_RAID_CRITICAL
}

var enemy_type: EnemyType = EnemyType.NORMAL
var health: float = 0.0 # vida
var max_health: float = 0.0

var dropped_gold: int


func _ready() -> void:
	set_enemy_type()
	increase_health()
	set_progresbar()


func _process(_delta: float) -> void:
	$TextureProgressBar/Label.text = str(
		World.format_number(round(health)) + " / " + str(World.format_number(round(max_health)))
	)
	$TextureProgressBar.value = health


func set_enemy_type() -> void:
	if World.stage_progress < 10:
		enemy_type = EnemyType.NORMAL
	else:
		enemy_type = EnemyType.BOSS


func increase_health() -> void:
	var base_health: float = 10.0  # Vida inicial
	var scaling_factor: float = 1.10  # Fator de crescimento exponencial
	max_health = base_health * pow(scaling_factor, World.estagio)
	
	match enemy_type:
		EnemyType.BOSS:
			max_health += max_health * 10
		
	health = max_health


func drop() -> void:
	var base_gold: int = 3
	var gold_raid_multiplier: float = Data.data_management["raids"]["raid_gold"]["multiplier"]
	var gold_upgrade_multiplier: float = Data.data_management["upgrades"]["gold"]["multiplier"]
	var equipment_gold_multiplier: float = (
		Player.equipped_items["weapon"]["bonus_attributes"]["gold"] \
		+ Player.equipped_items["shield"]["bonus_attributes"]["gold"] \
		+ Player.equipped_items["ring"]["bonus_attributes"]["gold"] \
		+ Player.equipped_items["necklace"]["bonus_attributes"]["gold"]
	)

	var total_gold_multiplier: float = gold_raid_multiplier + gold_upgrade_multiplier + equipment_gold_multiplier
	
	match enemy_type:
		0: # enemy NORMAL
			base_gold += 5 + (World.estagio * 2)

		1: # enemy BOSS
			base_gold += (20 + World.estagio * 8) * 2
		
	dropped_gold = round(base_gold + (base_gold * total_gold_multiplier))
	
	if Player.gold_skill_on:
		var skill_multiplier: float = Data.data_management["player"]["skills"]["increase_gold"]["multiplier"] * 100
		var bonus_gold: float = skill_multiplier * dropped_gold / 100
		
		dropped_gold += bonus_gold


func drop_item() -> void:
	var rng: float = 0.0
	var slot: String = ""
	var equipment_type: String = ""
	var rarity: String = ""
	var drop_message: String = ""
	var color_message: Color
	
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
	
	var item_data: Dictionary = {}
	
	
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
	elif rng > 0.95 and rng <= 0.99:
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
	
	drop_message = "Drop: " + equipment_type.capitalize()
	
	item_data = {
		"slot": slot,
		"rarity": rarity,
		"type": equipment_type,
		"atributtes": {
			item_attribute_1: attribute_value_1,
			item_attribute_2: attribute_value_2
		}
	}
	
	if rarity == "Commom":
		color_message = Color.SKY_BLUE
	elif rarity == "Uncommom":
		color_message = Color.GREEN
	elif rarity == "Elite":
		color_message = Color.FUCHSIA
	elif rarity == "Epic":
		color_message = Color.GOLD
	elif rarity == "Legendary":
		color_message = Color.RED
	
	get_tree().call_group(
		"loot_box", "add_message", "lootbox_2", drop_message, color_message
		)
	
	get_tree().call_group("equipments", "add_item", item_data)


func set_progresbar() -> void: # atualiza a barra de progresso da vida
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health
