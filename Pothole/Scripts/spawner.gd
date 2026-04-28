extends Node

const pothole = preload("res://Pothole/Scenes/pothole.tscn")
const holes_to_spawn = 5

var potholes: Array[CharacterBody2D] = []
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(holes_to_spawn):
		var hole = pothole.instantiate()
		var spawn_x = rng.randf_range(-90, 90)
		var spawn_y = rng.randf_range(-150, 150)
		hole.global_position = Vector2(spawn_x, spawn_y)
		hole.game_manager = %GameManager
		add_child(hole)
		potholes.append(hole)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_child_count() == 0:
		%GameManager.end_game()
