extends Node

@onready var score_label: Label = $Labels/Score
@onready var target_score: Label = $Labels/TargetScore
@onready var time: Label = $Labels/Time
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = %Player
@onready var table: Area2D = %Table
@onready var game_over: Window = $GameOver
@onready var game_over_label: Label = $GameOver/Label

var correct = 0
var incorrect = 0
var score = 0
var target = 1000
var game_time = 30

func _ready() -> void:
	target_score.text = "Target Score: " + str(target)
	timer.start(game_time)

func _process(delta: float) -> void:
	score = (100 * correct) - (50 * incorrect)
	score_label.text = "Score: " + str(score)
	time.text = "Time Left: " + str(int(timer.time_left))
	
	if correct >= target:
		timer.paused = true
		end_game()

func add_correct_score() -> void:
	correct += 1
	
func add_incorrect_score() -> void:
	incorrect += 1
	

func _on_timer_timeout() -> void:
	end_game()
	
func end_game() -> void:
	game_over.show()
	if score >= target:
		game_over_label.text = "You Win"
	else:
		game_over_label.text = "You Lose"
		
	player.end_game()
	table.end_game()


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
