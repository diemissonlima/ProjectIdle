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
	
	progress_bar.max_value = max_health
	progress_bar.value = health


func next_health() -> void:
	var base_health = 50000
	var scaling_factor: float = 1.50  # Fator de crescimento exponencial
	
	var health = base_health * pow(
		scaling_factor, Data.data_management["raids"]["raid_damage"]["level"]
		)
	
	Data.data_management["raids"]["raid_damage"]["hp"] = health
