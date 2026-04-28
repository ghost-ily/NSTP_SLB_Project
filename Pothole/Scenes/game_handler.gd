extends Node2D

var service = "Infrastructure"
var pothole_game
var game_complete: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_complete = false
	pothole_game = %GameManager
	game_complete = pothole_game.game_has_ended


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game_complete = pothole_game.game_has_ended
	

func get_service() -> String:
	return service
	
	
func start_game():
	pothole_game._on_button_pressed()
