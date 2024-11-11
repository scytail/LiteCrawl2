class_name LevelGrid
extends Resource


@export
var grid_dimensions: Vector2i
@export
var room_options: Array[EnemyRoomOption]

var current_room = -1
var _room_list: Array[Array] = []
