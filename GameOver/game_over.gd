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
	label.text = "PHP " + str(format_number_comma(total_infra))
	label_2.text = "PHP " + str(format_number_comma(total_health))
	label_3.text = "PHP " + str(format_number_comma(total_educ))
	label_4.text = "PHP " + str(format_number_comma(total_pub_health))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func format_number_comma(input: int):
	var s_input: String = str(input)
	var result: String = ""
	var count: int = 0
	
	for i in range(s_input.length() - 1, -1, -1):
		result = s_input[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result

	return result;
