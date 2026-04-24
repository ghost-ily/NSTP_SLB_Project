extends Area2D

signal demand_medicine(strength: int, patient: Area2D)

@export var patient_name: String = ""

var medicine_demanded: int = -1
var timer_demand: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_demand = Timer.new()
	timer_demand.wait_time = randi_range(3, 15)
	timer_demand.one_shot = true
	add_child(timer_demand)
	
	timer_demand.connect("timeout", Callable(self, "_on_demand_timeout"))
	timer_demand.start()
	
func _on_demand_timeout() -> void:
	medicine_demanded = randi() % 9
	emit_signal("demand_medicine", medicine_demanded, self)
	
func receive_medicine(medicine: Medicine) -> bool:
	if medicine.strength == medicine_demanded and medicine.use():
		medicine_demanded = 0
		timer_demand.wait_time = randi_range(3, 15)
		timer_demand.start()
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
