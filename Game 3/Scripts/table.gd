extends Area2D

const BOOK = preload("res://Game 3/Scenes/book.tscn")

const MAX_BOOKS = 10

var reserve_books: Array[Node2D] = []

var player_max_capacity = 5

var game_has_ended = false

func _process(delta: float) -> void:
	if randf() <= 0.01 and reserve_books.size() < 10 and !game_has_ended:
		var new_book = BOOK.instantiate()
		new_book.position.x = 0
		new_book.position.y = -40 - (5 * reserve_books.size())
		add_child(new_book)
		reserve_books.append(new_book)

func interact(books: Array[Node2D]) -> Array[Node2D]:
	if books.size() < player_max_capacity:
		var new_book = get_book()
		if new_book != null:
			books.append(new_book)
	return books

func get_book() -> Node2D:
	if reserve_books.size() == 0:
		return null
	else:
		for book in reserve_books:
			book.position.y += 5
		return reserve_books.pop_front()
		
func end_game() -> void:
	game_has_ended = true
