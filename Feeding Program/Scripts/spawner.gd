extends Node2D

const apple = preload("res://Feeding Program/Scenes/apple.tscn")
const milk = preload("res://Feeding Program/Scenes/milk.tscn")
const chips = preload("res://Feeding Program/Scenes/chips.tscn")

const foods: Array[PackedScene] = [apple, milk, chips]

var has_game_ended = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_child_count() == 0 and not has_game_ended:
		var food = foods.pick_random()
		food = food.instantiate()
		food.game_manager = %GameManager
		add_child(food)
		food.connect_zones(%Healthy, %Unhealthy)

func end_game():
	has_game_ended = true
	self.get_child(0).queue_free()
