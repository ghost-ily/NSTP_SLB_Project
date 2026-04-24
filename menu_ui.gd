extends Control

@onready var timer: Timer = $Timer
@onready var time_left: Label = $timeLeft
@onready var window: Window = $Window
@onready var button: Button = $Window/Button
@onready var label: Label = $Window/Label

var restarted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	window.hide()
	timer.start(60)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_left.text = str(timer.time_left).pad_decimals(1)
	if (timer.time_left <= 0):
		label.text = "Game Over"
		window.show()
		
	if (get_parent().game_complete == true):
		label.text = "Good job!"
		window.show()
		timer.paused = true


func _on_button_pressed() -> void:
	get_parent().start_game()
	window.hide()
	timer.start(60)
	timer.paused = false
