class_name EnemyRoomOption
extends Resource

@export
var enemy_spawn_range: Vector2i
@export_range(0,100)
var cat_spawn_chance: int

var targetables: Array[Targetable] = []


## Create stuff in the room
func generate_targetables():
	targetables.append_array(_generate_baddies())
	targetables.append_array(_generate_goodies())


## Creates bad stuff in the game
func _generate_baddies() -> Array[Targetable]:
	var targetables: Array[Targetable] = []
	for enemy_counter in range(0, randi_range(enemy_spawn_range.x, enemy_spawn_range.y)):
		var enemy: Enemy = Enemy.new()
		enemy.health_points = 1
		enemy.attack_points = 1
		targetables.append(enemy)
	
	return targetables


## Creates good stuff in the game
func _generate_goodies() -> Array[Targetable]:
	var targetables: Array[Targetable] = []
	if randi_range(0,99) < cat_spawn_chance:
		var cat: Targetable = Targetable.new()
		targetables.append(cat)
	
	return targetables
