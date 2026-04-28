extends Control

var budget: RichTextLabel
var lives: Control
var timer: Control
var debug: Window
var is_new_game: bool

# Use debug_game_scene to test individual games
var debug_game_scene = load("res://Feeding Program/Scenes/feeding_program.tscn")
var game_1 = load("res://Game 1 Resources/game1.tscn")
var game_2 = load("res://Game 2 Resources/medicinesorter.tscn")
var game_3 = load("res://Game 3/Scenes/game_3.tscn")
var game_4 = load("res://Pothole/Scenes/pothole_game.tscn")
var game_5 = load("res://Medical Equipment Game/med_eqp_game.tscn")
var game_6 = load("res://Game 6 Resources/game_6.tscn")
var game_7 = load("res://Feeding Program/Scenes/feeding_program.tscn")
var game_8 = load("res://Relief Goods/relief_goods.tscn")
var packed_game: PackedScene
var current_game
var all_games: Array = [game_1, game_2, game_3, game_4, game_5, game_6, game_7, game_8]
var game_over = load("res://GameOver/GameOver.tscn")

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
		current_game.queue_free()
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
			choose_random_game()
	else:
		var new_scene = game_over.instantiate()
		new_scene.total_infra = infra_funds
		new_scene.total_health = health_funds
		new_scene.total_educ = educ_funds
		new_scene.total_pub_health = pub_health_funds
		get_tree().root.add_child(new_scene)
		self.queue_free()
		


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
