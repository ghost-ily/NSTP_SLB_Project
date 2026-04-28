extends CharacterBody2D

@onready var spawner: Node2D = $".."
@onready var draggable_component: Node2D = $DraggableComponent
@onready var scoring_component: Node = $ScoringComponent
@onready var collision_component: StaticBody2D = $CollisionComponent

var category = "Healthy"
var game_manager: Node

func connect_zones(healthy: Area2D, unhealthy: Area2D) -> void:
	collision_component.connect_zones(healthy, unhealthy)

func _process(delta: float) -> void:
	draggable_component.move(self, spawner, delta)

func _on_button_button_down() -> void:
	draggable_component.set_dragging(true)

func _on_button_button_up() -> void:
	scoring_component.deposit(self, collision_component.get_zone_entered(), category, game_manager)
	draggable_component.set_dragging(false)
