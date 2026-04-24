extends Node2D

@onready var ui: Control = $Control
	
var game_complete: bool = false
var medicine_array: Array = []
var patient_array: Array = []
var game_timer: Timer

func start_game() -> void:
	game_complete = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!game_complete):
		pass
