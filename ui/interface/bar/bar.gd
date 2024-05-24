extends HBoxContainer

var maximum = 100
var minimum = 0
var current_health = 100
var current_waste = 0	
	
func _ready():
	# Connect to signals from the Interface node
	var interface_node = get_parent().get_parent() #get_node("res://game/Camera2D.gd")
	if interface_node:
		interface_node.connect("health_bar_changed", Callable(self, "_update_health_label"))
		interface_node.connect("waste_bar_changed", Callable(self, "_update_waste_label"))
		interface_node.connect("waste_bar_animation", Callable(self, "_on_Interface_health_updated"))
		interface_node.connect("waste_bar_animation", Callable(self, "_on_Interface_waste_updated"))
	else:
		print("Interface node not found")


func _update_health_label(health_count):
	$Count/Number.text = str(health_count)
	$TextureProgress.value = health_count

func _update_waste_label(waste_count):
	$Count/Number.text = str(waste_count)
	$TextureProgress.value = waste_count
	
	
func animate_health(start, end):
	$Tween.interpolate_property($Bars/LifeBar/TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "_update_health_label", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")
		
func animate_waste(start, end):
	$Tween.interpolate_property($Bars/WasteBar/TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "_update_waste_label", start, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")


func _on_Interface_health_updated(new_health):
	animate_health(current_health, new_health)
	_update_health_label(new_health)
	current_health = new_health
	
func _on_Interface_waste_updated(new_waste):
	animate_waste(current_waste, new_waste)
	_update_health_label(new_waste)
	current_waste = new_waste	
		
	
