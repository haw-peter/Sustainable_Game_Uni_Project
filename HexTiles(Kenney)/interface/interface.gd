extends Control

signal health_changed(health)
signal gold_changed(count)



func _on_Health_health_changed(health):
	emit_signal("health_changed", health)
	
func _on_Purse_gold_changed(count):
	emit_signal("gold_changed", count)
