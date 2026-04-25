extends RigidBody2D

@onready var mouse_area: Area2D = $mouseArea
@onready var under_ray: RayCast2D = $RayCast2D

var has_mouse: bool = false
var is_grabbed: bool = false
var under_object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_area.mouse_shape_entered.connect(_on_mouse_area_mouse_shape_entered)
	mouse_area.mouse_shape_exited.connect(_on_mouse_area_mouse_shape_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	under_object = under_ray.get_collider()
	if Input.is_action_just_pressed("left_click") && has_mouse:
		if is_grabbed == true:
			is_grabbed = false
		else:
			is_grabbed = true
	if is_grabbed == true:
		self.position = get_global_mouse_position()


func _on_mouse_area_mouse_shape_entered(shape_idx: int) -> void:
	has_mouse = true


func _on_mouse_area_mouse_shape_exited(shape_idx: int) -> void:
	has_mouse = false
	

func get_under_object():
	if is_grabbed == true:
		return null
	else:
		return under_object
