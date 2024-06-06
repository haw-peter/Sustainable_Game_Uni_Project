class_name GameControl
extends Node

# in game Timer x = hours y = minutes
var time : Vector2i = Vector2i(12, 0)
var player_stats : PlayerStats

const startMessage: String = "Hello Player! Welcome to our city! We love it here and want to see the city grow and prosper. Maybe you can help us?"

func _ready():
	DialogManager.start_notification(startMessage)
	
func _on_timer_timeout():
	time.y = (time.y + 1) % 60
	if time.y == 0:
		time.x = (time.x + 1) % 24
	
	$Camera2D/Interface/Panel/Hours.text = "%02d :" % time.x
	$Camera2D/Interface/Panel/Minutes.text = "%02d" % time.y
	
	if (time.y % 10) == 0:
		player_stats.change_capital(round(player_stats.citizens / 10.0))
		player_stats.change_waste(calc_waste_incease())

func update_interface():
	$Camera2D/Gui.emit_signal("ping_gold", player_stats.capital)
	$Camera2D/Interface.emit_signal("gold_updated", player_stats.capital)
	###$Camera2D/Interface.emit_signal("wood_updated", wood_count)
	###$Camera2D/Interface.emit_signal("house_updated", house_count)
	#$Camera2D/Interface.emit_signal("citizen_updated", player_stats.citizens)
	#$Camera2D/Interface.emit_signal("health_bar_changed", player_stats.happiness)
	#$Camera2D/Interface.emit_signal("waste_bar_changed", player_stats.waste)

# waste multiplier is influenced by the type of building you place
func calc_waste_incease() -> float:
	print(player_stats.waste_multiplier)
	print(player_stats.waste)
	var waste_increase = (player_stats.citizens * player_stats.waste_multiplier)
	return waste_increase

func calc_happiness_incease():
	pass

func _on_test_scene_ready():
	player_stats = $TestScene.new_stats
	player_stats.resources_changed.connect(update_interface)
	update_interface()
