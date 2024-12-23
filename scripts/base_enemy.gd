extends StaticBody2D

var health: int = 15 # vida
var max_health: int = 15 # vida maxima

func _ready() -> void:
	increase_health()
	set_progresbar()


func _process(_delta: float) -> void:
	$TextureProgressBar/Label.text = str(health) +  " / " + str(max_health)
	$TextureProgressBar.value = health


func increase_health() -> void: # gerencia a vida conforme o player passa de estagio
	health = (health * World.estagio) / 4
	max_health = health


func set_progresbar() -> void: # atualiza a barra de progresso da vida
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health
