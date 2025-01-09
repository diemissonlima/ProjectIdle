extends StaticBody2D

enum EnemyType {
	NORMAL, BOSS
}

var enemy_type: EnemyType = EnemyType.NORMAL
var health: float = 0.0 # vida
var max_health: float = 0.0

var dropped_gold: int
var drop_items_list: Dictionary = {}


func _ready() -> void:
	drop_items_list = get_drop_items()
	set_enemy_type()
	increase_health()
	set_progresbar()
	drop()


func _process(_delta: float) -> void:
	$TextureProgressBar/Label.text = str(round(health)) +  " / " + str(round(max_health))
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
		EnemyType.NORMAL:
			max_health = max_health * 1.10
		
		EnemyType.BOSS:
			max_health += max_health * 10
		
	health = max_health


func drop() -> void:
	var base_gold: int = randi_range(0, 5)
	
	match enemy_type:
		0: # enemy NORMAL
			base_gold += 5 + (World.estagio * 2)

		1: # enemy BOSS
			base_gold += (20 + World.estagio * 8) * 2
	
	if World.reset > 0:
		var percent: float = World.reset * 0.5
		base_gold += base_gold * percent
		
	if Player.gold_skill_on:
		base_gold *= Player.increase_gold_multiplier
		
	dropped_gold = round(base_gold)
	
		#for item in drop_items_list:
			#var spawn_probability: float = drop_items_list[item]["drop_chance"]
			#var rng: float = randf()
			#
			#print("Spawn Probability; ", spawn_probability)
			#print("RNG: ", rng)
			#
			#if rng <= spawn_probability:
				#drop_item(item, drop_items_list[item])
		#
		#print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")


func get_drop_items() -> Dictionary:
	return {
		"arma": {
			"path": "caminho da imagem",
			"type": "equipment",
			"drop_chance": 0.15,
			"attributes": {
				"damage": 15,
				"critical_chance": 0.10,
				"critical_damage": 0.50
			}
		},
		
		"armor": {
			"path": "caminho da imagem",
			"type": "equipment",
			"drop_chance": 0.20,
			"attributes": {
				"gold_multiplier": 2.0,
				"attack_speed": 0.1 
			}
		},
		
		"gem": {
			"path": "caminho da imagem",
			"type": "resource",
			"drop_chance": 0.40
		}
	}


func drop_item(item_name: String, item_data: Dictionary) -> void:
	print("Nome do item: ", item_name)
	print("Dados do item: ", item_data)


func set_progresbar() -> void: # atualiza a barra de progresso da vida
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health
