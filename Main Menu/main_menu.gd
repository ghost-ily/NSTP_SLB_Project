extends Control

const type_time: int = 13

var title_screen: Control
var user_screen: Control
var user_input: LineEdit
var user_confirm: Button
var ready_screen: Control
var user_name: String
var main_game_scene = preload("res://UI/game_manager.tscn")

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
	ready_screen.gui_input.connect(_on_screen_clicked)
	ready_screen.set_block_signals(true)


func _on_screen_clicked(input: InputEvent) -> void:
	if Input.is_anything_pressed():
		if title_screen.visible == true:
			title_screen.hide()
			user_screen.show()
			ready_screen.hide()
		
		if ready_screen.visible == true:
			title_screen.hide()
			user_screen.hide()
			ready_screen.hide()
			var new_scene = main_game_scene.instantiate()
			get_tree().root.add_child(new_scene)
			get_tree().current_scene.queue_free()
		

func _on_confirm_pressed() -> void:
	user_name = user_input.text
	title_screen.hide()
	user_screen.hide()
	ready_screen.show()
	_format_letter_text()
	await get_tree().create_timer(type_time).timeout
	ready_screen.set_block_signals(false)
	

func _format_letter_text() -> void:
	ready_screen.get_node("LetterText").append_text("Dear %s" % [user_name] + "\n\n")
	ready_screen.get_node("LetterText").append_text("Following recent updates on the flood control project issues, some of the misused funds have now been recovered. As per your office's functions, you are instructed to make sure that these funds are used properly and for their original purpose. 

Together with your team, you are responsible for using these funds to improve public services and projects as they were meant to be.

You are advised to keep mistakes to a minimum. Errors may result in the need for replacement equipment and additional expenses, which will be charged against the budget. Repeated or excessive mistakes may lead to your removal from the position.
	")
	
	var typewriter = self.create_tween()
	typewriter.tween_property($ReadyScreen/LetterText, "visible_ratio", 1.0, type_time)
