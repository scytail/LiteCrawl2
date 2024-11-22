class_name LevelGrid
extends Resource


@export
var grid_dimensions: Vector2i
@export
var room_options: Array[EnemyRoomOption]

var current_room_coords = Vector2i()
var _room_grid: Array[Array] = []


func generate_grid():
	for i in range(0, grid_dimensions.x):
		_room_grid.append([])
		for j in range(0, grid_dimensions.y):
			var selected_room_option = room_options.pick_random()
			
			# TODO: need a new way to store GENERATED rooms versus their potential options
			#       This will just reuse the same class instance for every room it's used and keep overwriting itself
			selected_room_option.generate_targetables()
			_room_grid[i].append(selected_room_option)

func get_room(room_coords: Vector2i) -> EnemyRoomOption:
	return _room_grid[room_coords.x][room_coords.y]
