extends Area2D

@onready var label: Label = $Label
@onready var button: Button = $Button
@onready var game_manager: Node = %GameManager
@onready var timer: Timer = $Timer

var has_stone = false
var has_binder = false

var is_mixing = false

var asphalt = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_mixing and asphalt == 0:
		label.text = "Needs:"
		if not has_stone:
			label.text = label.text + " [stone]"
		if not has_binder:
			label.text = label.text + " [binder]"
	elif not is_mixing and asphalt > 0:
		label.text = "Asphalt Ready"
	else:
		label.text = "Mixing..." + str(int(timer.time_left)) + "s"
		
	if has_stone and has_binder:
		is_mixing = true
		has_stone = false
		has_binder = false
		timer.start()

func _on_button_pressed() -> void:
	if asphalt > 0:
		game_manager.fill_cement(asphalt)
		asphalt = 0

func _on_timer_timeout() -> void:
	asphalt = 3
	is_mixing = false

func _on_stone_pile_put_stone() -> void:
	has_stone = true

func _on_binder_put_binder() -> void:
	has_binder = true
