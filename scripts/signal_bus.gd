extends Node


@warning_ignore("unused_signal")
signal change_room(direction: Room_Direction)
enum Room_Direction{
	left,
	down,
	up,
	right
}
