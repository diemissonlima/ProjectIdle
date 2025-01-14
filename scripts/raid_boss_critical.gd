extends BaseEnemy
class_name RaidBossCritical


func _ready() -> void:
	set_enemy_type()
	increase_health()


func set_enemy_type() -> void:
	enemy_type = EnemyType.BOSS_RAID_CRITICAL


func increase_health():
	health = Data.data_management["raids"]["raid_critical"]["hp"]
	max_health = health
	
	$TextureProgressBar.max_value = max_health
	$TextureProgressBar.value = health


func next_health() -> void:
	var base_health = Data.data_management["raids"]["raid_critical"]["hp"]
	var scaling_factor: float = 1.10  # Fator de crescimento exponencial
	
	var next_health = base_health * pow(
		scaling_factor, Data.data_management["raids"]["raid_critical"]["level"]
		)
	
	Data.data_management["raids"]["raid_critical"]["hp"] = next_health
