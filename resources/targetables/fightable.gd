class_name Fightable
extends Targetable

var health_points: int
var attack_points: int


func type():
	return "Fightable"


func act(target: Targetable):
	scene.do_attack_animation(target.scene)
	target.act_on(self)
	

func act_on(actor: Targetable):
	# TODO: actor should dictate how it's acting on the target, not
	#       the other way around
	if actor.type() == "Fightable":
		health_points -= actor.attack_points
