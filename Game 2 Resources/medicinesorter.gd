extends Node2D

var score = 0
const MEDICINE = preload("res://Game 2 Resources/medicine.tscn")

@onready var scoreboard: Label = $scoreBoard
@onready var medspawn: Node2D = $MedicineSpawner
@onready var randotime: Timer = $RandomTimer

var game_complete: bool = false
var service: String = "Healthcare"

func start_game() -> void:
	# Reset state
	score = 0
	game_complete = false
	scoreboard.text = "Score: %d" % score

	# Clear existing medicines
	for med in get_tree().get_nodes_in_group("medicines"):
		med.queue_free()

	# Restart spawn timer
	randotime.wait_time = 1
	randotime.start()

func _ready() -> void:
	randotime.wait_time = 1
	randotime.start()
	scoreboard.text = "Score: %d" % score

func _on_RandomTimer_timeout() -> void:
	spawn_medicine()
	randotime.wait_time = 1
	randotime.start()

func spawn_medicine() -> void:
	var med = MEDICINE.instantiate()
	var medcat = ["OTC", "Prescribed", "Critical"]
	med.category = medcat[randi() % medcat.size()]
	med.position = medspawn.position
	add_child(med)
	med.add_to_group("medicines")
	med.connect("placed_on_shelf", Callable(self, "_on_medicine_placed"))
	med.dispcat.text = med.category
	print("Spawned medicine:", med.category, "at", med.position) # debug line

func _on_medicine_placed(med_category: String, shelf_name: String) -> void:
	var correct = false
	if med_category == "OTC" and shelf_name == "ShelfOTC":
		correct = true
	elif med_category == "Prescribed" and shelf_name == "ShelfPres":
		correct = true
	elif med_category == "Critical" and shelf_name == "ShelfCrit":
		correct = true

	if correct:
		score += 500
	else:
		score -= 300
	scoreboard.text = "Score: %d" % score

	# SAMPLE WIN TERMINATOR.
	if score >= 2500:
		game_complete = true

func _process(delta: float) -> void:
	if game_complete:
		randotime.stop()
		
func get_service() -> String:
	return service
