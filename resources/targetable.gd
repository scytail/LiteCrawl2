class_name Targetable
extends Resource

var scene: Node2D


## The type of targetable
func type():
	return "Targetable"


## Triggers when the targetable acts
func act(player: Player):
	pass


## Triggers when the targetable is acted on
func act_on(player: Player):
	pass
