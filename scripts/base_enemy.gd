extends StaticBody2D

var health: int = 20
var max_health: int = 20

func _ready() -> void:
	increase_health()


func _process(_delta: float) -> void:
	$TextureProgressBar/Label.text = str(health) + " / " + str(max_health)


func take_damage(damage: int) -> void:
	health -= damage
	
	if health <= 0:
		get_tree().call_group("world", "killer_enemy")


func increase_health() -> void:
	var increase = World.estagio * 0.5
	
	print("Estagio: ", World.estagio)
	print("Aumento: ", increase)
	print("Health: ", health)
	print("-=-=-=-=-=-=-=-=-=-=-=-=-=")
	
	max_health += increase
	health += increase


func set_progresbar() -> void:
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health
