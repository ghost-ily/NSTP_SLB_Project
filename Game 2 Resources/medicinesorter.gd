extends Node2D

var score = 0
const MEDICINE = preload("res://Game 2 Resources/medicine.tscn")

@onready var ui: Control = $Control
@onready var scoreboard: Label = $scoreBoard
@onready var randotime: Timer = $RandomTimer
@onready var medspawn: Node2D = $MedicineSpawner

var game_complete: bool = false

func start_game() -> void:
	# Reset state
	score = 0
	game_complete = false
	scoreboard.text = "Score: %d" % score

	# Clear existing medicines
	for med in get_tree().get_nodes_in_group("medicines"):
		med.queue_free()

	# Restart spawn timer
	randotime.wait_time = randf_range(0.75, 1.5)
	randotime.start()

func _ready() -> void:
	randotime.wait_time = randf_range(0.75, 1.5)
	randotime.start()
	scoreboard.text = "Score: %d" % score

func _on_RandomTimer_timeout() -> void:
	spawn_medicine()
	randotime.wait_time = randf_range(0.75, 1.5)
	randotime.start()

func spawn_medicine() -> void:
	var med = MEDICINE.instantiate()
	var medcat = ["OTC", "Prescribed", "Critical"]
	med.category = medcat[randi() % medcat.size()]
	med.position = medspawn.position
	add_child(med)
	med.add_to_group("medicines")
	med.connect("placed_on_shelf", Callable(self, "_on_medicine_placed"))
	if med.category == "Prescribed":
		med.tex.texture = ResourceLoader.load("res://Game 2 Resources/assets/perscriptionmeds.png")
	elif med.category == "Critical":
		med.tex.texture = ResourceLoader.load("res://Game 2 Resources/assets/ivbag.png")
	else: med.tex.texture = ResourceLoader.load("res://Game 2 Resources/assets/otc.png")

func _on_medicine_placed(med_category: String, shelf_name: String) -> void:
	var correct = false
	if med_category == "OTC" and shelf_name == "ShelfOTC":
		correct = true
	elif med_category == "Prescribed" and shelf_name == "ShelfPres":
		correct = true
	elif med_category == "Critical" and shelf_name == "ShelfCrit":
		correct = true

	if correct:
		if med_category == "OTC":
			score += 250
		elif med_category == "Prescribed":
			score += 300
		else:
			score += 500
	else:
		score -= 650
	scoreboard.text = "Score: %d" % score

	# SAMPLE WIN TERMINATOR.
	if score >= 2500:
		game_complete = true

func _process(delta: float) -> void:
	if game_complete:
		randotime.stop()
