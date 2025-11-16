class_name Targetable

var scene: Node2D
var spawn_coords: Vector2


## Triggers when the targetable acts
## returns whether the turn should continue
func act(target: Targetable) -> bool:
	target.react(self)
	return true


## Triggers when the targetable is acted on
func react(_actor: Targetable):
	pass
