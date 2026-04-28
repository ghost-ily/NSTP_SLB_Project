extends Node

func deposit(object: CharacterBody2D, zone: String, category: String, game_manager: Node):
	if zone == "":
		pass
	elif category == zone:
		game_manager.add_correct_score()
		object.queue_free()
	else:
		game_manager.add_incorrect_score()
		object.queue_free()
