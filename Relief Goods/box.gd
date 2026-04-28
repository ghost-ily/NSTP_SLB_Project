extends StaticBody2D

@onready var mouse_area: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var truck: Area2D = $"../Truck"
var health: int
var has_mouse: bool
var is_grabbed: bool
var in_truck: bool

signal loaded_box
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 2
	has_mouse = false
	is_grabbed = false
	mouse_area.input_event.connect(_on_box_clicked)
	mouse_area.mouse_shape_entered.connect(_mouse_in_box)
	mouse_area.mouse_shape_exited.connect(_mouse_out_box)
	mouse_area.area_entered.connect(_on_truck_area_entered)
	mouse_area.area_exited.connect(_on_truck_area_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health == 0:
		if Input.is_action_just_pressed("left_click") && has_mouse:
			if is_grabbed == true:
				is_grabbed = false
				if in_truck:
					loaded_box.emit()
			else:
				is_grabbed = true
		if is_grabbed == true:
			self.position = get_global_mouse_position()
	
	
func _on_box_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and health > 0:
		if event.is_action_released("left_click"):
			health -= 1
			print("Clicked")
			animate_click()
			

func _mouse_in_box(shape_idx: int) -> void:
	has_mouse = true


func _mouse_out_box(shape_idx: int) -> void:
	has_mouse = false
	
	
func _on_truck_area_entered(area: Area2D) -> void:
	if area.name == "Truck":
		in_truck = true
			
			
func _on_truck_area_exited(area: Area2D) -> void:
	if area.name == "Truck":
		in_truck = false
			
			
func animate_click():
	# Change sprites
	pass
