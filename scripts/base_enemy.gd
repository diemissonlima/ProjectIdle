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
	
	#match enemy_type:
		#EnemyType.WEAK:
			#print("Inimigo é do tipo WEAK")
		#EnemyType.NORMAL:
			#print("Inimigo é do tipo NORMAL")
		#EnemyType.ELITE:
			#print("Inimigo é do tipo ELITE")


func increase_health() -> void:
	match enemy_type:
		EnemyType.WEAK:
			health = max_health * (1 + (World.estagio ** 0.4) / 12)
			
		EnemyType.NORMAL:
			health = max_health * (1 + (World.estagio ** 0.5) / 10)
			
		EnemyType.ELITE:
			health = max_health * (1 + (World.estagio ** 0.6) / 8)
	
	max_health = health


func set_progresbar() -> void: # atualiza a barra de progresso da vida
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health
