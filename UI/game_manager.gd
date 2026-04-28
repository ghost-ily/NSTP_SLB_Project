extends Control

var budget: RichTextLabel
var lives: Control
var timer: Control
var debug: Window
var is_new_game: bool

# Use debug_game_scene to test individual games
var debug_game_scene = load("res://Game 2 Resources/medicinesorter.tscn")
var game_1 = load("res://Game 1 Resources/game1.tscn")
var game_2 = load("res://Game 2 Resources/medicinesorter.tscn")
var packed_game: PackedScene
var current_game
var all_games: Array = [game_1, game_2]

var infra_funds: int
var health_funds: int
var educ_funds: int
var pub_health_funds: int
var current_service: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	budget = $Budget
	lives = $Lives
	timer = $Timer
	infra_funds = 0
	health_funds = 0
	educ_funds = 0
	pub_health_funds = 0
	debug = $DebugWindow
	debug.get_node("Button").pressed.connect(debug_ready)
	is_new_game = true
	choose_random_game()
	#current_game = debug_game_scene.instantiate()
	#add_child(current_game)


func choose_random_game():
	if packed_game != null:
		var temp = packed_game
		all_games.erase(packed_game)
		packed_game = all_games.pick_random()
		all_games.append(temp)
	else:
		packed_game = all_games.pick_random()
	current_game = packed_game.instantiate()
	add_child(current_game)
	is_new_game = true
	current_service = current_game.get_service()


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
		# Game lost
		if (timer.game_timer.time_left <= 0):
			lives.lose_life()
			current_game.game_complete = true
			pause_game()
		# Game won
		if current_game.game_complete and debug.visible == false:
			budget._on_decremented()
			add_decremented_funds()
			pause_game()
		


func debug_ready():
	current_game.start_game()
	debug.hide()
	is_new_game = false
	timer.start_timer()
	timer.game_timer.paused = false
	
	
func add_decremented_funds():
	if current_service == "Infrastructure":
		infra_funds += budget.get_decremented()
	elif current_service == "Healthcare":
		health_funds += budget.get_decremented()
	elif current_service == "Education":
		educ_funds += budget.get_decremented()
	elif current_service == "Public Health":
		pub_health_funds += budget.get_decremented()
