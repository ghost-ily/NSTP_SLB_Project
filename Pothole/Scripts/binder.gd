extends CharacterBody2D

@onready var binder_origin: Node2D = %BinderOrigin
@onready var draggable_component: Node2D = $DraggableComponent
@onready var game_manager: Node = %GameManager

var in_mixer = false

signal put_binder

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_manager.game_has_ended == true:
		draggable_component.set_dragging(false)
	draggable_component.move(self, binder_origin, delta)

func _on_button_button_down() -> void:
	draggable_component.set_dragging(true)

func _on_button_button_up() -> void:
	if in_mixer:
		put_binder.emit()
	draggable_component.set_dragging(false)

func _on_mixer_body_entered(body: Node2D) -> void:
	in_mixer = true

func _on_mixer_body_exited(body: Node2D) -> void:
	in_mixer = false
