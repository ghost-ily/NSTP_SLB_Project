extends Area2D

const BOOK = preload("res://Game 3/Scenes/book.tscn")

var reserve_books: Array[Node2D] = []

var max_size = 1

func _process(delta: float) -> void:
	if randf() <= 0.005:
		var new_book = BOOK.instantiate()
		print("Book Arrived")
		new_book.position.x = 0
		new_book.position.y = -40 - (5 * reserve_books.size())
		add_child(new_book)
		reserve_books.append(new_book)

func interact(books: Array[Node2D]) -> Array[Node2D]:
	if books.size() < max_size:
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
