extends Area2D
class_name Medicine

@onready var medicollision = $CollisionShape2D
var strength: int
var stock: int
var is_being_dragged: bool
var offset: Vector2 = Vector2.ZERO
@export var madiname: String = ""

func _init(medstrength: int) -> void:
	strength = medstrength
	match strength:
		0, 1:
			stock = 75
		2, 3, 4:
			stock = 25
		5, 6, 7, 8:
			stock = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Input.is_action_pressed("left_click"):
		_dragged()
		
func _dragged() -> void:
	var mouse_position = get_global_mouse_position()
	if medicollision.shape != null and medicollision.get_rect().has_point(to_local(mouse_position)):
		is_being_dragged = true
		offset = global_position - mouse_position
		
	else:
		is_being_dragged = false
		get_parent().call_deferred("check_drop", self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_being_dragged:
		global_position = get_global_mouse_position() + offset
		
func use() -> bool:
	if stock > 0:
		stock -= 1
		return true
	else:
		return false
