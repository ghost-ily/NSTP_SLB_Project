extends Node2D

const BRICK = preload("res://Game 1 Resources/brick.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var brick1 = BRICK.instantiate()
	var brick2 = BRICK.instantiate()
	var brick3 = BRICK.instantiate()
	var brick4 = BRICK.instantiate()
	
	var all_bricks: Array = [brick1, brick2, brick3, brick4]
	
	for b in all_bricks:
		b.position = Vector2(randi_range(100,1000), 500)
		add_child(b)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
