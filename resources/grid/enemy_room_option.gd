class_name EnemyRoomOption
extends Resource

@export
var enemy_spawn_range: Vector2i
@export_range(0,100)
var cat_spawn_chance: int


func generate_room(left: bool, down: bool, up: bool, right: bool) -> RoomData:
	var room_data = RoomData.new()
	room_data.targetables.append_array(_generate_baddies())
	room_data.targetables.append_array(_generate_goodies())
	room_data.targetables.append_array(_generate_doors(left, down, up, right))
	return room_data


## Creates bad stuff in the game
func _generate_baddies() -> Array[Targetable]:
	var baddies: Array[Targetable] = []
	var baddie_x_spawn = 64
	for enemy_counter in range(0, randi_range(enemy_spawn_range.x, enemy_spawn_range.y)):
		var enemy = Fightable.new()
		enemy.health_points = 1
		enemy.attack_points = 1
		enemy.spawn_coords = Vector2(baddie_x_spawn, 64)
		baddies.append(enemy)
		
		baddie_x_spawn += 32
	
	return baddies


## Creates good stuff in the game
func _generate_goodies() -> Array[Targetable]:
	var goodies: Array[Targetable] = []
	if randi_range(0,99) < cat_spawn_chance:
		var cat = Cat.new()
		cat.spawn_coords = Vector2(192, 96)
		goodies.append(cat)
	
	return goodies


## Creates doors to leave the room
func _generate_doors(left: bool, down: bool, up: bool, right: bool) -> Array[Targetable]:
	var doors: Array[Targetable] = []
	if left:
		var door = Door.new()
		door.spawn_coords = Vector2(8, 96)
		door.door_direction = SignalBus.Room_Direction.left
		doors.append(door)
	if down:
		var door = Door.new()
		door.spawn_coords = Vector2(128, 184)
		door.door_direction = SignalBus.Room_Direction.down
		doors.append(door)
	if up:
		var door = Door.new()
		door.spawn_coords = Vector2(128, 24)
		door.door_direction = SignalBus.Room_Direction.up
		doors.append(door)
	if right:
		var door = Door.new()
		door.spawn_coords = Vector2(248, 96)
		door.door_direction = SignalBus.Room_Direction.right
		doors.append(door)
	return doors
