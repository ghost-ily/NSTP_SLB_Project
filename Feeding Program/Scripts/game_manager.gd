extends Node

var correct_sort = 0
var incorrect_sort = 0
var target_score = 1000
var final_score = 0

@export var game_time = 30

@onready var timer: Timer = $Timer
@onready var score: Label = $Score
@onready var time: Label = $Time
@onready var target: Label = $Target
@onready var spawner: Node2D = %Spawner
@onready var window: Window = $Window
@onready var window_label: Label = $Window/Label
@onready var window_button: Button = $Window/Button

func _ready() -> void:
	timer.wait_time = game_time
	timer.start()

func _process(delta: float) -> void:
	final_score = (100 * correct_sort) - (50 * incorrect_sort)
	score.text = "Score: " + str(final_score)
	time.text = "Time Left: " + str(int(timer.time_left))
	target.text = "Target: " + str(target_score)

func add_correct_score() -> void:
	correct_sort += 1

func add_incorrect_score() -> void:
	incorrect_sort += 1

func _on_timer_timeout() -> void:
	spawner.end_game()
	window.show()
	if final_score >= target_score:
		window_label.text = "You win!"
	else:
		window_label.text = "You lose!"

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
