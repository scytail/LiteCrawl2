extends Node


@export
var enemy_spawn_range: Vector2i
@export
var enemy_scene_path: String

var selected_target: int = 0
var targetables: Array[Enemy] = []


func _ready():
	_spawn_baddies()
	_select_targetable(selected_target)


func _spawn_baddies():
	var x_spawn = 64
	for enemy_counter in range(0, randi_range(enemy_spawn_range.x, enemy_spawn_range.y)):
		var enemy = Enemy.new()
		enemy.health_points = 1
		enemy.attack_points = 1
		targetables.append(enemy)
		
		var enemy_scene = load(enemy_scene_path)
		var enemy_node: Node2D = enemy_scene.instantiate()
		enemy_node.position = Vector2(x_spawn,64)
		enemy.enemy_scene = enemy_node
		add_child(enemy_node)
		x_spawn += 32


func _unhandled_key_input(event):
	if event.is_action_pressed("change target"):
		selected_target += 1
		_select_targetable(selected_target % targetables.size())


func _select_targetable(index: int):
	if targetables.size() <= index:
		return
	$Pointer.position = targetables[index].enemy_scene.position - Vector2(0, 16)
