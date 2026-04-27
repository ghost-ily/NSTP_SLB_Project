extends Control

var lives_ui: Array[TextureRect]
var player_lives: int = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lives_ui = [$"1", $"2", $"3", $"4"]


func get_lives_left():
	return player_lives
	
	
func lose_life():
	if player_lives > 0 and player_lives <= 4:
		player_lives -= 1
		lives_ui[player_lives].hide()
		

func gain_life():
	if player_lives > 0 and player_lives < 4:
		player_lives += 1
		lives_ui[player_lives].show()
