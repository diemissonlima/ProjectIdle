extends BaseEnemy
class_name RaidBossGold


func _ready() -> void:
	set_enemy_type()
	increase_health()
	

func set_enemy_type() -> void:
	enemy_type = EnemyType.BOSS_RAID_GOLD


func increase_health():
	health = Data.data_management["raids"]["raid_gold"]["hp"]
	max_health = health
	
	progress_bar.max_value = max_health
	progress_bar.value = health


func next_health() -> void:
	var base_health = Data.data_management["raids"]["raid_gold"]["hp"]
	var scaling_factor: float = 1.025 # Fator de crescimento exponencial
	
	var health = base_health * pow(
		scaling_factor, Data.data_management["raids"]["raid_gold"]["level"]
		)
	
	Data.data_management["raids"]["raid_gold"]["hp"] = health
