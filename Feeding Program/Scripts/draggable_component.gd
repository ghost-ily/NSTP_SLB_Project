extends Node2D

var is_dragging = false
@export var offset = Vector2(0, -25)
var speed = 1000

func move(object: CharacterBody2D, origin: Node2D, delta: float) -> void:
	if is_dragging:
		object.position = get_global_mouse_position() - offset
	else:
		object.position = object.position.move_toward(origin.global_position - offset, speed * delta)
		
func set_dragging(state: bool) -> void:
	is_dragging = state
