class_name Door
extends Targetable


var door_direction: SignalBus.Room_Direction


func react(_actor: Targetable):
	SignalBus.change_room.emit(door_direction)
