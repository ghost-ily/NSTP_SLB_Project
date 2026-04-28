extends Node2D

const BOX = preload("res://Relief Goods/box.tscn")
var service = "Public Health"
var game_complete: bool
var is_occupied: bool
var score: int = 0
var current_box

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_complete = false
	is_occupied = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_occupied:
		current_box = BOX.instantiate()
		current_box.position = Vector2(190, 420)
		current_box.loaded_box.connect(_on_box_loaded)
		add_child(current_box)
		is_occupied = true
	if score >= 5:
		game_complete = true


func _on_box_loaded() -> void:
	current_box.queue_free()
	score += 1
	is_occupied = false
	
	
func get_service() -> String:
	return service
	
	
func start_game() -> void:
	game_complete = false
