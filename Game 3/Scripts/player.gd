extends CharacterBody2D

@onready var science: Area2D = %Science
@onready var literature: Area2D = %Literature
@onready var history: Area2D = %History
@onready var languages: Area2D = %Languages
@onready var arts: Area2D = %Arts
@onready var philosophy: Area2D = %Philosophy
@onready var table: Area2D = %Table
@onready var move_timer: Timer = $MoveTimer
@onready var book_anchor: Node2D = $BookAnchor
@onready var category: Label = %Category
@onready var interaction_timer: Timer = $InteractionTimer

var shelves: Array[Array] = [[], []]

var x_position = 0
var y_position = 0
var selected_shelf_position = Vector2(0, 0)

var game_has_ended = false
var can_move = true
var can_interact = true
var books: Array[Node2D] = [] 

func _ready() -> void:
	shelves = [[table, philosophy, arts, languages], [table, history, literature, science]]

func _process(delta: float) -> void:
	if game_has_ended:
		can_move = false
		can_interact = false
	
	var x_input = Input.get_axis("move_left", "move_right")
	var y_input = Input.get_axis("move_up", "move_down")
	
	if Input.is_action_just_pressed("left_click") and can_move:
		x_position = selected_shelf_position.x
		y_position = selected_shelf_position.y
		can_move = false
		move_timer.start()
	
	if (x_input != 0 or y_input != 0) and can_move:
		x_position += x_input
		y_position += y_input
		can_move = false
		move_timer.start()
	
	x_position = clamp(x_position, 0, 3)
	y_position = clamp(y_position, 0, 1)
	
	position = shelves[y_position][x_position].position
	for i in books.size():
		#books[i].position.y = book_anchor.position.y - (5 * i)
		#books[i].position.x = book_anchor.position.x
		
		books[i].reparent(book_anchor)
		books[i].position.y = book_anchor.position.y - (2.5 * i)
		books[i].position.x = book_anchor.position.x 
	
	if Input.is_action_pressed("interact") and can_interact:
		shelves[y_position][x_position].interact(books)
		can_interact = false
		interaction_timer.start()
		
	if not books.is_empty():
		category.text = "Category: " + books[0].get_category()
	else:
		category.text = ""
		
func end_game() -> void:
	game_has_ended = true

func _on_move_timer_timeout() -> void:
	can_move = true

func _on_interaction_timer_timeout() -> void:
	can_interact = true

func _on_table_mouse_shape_entered(shape_idx: int) -> void:
	selected_shelf_position = Vector2(0, 0)

func _on_science_mouse_shape_entered(shape_idx: int) -> void:
	selected_shelf_position = Vector2(3, 1)

func _on_literature_mouse_shape_entered(shape_idx: int) -> void:
	selected_shelf_position = Vector2(2, 1)

func _on_history_mouse_shape_entered(shape_idx: int) -> void:
	selected_shelf_position = Vector2(1, 1)

func _on_languages_mouse_shape_entered(shape_idx: int) -> void:
	selected_shelf_position = Vector2(3, 0)

func _on_arts_mouse_shape_entered(shape_idx: int) -> void:
	selected_shelf_position = Vector2(2, 0)

func _on_philosophy_mouse_shape_entered(shape_idx: int) -> void:
	selected_shelf_position = Vector2(1, 0)
