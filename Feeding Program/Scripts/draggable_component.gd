extends Node2D

var is_dragging = false
@export var offset = Vector2(0, -25)
var speed = 1000

func move(object: CharacterBody2D, origin: Node2D, delta: float) -> void:
	if is_dragging:
		object.global_position = get_global_mouse_position()
	else:
		object.global_position = origin.global_position
		
func set_dragging(state: bool) -> void:
	is_dragging = state
