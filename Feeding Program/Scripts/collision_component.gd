extends StaticBody2D

var healthy_zone: Area2D
var unhealhty_zone: Area2D
var zone_entered = ""

func connect_zones(healthy: Area2D, unhealthy: Area2D) -> void:
	healthy_zone = healthy
	unhealhty_zone = unhealthy
	
	healthy_zone.body_entered.connect(_on_healthy_zone_enter)
	healthy_zone.body_exited.connect(_on_zone_exit)
	unhealhty_zone.body_entered.connect(_on_unhealthy_zone_enter)
	unhealhty_zone.body_exited.connect(_on_zone_exit)
	
func get_zone_entered() -> String:
	return zone_entered
	
func _on_healthy_zone_enter(body: Node2D) -> void:
	zone_entered = "Healthy"

func _on_unhealthy_zone_enter(body: Node2D) -> void:
	zone_entered = "Unhealthy"

func _on_zone_exit(body: Node2D) -> void:
	zone_entered = ""
