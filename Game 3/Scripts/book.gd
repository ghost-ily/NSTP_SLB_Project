extends Node2D

const categories: Array[String] = ["Philosophy", "Arts", "Languages", "History", "Literature", "Science"]

var book_category

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	book_category = categories.pick_random()

func get_category() -> String:
	return book_category
