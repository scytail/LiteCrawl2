class_name Door
extends Targetable


var door_direction: SignalBus.Room_Direction


func act_on(_actor: Targetable):
	SignalBus.change_room.emit(door_direction)
