extends BaseEnemy
class_name RaidBossDamage


func _ready() -> void:
	set_enemy_type()
	increase_health()


func set_enemy_type() -> void:
	enemy_type = EnemyType.BOSS_RAID_DAMAGE


func increase_health():
	health = Data.data_management["raids"]["raid_damage"]["hp"]
	max_health = health
	
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health


func next_health() -> void:
	var new_base_health = Data.data_management["raids"]["raid_damage"]["hp"]
	var new_scaling_factor: float = 1.05  # Fator de crescimento exponencial
	
	var new_health = new_base_health * pow(
		new_scaling_factor, Data.data_management["raids"]["raid_damage"]["level"]
		)
		
	Data.data_management["raids"]["raid_damage"]["level"] += 1
	Data.data_management["raids"]["raid_damage"]["hp"] = new_health
