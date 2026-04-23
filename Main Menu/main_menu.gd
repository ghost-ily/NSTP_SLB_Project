extends Control

var title_screen: Control
var user_screen: Control
var user_input: LineEdit
var user_confirm: Button
var ready_screen: Control
var user_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_screen = $TitleScreen
	user_screen = $UserScreen
	user_input = $UserScreen/NameInput
	user_confirm = $UserScreen/Confirm
	ready_screen = $ReadyScreen
	
	# Makes sure signals are connected
	connect_signals()
	
	
func _process(float) -> void:
	if user_input.text == "":
		user_confirm.disabled = true
	else:
		user_confirm.disabled = false


# Called to connect all relevant signals in the scene
func connect_signals() -> void:
	title_screen.gui_input.connect(_on_screen_clicked)
	user_confirm.pressed.connect(_on_confirm_pressed)


func _on_screen_clicked(input: InputEvent) -> void:
	if Input.is_anything_pressed():
		title_screen.hide()
		user_screen.show()
		ready_screen.hide()
		

func _on_confirm_pressed() -> void:
	user_name = user_input.text
	title_screen.hide()
	user_screen.hide()
	ready_screen.show()
