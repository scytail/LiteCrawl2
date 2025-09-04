class_name Buff_Strength
extends Targetable

var buff_amount: int

func react(actor: Targetable):
	if actor is Fightable:
		(actor as Fightable).attack_points += buff_amount
