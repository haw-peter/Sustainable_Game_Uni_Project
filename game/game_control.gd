class_name GameControl
extends Node

var time : Vector2i = Vector2i(12, 0)# in game Timer x = hours y = minutes
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
		player_stats.change_capital(round(player_stats.citizens / 10))
		player_stats.change_waste(calc_waste_incease())
		player_stats.change_happiness(calc_happiness_increase())

func update_interface():
	$Camera2D/Interface.emit_signal("gold_updated", player_stats.capital)
	$Camera2D/Interface.emit_signal("house_updated", player_stats.houses) # added house emit signal and removed the wood
	$Camera2D/Interface.emit_signal("citizen_updated", player_stats.citizens)
	$Camera2D/Interface.emit_signal("health_bar_changed", player_stats.happiness)
	$Camera2D/Interface.emit_signal("waste_bar_changed", player_stats.waste)

# waste multiplier is influenced by the type of building you place
func calc_waste_incease() -> float:
	#print(player_stats.waste_multiplier) ## commented out
	#print(player_stats.waste)	 ## commented out
	var waste_increase = (player_stats.citizens * player_stats.waste_multiplier)
	return waste_increase

func calc_happiness_increase() -> float: #new calc for happiness (just a placeholder)
	var happiness = 0

	#var house_coefficient = 0.5
	var citizen_coefficient = 0.03
	var waste_coefficient = -0.7
	
	
	#var num_houses = player_stats.houses
	var num_citizens = player_stats.citizens
	var waste = player_stats.waste
	

	#happiness += house_coefficient * num_houses	
	happiness += citizen_coefficient * num_citizens
	happiness -= waste_coefficient * waste
	
	return happiness

func _on_test_scene_ready():
	player_stats = $TestScene.new_stats
	player_stats.resources_changed.connect(update_interface)
	update_interface()
