extends Node

var player_cement = 0
var game_has_ended = false
@export var game_time = 30

@onready var asphalt: Label = $Asphalt
@onready var timer: Timer = $Timer
@onready var window: Window = $Window
@onready var label: Label = $Window/Label
@onready var button: Button = $Window/Button
@onready var spawner: Node = %Spawner
@onready var time: Label = $GameTime

func _ready() -> void:
	#timer.wait_time = game_time
	#timer.start()
	game_has_ended = false

func _process(delta: float) -> void:
	asphalt.text = "Asphalt stored: " + str(player_cement)
	time.text = "Time left: " + str(int(timer.time_left))

func fill_cement(charges: int) -> void:
	player_cement += charges

func end_game() -> void:
	timer.paused = true
	game_has_ended = true
	#window.show()
	if spawner.get_child_count() > 0:
		label.text = "You Lose"
	else:
		label.text = "You Win"

func _on_timer_timeout() -> void:
	end_game()

func _on_button_pressed() -> void:
	for h in spawner.potholes:
		h.queue_free()
	spawner.potholes.clear()
	spawner._ready()
