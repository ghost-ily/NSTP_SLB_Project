extends Control

const NEW_GAME_TIME = 20.0
var current_game_time
var time_bar: TextureProgressBar
var game_timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_bar = $TimeLeft
	game_timer = $"../GameTimer"
	current_game_time = NEW_GAME_TIME


func _process(delta) -> void:
	if game_timer.time_left > 0:
		var time_left_percent = ((game_timer.time_left) / game_timer.wait_time) * 100
		time_bar.value = time_left_percent


func start_timer():
	game_timer.start(current_game_time)
	
	
func decrement_time():
	if (randi() % 100 <= 70):
		current_game_time -= 0.5
	
