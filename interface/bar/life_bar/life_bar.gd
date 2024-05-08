extends Node

func _on_Interface_health_changed(health):
	$TextureProgressBar.value = health
	$Label.value = health
