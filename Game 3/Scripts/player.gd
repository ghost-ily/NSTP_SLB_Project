extends CharacterBody2D

@onready var science: Area2D = %Science
@onready var literature: Area2D = %Literature
@onready var history: Area2D = %History
@onready var languages: Area2D = %Languages
@onready var arts: Area2D = %Arts
@onready var philosophy: Area2D = %Philosophy
@onready var table: Area2D = %Table
@onready var move_timer: Timer = $MoveTimer

var shelves: Array[Array] = [[], []]

var x_position = 0
var y_position = 0

var can_move = true

func _ready() -> void:
	shelves = [[table, philosophy, arts, languages], [table, history, literature, science]]

func _process(delta: float) -> void:
	var x_input = Input.get_axis("move_left", "move_right")
	var y_input = Input.get_axis("move_up", "move_down")
	
	print("[" + str(x_input) + ", " + str(y_input) + "]")
	
	if (x_input != 0 or y_input != 0) and can_move:
		x_position += x_input
		y_position += y_input
		can_move = false
		move_timer.start()
	
	x_position = clamp(x_position, 0, 3)
	y_position = clamp(y_position, 0, 1)
	
	print(shelves[y_position][x_position].name)
	
	position = shelves[y_position][x_position].position


func _on_move_timer_timeout() -> void:
	can_move = true
