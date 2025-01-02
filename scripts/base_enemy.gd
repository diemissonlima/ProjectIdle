extends StaticBody2D

enum EnemyType {
	WEAK, NORMAL, ELITE
}

var enemy_type: EnemyType = EnemyType.NORMAL
var health: int = 15 # vida
var max_health: int = 15 # vida maxima

var dropped_gold: int


func _ready() -> void:
	randomize_enemy_type()
	increase_health()
	set_progresbar()


func _process(_delta: float) -> void:
	$TextureProgressBar/Label.text = str(health) +  " / " + str(max_health)
	$TextureProgressBar.value = health


func randomize_enemy_type() -> void:
	var random_value: float = randf()
	if random_value < 0.7:
		enemy_type = EnemyType.WEAK
	elif random_value < 0.95:
		enemy_type = EnemyType.NORMAL
	else:
		enemy_type = EnemyType.ELITE


func increase_health() -> void:
	var base_health = 10  # Vida inicial
	var scaling_factor = 1.10  # Fator de crescimento exponencial
	max_health = base_health * pow(scaling_factor, World.estagio)
	
	match enemy_type:
		EnemyType.NORMAL:
			max_health = max_health * 1.10
			
		EnemyType.ELITE:
			max_health = max_health * 1.20

	if World.stage_progress == 10:
		max_health += max_health * 10
		
	health = max_health


func drop() -> void:
	var base_gold: int = randi_range(0, 5)
	
	match enemy_type:
		0: # enemy WEAK
			base_gold += 5 + (World.estagio * 2)
		
		1: # enemy NORMAL
			base_gold += 10 + (World.estagio * 4)
			
		2: # enemy ELITE
			base_gold += 20 + (World.estagio * 8)
	
	if World.stage_progress == 10:
		base_gold *= 5
	
	if World.reset > 0:
		var percent: float = World.reset * 0.5
		base_gold += base_gold * percent
		
	if Player.gold_skill_on:
		base_gold *= Player.increase_gold_multiplier
	
	dropped_gold = base_gold


func set_progresbar() -> void: # atualiza a barra de progresso da vida
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health
