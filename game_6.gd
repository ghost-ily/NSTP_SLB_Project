extends Node2D

@onready var trash = preload("res://Game 6 Resources/trash.tscn")
var all_trash: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(4, randi_range(8, 12)):
		var inst_trash = trash.instantiate()
		inst_trash.position = Vector2(randi_range(100, 1000), 520)
		add_child(inst_trash)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
