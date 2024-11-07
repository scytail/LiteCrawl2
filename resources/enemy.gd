class_name Enemy
extends Targetable

var health_points: int
var attack_points: int


func type():
	return "Enemy"


func act(player: Player):
	player.health_points -= attack_points


func act_on(player: Player):
	health_points -= player.health_points
