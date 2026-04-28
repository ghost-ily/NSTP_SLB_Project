extends Node2D

var game_feed
var game_complete: bool
var service: String = "Public Health"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_complete = false
	game_feed = %GameManager


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game_complete = game_feed.game_complete

func start_game():
	game_feed.start_game()

func get_service() -> String:
	return service
