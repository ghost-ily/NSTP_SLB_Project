extends Area2D

signal placed_on_shelf(category, shelf_name)

var category = ""
var dragging = false

@onready var tex = $Sprite2D

func _ready():
	add_to_group("medicines")
	connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			dragging = true
		else:
			dragging = false
			check_shelf_overlap()
			
func _process(delta):
	if dragging:
		position = get_global_mouse_position()
		
func check_shelf_overlap():
	var overlapping = get_overlapping_areas()
	for area in overlapping:
		if area.is_in_group("shelves"):
			place_on_shelf(area.name)
			return
			
	queue_free()

func place_on_shelf(shelf_name: String):
	emit_signal("placed_on_shelf", category, shelf_name)
	queue_free()
