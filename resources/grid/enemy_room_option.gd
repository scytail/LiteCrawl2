class_name EnemyRoomOption
extends Resource

@export
var enemy_spawn_range: Vector2i
@export_range(0,100)
var cat_spawn_chance: int


func generate_room() -> RoomData:
	var room_data = RoomData.new()
	room_data.targetables.append_array(_generate_baddies())
	room_data.targetables.append_array(_generate_goodies())
	return room_data


## Creates bad stuff in the game
func _generate_baddies() -> Array[Targetable]:
	var baddies: Array[Targetable] = []
	for enemy_counter in range(0, randi_range(enemy_spawn_range.x, enemy_spawn_range.y)):
		var enemy: Enemy = Enemy.new()
		enemy.health_points = 1
		enemy.attack_points = 1
		baddies.append(enemy)
	
	return baddies


## Creates good stuff in the game
func _generate_goodies() -> Array[Targetable]:
	var goodies: Array[Targetable] = []
	if randi_range(0,99) < cat_spawn_chance:
		var cat: Targetable = Targetable.new()
		goodies.append(cat)
	
	return goodies
