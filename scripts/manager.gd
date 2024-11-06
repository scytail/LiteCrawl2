extends Node


@export
var enemy_spawn_range: Vector2i
@export
var enemy_scene_path: String

var targetables: Array[Enemy] = []


func _ready():
	_spawn_baddies()


func _spawn_baddies():
	for enemy_count in range(0, randi_range(enemy_spawn_range.x, enemy_spawn_range.y)):
		var enemy = Enemy.new()
		enemy.health_points = 1
		enemy.attack_points = 1
		targetables.append(enemy)
		
		var enemy_scene = load(enemy_scene_path)
		var enemy_node: Node2D = enemy_scene.instantiate()
		enemy_node.position = Vector2(128,64)
		add_child(enemy_node)
