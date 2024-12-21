extends Node

@export_category("Objetos")
@export var btn_increase_attack: TextureButton
@export var label_increase_attack: Label
@export var timer_increase_attack: Timer

var timer: int

func _process(_delta: float) -> void:
	format_timer()


func set_label(type: String) -> void:
	match type:
		"duration":
			timer = Player.increase_attack_duration
			
		"cooldown":
			timer = Player.increase_attack_cooldown


func _on_increase_attack_pressed() -> void:
	btn_increase_attack.disabled = true
	btn_increase_attack.self_modulate = -200
	
	set_label("cooldown")
	label_increase_attack.show()
	
	timer_increase_attack.start(timer)
	format_timer()


func format_timer() -> void:
	var seconds = int(timer_increase_attack.time_left)
	label_increase_attack.text = str(seconds)


func _on_timer_timeout() -> void:
	print("Tempo da habilidade acabou!!!")


	#botao de skill
#
#- desabilita o botao para nao ser pressionado mais de uma vez
#
#- quando clicar no botao, ativa o tempo da habilidade e mostra a label contando o tempo ate acabar
#
#- em seguida, aumenta a habilidade referente ao botao
#
#- quando o timer da habilidade terminar, ativa o cooldow e mostra a label
#
#- em seguida volta a habilidade ao normal
#
#- quando cooldow da habilidade terminar, habilita o botao para que possa ser pressionado
