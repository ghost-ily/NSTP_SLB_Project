extends RigidBody2D

@onready var mouse_area: Area2D = $mouseArea
@onready var sprite: Sprite2D = $Sprite2D
var type: int
var health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Generate a new type for each instantiation
	# Type 1 - trash bag
	# Type 2 - trash bin
	# Type 3 - dumpster
	type = randi_range(1, 3)
	if type == 1:
		health = 1
		# resize mouseArea
	elif type == 2:
		health = 3
		# resize mouseArea
	elif type == 3:
		health = 5
		# resize mouseArea
	_connect_signals()
	
func _connect_signals() -> void:
	mouse_area.input_event.connect(_on_area_clicked)


func _on_area_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_action_released("left_click"):
			health -= 1
			print("Clicked")
			animate_click()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
		
		
func animate_click() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "offset", Vector2(10,0), 0.2)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT_IN)
		
	tween.tween_property(sprite, "offset", Vector2(0,0), 0.2)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT_IN)
