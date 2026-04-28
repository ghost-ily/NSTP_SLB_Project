extends Node2D

const BRICK = preload("res://Game 1 Resources/brick.tscn")

var brick1 = BRICK.instantiate()
var brick2 = BRICK.instantiate()
var brick3 = BRICK.instantiate()
var brick4 = BRICK.instantiate()
	
var all_bricks: Array = [brick1, brick2, brick3, brick4]
var on_floor: Array = []
var on_brick: Array = []
var game_complete: bool = false
var service: String = "Infrastructure"


func start_game() -> void:
	for b in all_bricks:
		b.position = Vector2(randi_range(100,1000), 500)
	game_complete = false
	on_brick.clear()
	on_floor.clear()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brick1.add_to_group("bricks")
	brick2.add_to_group("bricks")
	brick3.add_to_group("bricks")
	brick4.add_to_group("bricks")
	
	brick1.name = "brick1"
	brick2.name = "brick2"
	brick3.name = "brick3"
	brick4.name = "brick4"
	
	for b in all_bricks:
		b.position = Vector2(randi_range(100,1000), 500)
		add_child(b)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!game_complete):
		on_brick.clear()
		on_floor.clear()
		for b in all_bricks:
			var under_obj = b.get_under_object()
			
			if (under_obj == $Ground):
				if (!on_floor.has(b)):
					on_floor.append(b)
			elif (under_obj != null):
				if (!on_brick.has(b)):
					on_brick.append(b)
					
			if (on_brick.size() == 3):
				game_complete = true
				for c in all_bricks:
					c.position = Vector2(randi_range(100,1000), 500)


func get_service() -> String:
	return service
