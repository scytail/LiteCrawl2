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


func _ready():
	_spawn_baddies()
	_spawn_goodies()
	_select_targetable(selected_target)


func _spawn_baddies():
	var x_spawn = 64
	for enemy_counter in range(0, randi_range(enemy_spawn_range.x, enemy_spawn_range.y)):
		var enemy: Enemy = Enemy.new()
		enemy.health_points = 1
		enemy.attack_points = 1
		targetables.append(enemy)
		
		var enemy_scene: PackedScene = load(enemy_scene_path)
		var enemy_node: Node2D = enemy_scene.instantiate()
		enemy_node.position = Vector2(x_spawn,64)
		enemy.scene = enemy_node
		add_child(enemy_node)
		x_spawn += 32


func _spawn_goodies():
	if randi_range(0,99) < cat_spawn_chance:
		var cat: Targetable = Targetable.new()
		targetables.append(cat)
		
		var cat_scene: PackedScene = load(cat_scene_path)
		var cat_node: Node2D = cat_scene.instantiate()
		cat_node.position = Vector2(192, 96)
		cat.scene = cat_node
		add_child(cat_node)


func _unhandled_key_input(event):
	if event.is_action_pressed("change target"):
		selected_target = (selected_target + 1) % targetables.size()
		_select_targetable(selected_target)
	if event.is_action_pressed("action"):
		targetables[selected_target].act_on()
		_do_targetable_actions()


func _select_targetable(index: int):
	if targetables.size() <= index:
		return
	$Pointer.position = targetables[index].scene.position - Vector2(0, 16)


func _do_targetable_actions():
	for targetable: Targetable in targetables:
		targetable.act()
