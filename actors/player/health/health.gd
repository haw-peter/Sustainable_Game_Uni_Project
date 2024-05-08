extends Node

signal health_changed(health)
signal health_depleted

var max_health = 9
var health = 0


func _ready():
	health = max_health
	emit_signal("health_changed", health)

func take_damage(amount):
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)

func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)
