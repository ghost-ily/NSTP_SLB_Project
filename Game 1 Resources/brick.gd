extends RigidBody2D

@onready var mouse_area: Area2D = $mouseArea
var has_mouse: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click") && has_mouse:
		self.position = get_global_mouse_position()
		


func _on_mouse_area_mouse_shape_entered(shape_idx: int) -> void:
	has_mouse = true


func _on_mouse_area_mouse_shape_exited(shape_idx: int) -> void:
	has_mouse = false
