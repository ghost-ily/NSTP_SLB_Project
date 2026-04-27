extends Area2D

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		for med in get_tree().get_nodes_in_group("medicines"):
			if med.selected:
				med.place_on_shelf(name)
