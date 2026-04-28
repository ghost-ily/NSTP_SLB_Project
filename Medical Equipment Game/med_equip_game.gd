extends Control

var bed: TextureButton
var blood: TextureButton
var glove: TextureButton
var bottle: TextureButton
var syringe: TextureButton
var mask: TextureButton
var all_btns: Array

var bed_g: Label
var blood_g: Label
var glove_g: Label
var bottle_g: Label
var syringe_g: Label
var mask_g: Label

var bed_c: Label
var blood_c: Label
var glove_c: Label
var bottle_c: Label
var syringe_c: Label
var mask_c: Label

var clear_cart: Button
var checkout: Button
var all_goals: Array
var in_cart: Array

var game_complete: bool
var service = "Healthcare"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bed = $InputContainer/Bed
	blood = $InputContainer/Blood
	glove = $InputContainer/Glove
	bottle = $InputContainer/Bottle
	syringe = $InputContainer/Syringe
	mask = $InputContainer/Mask
	all_btns = [bed, blood, glove, bottle,
		syringe, mask]
		
	bed_g = $GoalPanel/VBoxContainer/GridContainer/BedGoal
	blood_g = $GoalPanel/VBoxContainer/GridContainer/BloodGoal
	glove_g = $GoalPanel/VBoxContainer/GridContainer/GloveGoal
	bottle_g = $GoalPanel/VBoxContainer/GridContainer/BottleGoal
	mask_g = $GoalPanel/VBoxContainer/GridContainer/MaskGoal
	syringe_g = $GoalPanel/VBoxContainer/GridContainer/SyringeGoal
	all_goals = [bed_g, blood_g, glove_g, bottle_g, syringe_g, mask_g]
	
	bed_c = $CartPanel/VBoxContainer/GridContainer2/BedCart
	blood_c = $CartPanel/VBoxContainer/GridContainer2/BloodCart
	glove_c = $CartPanel/VBoxContainer/GridContainer2/GloveCart
	bottle_c = $CartPanel/VBoxContainer/GridContainer2/BottleCart
	syringe_c = $CartPanel/VBoxContainer/GridContainer2/SyringeCart
	mask_c = $CartPanel/VBoxContainer/GridContainer2/MaskCart
	
	clear_cart = $ClearCart
	checkout = $Checkout
	connect_signals()
	game_complete = true
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	bed_c.text = " x " + str(in_cart.count("Bed"))
	blood_c.text = " x " + str(in_cart.count("Blood"))
	glove_c.text = " x " + str(in_cart.count("Glove"))
	bottle_c.text = " x " + str(in_cart.count("Bottle"))
	syringe_c.text = " x " + str(in_cart.count("Syringe"))
	mask_c.text = " x " + str(in_cart.count("Mask"))

func connect_signals() -> void:
	for btn in all_btns:
		btn.pressed.connect(_on_btn_pressed.bind(btn.name))
	clear_cart.pressed.connect(_on_clear_pressed)
	checkout.pressed.connect(_on_checkout_pressed)

	
func _on_btn_pressed(btn_name: String) -> void:
	in_cart.append(btn_name)
	

func _on_clear_pressed() -> void:
	in_cart.clear()
	

func _on_checkout_pressed() -> void:
	if int(all_goals[0].text) != in_cart.count("Bed"):
		in_cart.clear()
	elif int(all_goals[1].text) != in_cart.count("Blood"):
		in_cart.clear()
	elif int(all_goals[2].text) != in_cart.count("Glove"):
		in_cart.clear()
	elif int(all_goals[3].text) != in_cart.count("Bottle"):
		in_cart.clear()
	elif int(all_goals[4].text) != in_cart.count("Syringe"):
		in_cart.clear()
	elif int(all_goals[5].text) != in_cart.count("Mask"):
		in_cart.clear()
	else:
		in_cart.clear()
		game_complete = true
	
	
	
func start_game() -> void:
	for g in all_goals:
		var i_goal = randi_range(0, 4)
		g.text = str(i_goal)
		
	for i in range(all_btns.size()):
		$InputContainer.move_child(all_btns[i], randi_range(0, 5))
		
	game_complete = false
	
	
func get_service() -> String:
	return service
