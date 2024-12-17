extends Control

@export_category("Variaveis")
@export var enemy_list: Array[PackedScene]

var contador: int = 5
var estagio: int = 1

var enemy


func _ready() -> void:
	$Timer.start()
	$Background.texture = load("res://assets/backgrounds/Horizontal/" + str(randi_range(1, 32)) + ".png")
	spawn_enemy()


func _process(_delta: float) -> void:
	$Label2.text = "Stage: " + str(World.estagio)
	
	if contador > 9:
		$Label.text = "00:" + str(contador)
	else:
		$Label.text = "00:0" + str(contador)


func spawn_enemy() -> void:
	enemy = enemy_list.pick_random().instantiate()
	enemy.global_position = $Background/SpawnPosition.global_position
	get_tree().root.call_deferred("add_child", enemy)


func killer_enemy() -> void:
	enemy.queue_free()
	
	contador = 5
	World.estagio += 1
	
	spawn_enemy()
	
	$Background.texture = load("res://assets/backgrounds/Horizontal/" + str(randi_range(1, 32)) + ".png")
	
	$Timer.start()


func _on_timer_timeout() -> void:
	contador -= 1
	get_tree().call_group("enemy", "take_damage", Player.damage)
	
	$Timer.start()
