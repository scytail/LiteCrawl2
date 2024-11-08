extends CharacterBody2D


const SPEED = 100.0
const _animation_cycle_time = 0.15

var is_done_animating = true


var _do_attack_anim = false
var _target:Node2D
var _time_since_anim_start = 0

func _physics_process(delta):
	if (_do_attack_anim):
		if _time_since_anim_start < _animation_cycle_time/2.0:
			velocity = position.direction_to(_target.position) * SPEED
			_time_since_anim_start += delta
		elif _time_since_anim_start < _animation_cycle_time:
			# move back to starting position
			velocity = -position.direction_to(_target.position) * SPEED
			_time_since_anim_start += delta
		else:
			velocity = Vector2()
			_do_attack_anim = false
			_time_since_anim_start = 0
			is_done_animating = true

	move_and_slide()


func do_attack_animation(target: Node2D):
	_target = target
	_do_attack_anim = true
	is_done_animating = false
