extends StaticBody2D
class_name BaseEnemy


@export var id: int
@export var progress_bar: TextureProgressBar
@export_enum(
	"Warrior", "Fighting Fairy", "Spirit", "Angel", "Dark Ladie",
	"Dark Beast", "Earth Beast", "Warrior Goddess", "Wizard", "Combat Girl",
	"Sorceress", "Golem", "Necromancer", "Troll", "Attack Golem"
) var type: String

var tween: Tween

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
	var base_health: float = 5.0  # Vida inicial
	var scaling_factor: float = 1.075  # Fator de crescimento exponencial
	max_health = base_health * pow(scaling_factor, World.estagio)
	
	match enemy_type:
		EnemyType.BOSS:
			max_health += max_health * 10
		
	health = max_health


func animate_health_bar(damage: int) -> void:
	var new_health = max(health - damage, 0)
	
	tween = get_tree().create_tween()
	
	if tween and is_instance_valid(progress_bar):
		tween.tween_property(
			progress_bar, "value", new_health, 1.0
			).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func calculate_exp() -> float:
	var exp_base: int = 1
	var scaling_factor: float = 1.025
	var exp = exp_base * pow(scaling_factor, World.estagio)
	
	return exp


func drop() -> void:
	var base_gold: int = 0
	var scaling_factor: float = 1.025  # Fator de crescimento exponencial
	var gold_raid_multiplier: float = Data.data_management["raids"]["raid_gold"]["multiplier"]
	var gold_upgrade_multiplier: float = Data.data_management["upgrades"]["gold"]["multiplier"]
	var levelup_multiplier: float = Data.data_management["player"]["upgrade_level_up"]
	var equipment_gold_multiplier: float = (
		+ Player.equipped_items["shield"]["bonus_attributes"]["gold"] \
		+ Player.equipped_items["necklace"]["bonus_attributes"]["gold"] \
		+ Player.equipped_items["armor"]["bonus_attributes"]["gold"] \
		+ Player.equipped_items["glove"]["bonus_attributes"]["gold"] \
		+ Player.equipped_items["belt"]["bonus_attributes"]["gold"]
	)
	
	var total_gold_multiplier: float = (
		gold_raid_multiplier + gold_upgrade_multiplier + equipment_gold_multiplier + levelup_multiplier
	)
	
	match enemy_type:
		0: # enemy NORMAL
			base_gold += 5 + (World.estagio * 5)
			
		1: # enemy BOSS
			base_gold += 10 + (World.estagio * 10)
	
	base_gold += base_gold * pow(scaling_factor, World.estagio)
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
		"weapon", "shield", "ring", "necklace", 
		"armor", "helm", "glove", "boot", "belt"
	]
	var attribute_range: Array = []
	
	var item_attribute_1: String = ""
	var item_attribute_2: String = ""
	
	var item_data: Dictionary = {}
	
	equipment_type = type_list.pick_random()
	
	match equipment_type:
		"weapon":
			item_attribute = ["damage", "critical_damage"]
		
		"shield":
			item_attribute = ["damage", "gold"]
		
		"ring":
			item_attribute = ["critical_damage", "prestige_points"]
		
		"necklace":
			item_attribute = ["prestige_points", "gold"]
		
		"armor":
			item_attribute = ["damage", "gold"]
		
		"helm":
			item_attribute = ["critical_damage", "prestige_points"]
			
		"glove":
			item_attribute = ["gold", "critical_damage"]
			
		"boot":
			item_attribute = ["damage", "prestige_points"]
			
		"belt":
			item_attribute = ["gold", "critical_damage"]
	
	item_attribute_1 = item_attribute.pick_random()
	item_attribute_2 = item_attribute.pick_random()
	
	var probability = World.rarity_level_probability[World.item_drop_level]
	rng = randf()
	
	for key in ["commom", "uncommom", "elite", "epic", "legendary"]:
		if rng <= probability[key]:
			rarity = key.capitalize()
			break
	
	match rarity:
		"Commom":
			slot_list = ["slot1", "slot2", "slot3", "slot4", "slot5"]
			attribute_range = [50, 100]
			color_message = Color.SKY_BLUE
		
		"Uncommom":
			slot_list = ["slot6", "slot7", "slot8", "slot9", "slot10"]
			attribute_range = [200, 300]
			color_message = Color.GREEN
		
		"Elite":
			slot_list = ["slot11", "slot12"]
			attribute_range = [400, 500]
			color_message = Color.FUCHSIA
		
		"Epic":
			slot_list = ["slot13", "slot14"]
			attribute_range = [600, 800]
			color_message = Color.GOLD
		
		"Legendary":
			slot_list = ["slot15"]
			attribute_range = [800, 1000]
			color_message = Color.RED
	
	while item_attribute_2 == item_attribute_1:
		item_attribute_2 = item_attribute.pick_random()
		if item_attribute_2 != item_attribute_1:
			break
	
	var attribute_value_1: float = (randi_range(attribute_range[0], attribute_range[1]) / 100.0)
	var attribute_value_2: float = (randi_range(attribute_range[0], attribute_range[1]) / 100.0)
	
	slot = slot_list.pick_random()
	
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
	
	get_tree().call_group(
		"loot_box", "add_message", "lootbox_2", drop_message, color_message
		)
	
	get_tree().call_group("equipments", "add_item", item_data)


func set_progresbar() -> void: # atualiza a barra de progresso da vida
	progress_bar.max_value = max_health
	progress_bar.value = health
