class_name Targetable
extends Resource

var scene: Node2D
var spawn_coords: Vector2


## The type of targetable
func type():
	return "Targetable"


## Triggers when the targetable acts
func act(_target: Targetable):
	pass


## Triggers when the targetable is acted on
func act_on(_actor: Targetable):
	pass
