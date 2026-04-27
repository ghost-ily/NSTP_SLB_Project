extends RichTextLabel

var start_budget: int
var decrement_value: int
var number_change_anim: Tween
@onready var decrement: Button = $"../Decrement"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_budget = 197_000_000_000
	format_number_comma(start_budget)
	_connect_signals()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _connect_signals() -> void:
	decrement.pressed.connect(_on_decremented)

	
func _on_decremented():
	number_change_anim = get_tree().create_tween()
	decrement_value = randi() % 4_000_000_000 + 1_000_000_000
	number_change_anim.tween_method(
		format_number_comma,
		start_budget,
		start_budget - decrement_value,
		3.0)\
		.set_trans(Tween.TRANS_QUINT)\
		.set_ease(Tween.EASE_OUT)
	#start_budget -= decrement_value
	
	
func format_number_comma(input: int):
	var s_input: String = str(input)
	var result: String = ""
	var count: int = 0
	
	for i in range(s_input.length() - 1, -1, -1):
		result = s_input[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result

	self.text = "PHP " + result
