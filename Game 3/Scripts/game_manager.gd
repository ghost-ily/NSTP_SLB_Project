extends Node

@onready var score: Label = $Labels/Score
@onready var category: Label = $Labels/Category
@onready var target_score: Label = $Labels/TargetScore
@onready var time: Label = $Labels/Time
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../Player"
@onready var table: Area2D = %Table
@onready var game_over: Window = $GameOver
@onready var game_over_label: Label = $GameOver/Label

var correct_score = 0
var incorrect_score = 0
var target = 10
var game_time = 120
@export var game_complete: bool
var service = "Education"

func _ready() -> void:
	target_score.text = "Books to sort: " + str(target)
	timer.start(game_time)
	game_complete = false

func _process(delta: float) -> void:
	score.text = "Correct Placements: " + str(correct_score) + "\n" + "Incorrect Placements: " + str(incorrect_score)
	time.text = "Time Left: " + str(int(timer.time_left))
	
	if correct_score >= target:
		timer.paused = true
		game_complete = true
		end_game()
	if game_complete:
		end_game()

func add_correct_score() -> void:
	correct_score += 1
	
func add_incorrect_score() -> void:
	incorrect_score += 1
	

func _on_timer_timeout() -> void:
	#end_game()
	pass
	
func end_game() -> void:
	game_over.show()
	if correct_score >= target:
		game_over_label.text = "You Win"
	else:
		game_over_label.text = "You Lose"
	
	player.end_game()
	table.end_game()


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	
	
func get_service() -> String:
	return service
