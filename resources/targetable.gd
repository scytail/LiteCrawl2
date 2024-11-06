class_name Targetable
extends Resource

var scene: Node2D

## Triggers when the targetable acts
func act():
	print_debug("targetable acted")

## Triggers when the targetable is acted on
func act_on():
	print_debug("targetable acted on")
