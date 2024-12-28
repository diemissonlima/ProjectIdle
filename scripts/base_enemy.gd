extends StaticBody2D

enum EnemyType {
	WEAK, NORMAL, ELITE
}

var enemy_type: EnemyType = EnemyType.NORMAL
var health: int = 15 # vida
var max_health: int = 15 # vida maxima


func _ready() -> void:
	randomize_enemy_type()
	increase_health()
	set_progresbar()


func _process(_delta: float) -> void:
	$TextureProgressBar/Label.text = str(health) +  " / " + str(max_health)
	$TextureProgressBar.value = health


func randomize_enemy_type() -> void:
	var random_value: float = randf()
	if random_value < 0.6:
		enemy_type = EnemyType.WEAK
	elif random_value < 0.9:
		enemy_type = EnemyType.NORMAL
	else:
		enemy_type = EnemyType.ELITE


func increase_health() -> void:
	var base_health = 15
	var scaling_factor = 10 # quanto maior, escala mais rapido
	var log_scale = log(1 + World.estagio) * scaling_factor
	max_health = base_health + log_scale
	
	
	#var base_health = 15  # Vida inicial
	#var scaling_factor = 1.1  # Fator de crescimento exponencial
	#max_health = base_health * pow(scaling_factor, World.estagio)
	#health = max_health
	
	print(enemy_type)
	match enemy_type:
		#EnemyType.WEAK:
			#health = max_health * (1 + (World.estagio ** 0.4) / 12)
			
		EnemyType.NORMAL:
			max_health = max_health * 1.10
			
		EnemyType.ELITE:
			max_health = max_health * 1.20

	health = max_health


func set_progresbar() -> void: # atualiza a barra de progresso da vida
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health
