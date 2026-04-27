extends Node2D

const BRICK = preload("res://Game 1 Resources/brick.tscn")
@onready var ui: Control = $Control

var on_floor: Array = []
var on_brick: Array = []
var game_complete: bool = false

func start_game() -> void:
	game_complete = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!game_complete):
		pass
