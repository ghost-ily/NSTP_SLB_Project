extends Node2D

var game_3
var game_complete: bool
var service: String = "Education"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_complete = false
	game_3 = %GameManager


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game_complete = game_3.game_complete
	
	
func start_game() -> void:
	game_3._on_button_pressed()
	
	
func get_service():
	return game_3.get_service()
