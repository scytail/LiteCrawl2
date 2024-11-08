class_name Enemy
extends Targetable

var health_points: int
var attack_points: int


func type():
	return "Enemy"


func act(target: Enemy):
	scene.do_attack_animation(target.scene)
	target.health_points -= attack_points
