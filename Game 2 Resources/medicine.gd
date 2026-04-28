extends Area2D

signal placed_on_shelf(category, shelf_name)
@onready var dispcat = $Label2

var texture_otc = load("res://Game 2 Resources/otc.png")
var texture_presc = load("res://Game 2 Resources/perscriptionmeds.png")
var texture_iv = load("res://Game 2 Resources/ivbag.png")

var category = ""
var dragging = false

func _ready():
	add_to_group("medicines")
	connect("input_event", Callable(self, "_on_input_event"))
	if self.category == "OTC": $Sprite2D.texture = texture_otc
	if self.category == "Prescribed": $Sprite2D.texture = texture_presc
	if self.category == "Critical": $Sprite2D.texture = texture_iv

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
