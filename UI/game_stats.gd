extends Control

var budget: RichTextLabel
var lives: Control
var timer: Control
var debug: Window
var is_new_game: bool
var debug_game_scene = preload("res://Game 1 Resources/game1.tscn")
var current_game
var all_games: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	budget = $Budget
	lives = $Lives
	timer = $Timer
	debug = $DebugWindow
	debug.get_node("Button").pressed.connect(debug_ready)
	is_new_game = true
	current_game = debug_game_scene.instantiate()
	add_child(current_game)


func choose_random_game():
	# Randomly choose any game from all_games
	# with the exception of current_game
	is_new_game = true
	pass

func pause_game():
	timer.start_timer()
	timer.game_timer.paused = true
	debug.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lives.get_lives_left() > 0:
		if is_new_game:
			current_game.game_complete = true
			pause_game()
				
		if (timer.game_timer.time_left <= 0):
			lives.lose_life()
			current_game.game_complete = true
			pause_game()
		if current_game.game_complete and debug.visible == false:
			budget._on_decremented()
			pause_game()
		


func debug_ready():
	current_game.start_game()
	debug.hide()
	is_new_game = false
	timer.start_timer()
	timer.game_timer.paused = false
