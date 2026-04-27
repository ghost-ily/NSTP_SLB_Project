extends Control

var time_bar: TextureProgressBar
var game_timer: Timer
#@onready var start_timer: Button = $StartTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_bar = $TimeLeft
	game_timer = $"../GameTimer"
	#start_timer.pressed.connect(start_timer_button)


func _process(delta) -> void:
	if game_timer.time_left > 0:
		var time_left_percent = ((game_timer.time_left) / game_timer.wait_time) * 100
		time_bar.value = time_left_percent


func start_timer():
	game_timer.start(7.0)
