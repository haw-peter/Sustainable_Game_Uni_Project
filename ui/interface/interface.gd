extends Control

signal health_updated(value)
signal gold_updated(count)
signal wood_updated(count)
signal house_updated(count)
signal health_bar_changed(value)
signal waste_bar_changed(value)
signal waste_bar_animation(value)
signal health_bar_animation(value)

@onready var tilemap_main = $"../../Tilemap Main"

var gold_count: int = 100
var wood_count: int = 10  # Starting wood count
var house_count: int = 0
var health_count: int = 100  # Starting health
var waste_count: int = 1  # Starting waste
var maximum = 100
var minimum = 0
var current_health = 100
var current_waste = 0	

func _ready():
	# Connect to the tile placed signal
	call_deferred("_connect_tilemap_signal")

	# Connect to the update signals
	var interface_node = get_node(".")
	interface_node.connect("gold_updated", Callable(self, "_update_gold_label"))
	interface_node.connect("wood_updated", Callable(self, "_update_wood_label"))
	interface_node.connect("house_updated", Callable(self, "_update_house_label"))
	interface_node.connect("health_bar_changed", Callable(self, "_update_health_bar"))
	interface_node.connect("waste_bar_changed", Callable(self, "_update_waste_bar"))
	interface_node.connect("waste_bar_animation", Callable(self, "_on_Interface_waste_updated"))
	interface_node.connect("health_bar_animation", Callable(self, "_on_Interface_health_updated"))

func _connect_tilemap_signal():
	var tile_map_node = tilemap_main #get_node("/root/Main/Tilemap Main")
	if tile_map_node:
		tile_map_node.connect("tile_placed", Callable(self, "_on_tile_placed"))
	else:
		print("Tilemap Main node not found!")

func _on_tile_placed(amount):
	gold_count -= 15
	wood_count -= 1
	house_count += 1
	health_count -= 10
	waste_count += 5
	
	# Emit signals to update the UI elements
	emit_signal("gold_updated", gold_count)
	emit_signal("wood_updated", wood_count)
	emit_signal("house_updated", house_count)
	emit_signal("health_bar_changed", health_count)
	emit_signal("waste_bar_changed", waste_count)

	# Debug prints to verify values
	print("Gold count: ", gold_count)
	print("Wood count: ", wood_count)
	print("House count: ", house_count)
	print("Health count: ", health_count)
	print("Waste count: ", waste_count)

# Update functions for the UI elements
func _update_gold_label(gold_count):
	print("Updating gold label: ", gold_count)  # Debug print
	$Counters/GoldCounter/Number.text = str(gold_count)

func _update_wood_label(wood_count):
	print("Updating wood label: ", wood_count)  # Debug print
	$Counters/WoodCounter/Number.text = str(wood_count)

func _update_house_label(house_count):
	print("Updating house label: ", house_count)  # Debug print
	$Counters/HouseCounter/Number.text = str(house_count)
#
func _update_health_bar(health_count):
	print("Updating health bar: ", health_count)  # Debug print
	$Bars/LifeBar/Count/Number.text = str(health_count)
	$Bars/LifeBar/TextureProgress.value = health_count
#
func _update_waste_bar(waste_count):
	print("Updating waste bar: ", waste_count)  # Debug print
	$Bars/WasteBar/Count/Number.text = str(waste_count)
	$Bars/WasteBar/TextureProgress.value = waste_count
	
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
	_update_health_bar(new_health)
	current_health = new_health
	
func _on_Interface_waste_updated(new_waste):
	animate_waste(current_waste, new_waste)
	_update_health_bar(new_waste)
	current_waste = new_waste	
			
