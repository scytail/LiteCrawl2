class_name Fightable
extends Targetable

var health_points: int
var attack_points: int


func act(target: Targetable):
	scene.do_attack_animation(target.scene)
	target.react(self)
	

func react(actor: Targetable):
	# TODO: actor should dictate how it's acting on the target, not
	#       the other way around
	if actor is Fightable:
		health_points -= actor.attack_points
