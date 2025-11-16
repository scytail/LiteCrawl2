class_name Door
extends Targetable


var door_direction: SignalBus.Room_Direction
var door_opened: bool


func act(_actor: Targetable) -> bool:
	if (door_opened):
		SignalBus.change_room.emit(door_direction)
		return false  # kill the turn since we're changing scenes
	return true


func react(_actor: Targetable):
	door_opened = true
