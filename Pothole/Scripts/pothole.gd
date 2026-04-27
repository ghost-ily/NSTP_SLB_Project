extends CharacterBody2D

var game_manager: Node

func _on_button_pressed() -> void:
	if game_manager.player_cement > 0:
		game_manager.player_cement -= 1
		queue_free()
