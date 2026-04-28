extends Control

var total_infra: int
var total_health: int
var total_educ: int
var total_pub_health: int

@onready var label: Label = $HBoxContainer/VBoxContainer2/Label
@onready var label_2: Label = $HBoxContainer/VBoxContainer2/Label2
@onready var label_3: Label = $HBoxContainer/VBoxContainer2/Label3
@onready var label_4: Label = $HBoxContainer/VBoxContainer2/Label4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "PHP " + str(total_infra)
	label_2.text = "PHP " + str(total_health)
	label_3.text = "PHP " + str(total_educ)
	label_4.text = "PHP " + str(total_pub_health)
	
	
