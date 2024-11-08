extends Node


@export
var enemy_spawn_range: Vector2i
@export_range(0,100)
var cat_spawn_chance: int

@export_category("Scenes")
@export_file("*.tscn")
var enemy_scene_path: String
@export_file("*.tscn")
var cat_scene_path: String

var selected_target: int = 0
var targetables: Array[Targetable] = []
var player: Player


func _ready():
	player = Player.new()
	player.health_points = 10
	player.attack_points = 1
	player.scene = $Player
	
	_spawn_baddies()
	_spawn_goodies()
	_update_pointer_selection(0)
	_move_pointer(selected_target)


func _spawn_baddies():
	var x_spawn = 64
	for enemy_counter in range(0, randi_range(enemy_spawn_range.x, enemy_spawn_range.y)):
		var enemy: Enemy = Enemy.new()
		enemy.health_points = 1
		enemy.attack_points = 1
		targetables.append(enemy)
		_instantiate_scene(enemy, enemy_scene_path, Vector2(x_spawn,64))
		x_spawn += 32


func _spawn_goodies():
	if randi_range(0,99) < cat_spawn_chance:
		var cat: Targetable = Targetable.new()
		targetables.append(cat)
		_instantiate_scene(cat, cat_scene_path, Vector2(192, 96))


func _instantiate_scene(targetable: Targetable, scene_path: String, position: Vector2):
	var scene: PackedScene = load(scene_path)
	var node: Node2D = scene.instantiate()
	node.position = position
	targetable.scene = node
	add_child(node)


func _update_pointer_selection(shift_index: int):
	if targetables.size() == 0:
		selected_target = -1
		$Pointer.queue_free()
		return
	
	selected_target = (selected_target + shift_index) % targetables.size()


func _unhandled_key_input(event):
	if event.is_action_pressed("change target"):
		_update_pointer_selection(1)
		_move_pointer(selected_target)
	if event.is_action_pressed("action"):
		targetables[selected_target].act_on(player)
		_validate_targetables()
		_do_targetable_actions()


func _move_pointer(index: int):
	if targetables.size() <= index || index < 0:
		return
	$Pointer.position = targetables[index].scene.position - Vector2(0, 16)


func _do_targetable_actions():
	for targetable: Targetable in targetables:
		targetable.act(player)
		_validate_targetables()


func _validate_targetables():
	if (player.health_points <= 0):
		# TODO: end game
		player.scene.queue_free()
		
	for targetable: Targetable in targetables:
		if targetable.type() == "Enemy":
			if targetable.health_points <= 0:
				targetable.scene.queue_free()
				targetables.erase(targetable)
				
				# Update cursor
				_update_pointer_selection(0)
				_move_pointer(selected_target)
