extends Area2D

@onready var game_manager: Node = %GameManager

func interact(books: Array[Node2D]) -> Array[Node2D]:
	if books.size() > 0:
		var current_book = books.pop_front()
		if current_book.get_category() == self.name:
			game_manager.add_correct_score()
		else:
			game_manager.add_incorrect_score()
		current_book.queue_free()
	return books
