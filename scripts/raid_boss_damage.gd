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
