extends Node

@onready var score: Label = %Score

var correct_score = 0
var incorrect_score = 0

func _process(delta: float) -> void:
	score.text = "Correct Placements: " + str(correct_score) + "\n" + "Incorrect Placements: " + str(incorrect_score)

func add_correct_score() -> void:
	correct_score += 1
	
func add_incorrect_score() -> void:
	incorrect_score += 1
	
