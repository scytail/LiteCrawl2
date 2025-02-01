class_name LevelGridTemplate
extends Resource


@export
var grid_dimensions: Vector2i
@export
var room_options: Array[EnemyRoomOption]


## Generates a grid instance based on its configuration
func generate_grid() -> LevelGrid:
	var level_grid = LevelGrid.new()
	for x in range(0, grid_dimensions.x):
		for y in range(0, grid_dimensions.y):
			var selected_room_option = room_options.pick_random()
			
			var room_data = selected_room_option.generate_room()
			level_grid.add_room(Vector2(x,y), room_data)
			
	return level_grid
