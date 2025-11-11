class_name RoomOption
extends Resource


func generate_room(left: bool, down: bool, up: bool, right: bool) -> RoomData:
	var room_data = RoomData.new()
	room_data.targetables.append_array(_generate_doors(left, down, up, right))
	return room_data


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
