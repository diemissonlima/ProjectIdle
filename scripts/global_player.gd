extends Node

var damage: int = 2
var critical_attack: bool = false
var gold: int


func alter_attack() -> void:
	var chance_critical: float = randf()
	
	if chance_critical < 0.1:
		critical_attack = true
