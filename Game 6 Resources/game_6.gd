extends Node2D

@onready var trash = preload("res://Game 6 Resources/trash.tscn")
var all_trash: Array = []

var service = "Environmental"
var game_complete: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if all_trash.size() <= 0:
		game_complete = true
	for t in all_trash:
		if t == null:
			all_trash.erase(t)


func start_game():
	if all_trash.size() > 0:
		for t in all_trash:
			t.queue_free()
	game_complete = false
	for i in range(4, randi_range(8, 12)):
		var inst_trash = trash.instantiate()
		all_trash.append(inst_trash)
		inst_trash.position = Vector2(randi_range(100, 1000), 520)
		add_child(inst_trash)
