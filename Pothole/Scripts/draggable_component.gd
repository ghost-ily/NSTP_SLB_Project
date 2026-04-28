extends Node2D

var is_dragging = false
@export var speed = 1000

func move(object: CharacterBody2D, origin: Node2D, delta: float) -> void:
	if is_dragging:
		object.position = get_global_mouse_position()
	else:
		object.position = object.position.move_toward(origin.position, speed * delta)
		
func set_dragging(state: bool) -> void:
	is_dragging = state
