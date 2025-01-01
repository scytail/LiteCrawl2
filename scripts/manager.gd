extends Node


@export
var gridTemplate: LevelGridTemplate

@export_category("Scenes")
@export_file("*.tscn")
var enemy_scene_path: String
@export_file("*.tscn")
var cat_scene_path: String

var selected_target: int = 0
var player: Player

# -1 is player, everything else is a targetable index
var _turn_index = -1
# whether or not the turn is in progress or if it just started
var _turn_in_progress = false


## Init the game!
func _ready():
	player = Player.new()
	player.health_points = 10
	player.attack_points = 1
	player.scene = $Player
	
	gridTemplate.generate_grid()
	_spawn_targetable_scenes()
	
	_update_pointer_selection(0)
	_move_pointer(selected_target)


## Handles firing the turn sequence whenever a player inputs an action
func _unhandled_key_input(event):
	if (_turn_index == -1):
		if event.is_action_pressed("change target"):
			_update_pointer_selection(1)
			_move_pointer(selected_target)
		if event.is_action_pressed("action"):
			var targetables = gridTemplate.get_room(gridTemplate.current_room_coords).targetables
			if (selected_target < 0 || selected_target >= targetables.size()):
				return
			_turn_in_progress = _do_targetable_actions(_turn_index)


## When able, jumps through the turn order, allowing enemies to do their 
## animations in the process
func _process(_delta):
	if !_turn_in_progress && _turn_index != -1:
		_turn_in_progress = _do_targetable_actions(_turn_index)
		# if the action didn't fire, move to the next turn
		if !_turn_in_progress:
			_change_turn()
	elif _turn_in_progress:
		var current_actor: Targetable
		if _turn_index < 0:
			current_actor = player
		else:
			var targetables = gridTemplate.get_room(gridTemplate.current_room_coords).targetables
			current_actor = targetables[_turn_index]
			
		if current_actor.scene.is_done_animating:
			_change_turn()


## Moves to the next turn, managing turn order and any flags that need setting
func _change_turn():
	_validate_targetables()
	_turn_in_progress = false
	_turn_index += 1
	if _turn_index >= gridTemplate.get_room(gridTemplate.current_room_coords).targetables.size():
		_turn_index = -1 


## Spawns scenes of any targetables in the current room
func _spawn_targetable_scenes():
	# TODO: might be better to store the path and maybe the spawn coords 
	#       somehow in the targetable
	var baddie_x_spawn = 64
	for targetable in gridTemplate.get_room(gridTemplate.current_room_coords).targetables:
		if targetable.type() == "Enemy":
			_instantiate_scene(targetable, enemy_scene_path, Vector2(baddie_x_spawn, 64))
			baddie_x_spawn += 32
		else:
			_instantiate_scene(targetable, cat_scene_path, Vector2(192, 96))


## Spawns a scene within the game
func _instantiate_scene(targetable: Targetable, scene_path: String, position: Vector2):
	var scene: PackedScene = load(scene_path)
	var node: Node2D = scene.instantiate()
	node.position = position
	targetable.scene = node
	add_child(node)


## Handles the logic of moving around the pointer within code
func _update_pointer_selection(shift_index: int):
	var targetables = gridTemplate.get_room(gridTemplate.current_room_coords).targetables
	if targetables.size() == 0:
		selected_target = -1
		$Pointer.queue_free()
		return
	
	selected_target = (selected_target + shift_index) % targetables.size()


## Visually moves the pointer around the game based on the code logic
func _move_pointer(index: int):
	var targetables = gridTemplate.get_room(gridTemplate.current_room_coords).targetables
	if targetables.size() <= index || index < 0:
		return
	$Pointer.position = targetables[index].scene.position - Vector2(0, 16)


## Fires off the action sequence for a character, returning whether
## the action fired successfully or not
func _do_targetable_actions(turn_index) -> bool:
	var targetables = gridTemplate.get_room(gridTemplate.current_room_coords).targetables
	if turn_index >= targetables.size():
		return false
		
	var actor: Targetable
	var target: Targetable
	if turn_index == -1:
		actor = player
		target = targetables[selected_target]
	else:
		actor = targetables[turn_index]
		target = player
	actor.act(target)
	return true


## Validates the existence of targetables within the game and handles removing
## them if need be
func _validate_targetables():
	if (player.health_points <= 0):
		# TODO: end game
		player.scene.queue_free()
		
	for targetable: Targetable in gridTemplate.get_room(gridTemplate.current_room_coords).targetables:
		if targetable.type() == "Enemy":
			if targetable.health_points <= 0:
				targetable.scene.queue_free()
				gridTemplate.get_room(gridTemplate.current_room_coords).targetables.erase(targetable)
				
				# Update cursor
				_update_pointer_selection(0)
				_move_pointer(selected_target)
