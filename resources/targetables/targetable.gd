class_name Targetable

var scene: Node2D
var spawn_coords: Vector2


## Triggers when the targetable acts
func act(target: Targetable):
	target.react(self)


## Triggers when the targetable is acted on
func react(_actor: Targetable):
	pass
