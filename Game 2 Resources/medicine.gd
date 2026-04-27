extends Area2D

signal placed_on_shelf(category, shelf_name)
@onready var dispcat = $Label2

var category = ""
var selected = false

func _ready():
	add_to_group("medicines")
	connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		selected = !selected
		if selected:
			print("Selected medicine: %s" % category)

func place_on_shelf(shelf_name):
	emit_signal("placed_on_shelf", category, shelf_name)
	queue_free()
