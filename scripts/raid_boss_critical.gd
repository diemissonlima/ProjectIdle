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
	
	progress_bar.max_value = max_health
	progress_bar.value = health


func next_health() -> void:
	var base_health = 100000
	var scaling_factor: float = 1.475  # Fator de crescimento exponencial
	
	var health = base_health * pow(
		scaling_factor, Data.data_management["raids"]["raid_critical"]["level"]
		)
	
	Data.data_management["raids"]["raid_critical"]["hp"] = health
