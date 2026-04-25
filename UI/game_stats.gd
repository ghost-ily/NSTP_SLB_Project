extends Control

var budget: RichTextLabel
var lives: Control
var timer: Control
var debug: Window
var is_new_game: bool
var game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	budget = $Budget
	lives = $Lives
	timer = $Timer
	debug = $DebugWindow
	debug.get_node("Button").pressed.connect(debug_ready)
	is_new_game = true
	game = get_parent()


func pause_game():
	timer.start_timer()
	timer.game_timer.paused = true
	debug.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lives.get_lives_left() > 0:
		if is_new_game:
			game.game_complete = true
			pause_game()
				
		if (timer.game_timer.time_left <= 0):
			lives.lose_life()
			game.game_complete = true
			pause_game()
		if game.game_complete and debug.visible == false:
			budget._on_decremented()
			pause_game()
		


func debug_ready():
	game.start_game()
	debug.hide()
	is_new_game = false
	timer.start_timer()
	timer.game_timer.paused = false
	print(game.game_complete)
