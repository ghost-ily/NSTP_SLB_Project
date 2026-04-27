extends Node2D

@onready var ui: Control = $Control
	
var game_complete: bool = false
var medicine_array: Array = []
var patient_array: Array = []
var game_timer: Timer

func start_game() -> void:
	game_complete = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Area2D and child.has_method("use"):
			medicine_array.append(child)
		
	for child in get_children():
		if child is Area2D and child.has_method("receive_medicine"):
			patient_array.append(child)
			child.connect("demand_medicine", Callable(self, "_on_patient_demand"))
			
	game_timer = Timer.new()
	game_timer.wait_time = 60
	game_timer.one_shot = true
	add_child(game_timer)
	game_timer.connect("timeout", Callable(self, "_on_game_timeout"))
	game_timer.start()

func _on_patient_demand(strength: int, patient: Area2D) -> void:
	print("Patient demands medicine of strength %d" % strength)
	
func check_med_drop(medicine: Medicine) -> void:
	for patient in patient_array:
		if medicine.get_node("CollisionShape2D").get_shape().intersects(patient.get_node("CollisionShape2D").get_shape(), medicine.global_transform, patient.global_transform):
			if patient.receive_medicine(medicine):
				print("Patient received correct medicine.")
			else:
				print("Patient received wrong medicine.")
				_fail_game()
			return

func _on_game_timeout() -> void:
	_complete_game()
	
func _complete_game() -> void:
	game_complete = true
	print("Congrats! Game is done!")
	
func _fail_game() -> void:
	game_complete = true
	print("Oh dear. Game failed.")
