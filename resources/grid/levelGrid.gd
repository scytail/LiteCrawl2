class_name LevelGrid


## The grid coordinates of the room the player is currently in
var current_room_coords = Vector2i()

var _room_grid: Array[Array]


func new():
	reset_grid()


## Adds a room to the room grid, leaving empty spaces in the grid along the way if needed
func add_room(room_coords: Vector2i, room_data: RoomData):
	# Init the grid if needed
	if _room_grid == null:
		_room_grid = []
	# expand the grid rows if needed
	while _room_grid.size() <= room_coords.x:
		_room_grid.append([])
	# expand the grid columns if needed
	while _room_grid[room_coords.x].size() < room_coords.y:
		_room_grid[room_coords.x].append(null)
	_room_grid[room_coords.x].append(room_data)


## Retrieves the room at the given coordinates
func get_room(room_coords: Vector2i) -> RoomData:
	return _room_grid[room_coords.x][room_coords.y]


## Resets the grid to an empty state, preserving the created grid dimensions if needed
func reset_grid(preserve_dimensions: bool = false):
	if !preserve_dimensions:
		_room_grid = []
		return
	
	for room_row in _room_grid:
		for y in range(0,room_row.size()):
			room_row[y] = null
