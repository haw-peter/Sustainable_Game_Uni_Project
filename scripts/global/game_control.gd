class_name GameControl
extends Node

# in game Timer x = hours y = minutes
var time : Vector2i = Vector2i(12, 0)
var player_stats : PlayerStats
var factor = 2 
var too_much_waste_message_printed = false
var too_rich_message_printed = false
var house_message_printed = false
const startMessage: String = "Hello Player! Welcome to our city! We love it here and want to see the city grow and prosper. Maybe you can help us?"

@export var tax_factor : float = 10 #
@export var too_rich = 250 # define when player is too rich 
@export var waste_fac_res = 0.1
@export var waste_fac_fac = 0.7

func _ready():
	DialogManager.start_notification(startMessage)
	
func _on_timer_timeout():
	time.y = (time.y + 1) % 60
	if time.y == 0:
		time.x = (time.x + 1) % 24
	
	$Camera2D/Interface/Panel/Hours.text = "%02d :" % time.x
	$Camera2D/Interface/Panel/Minutes.text = "%02d" % time.y
	
	if (time.y % 10) == 0:
		calc_all()

func in_hand(card: Card):
	var in_hand = $TestScene/TurnUI/Hand.get_child_count()
	for n in in_hand:
		var hand_card = $TestScene/TurnUI/Hand.get_child(n)
		print("Inventory: ", hand_card.card.id)
		
func update_interface():
	$Camera2D/Interface.emit_signal("gold_updated", player_stats.capital)
	$Camera2D/Interface.emit_signal("house_updated", player_stats.houses)
	$Camera2D/Interface.emit_signal("citizen_updated", player_stats.citizens)
	$Camera2D/Interface.emit_signal("health_bar_changed", player_stats.happiness)
	$Camera2D/Interface.emit_signal("waste_bar_changed", player_stats.waste)

# waste multiplier is influenced by the type of building you place
func calc_waste_incease() -> float:
	var increase = 0
	var cleanupfee = 2 * player_stats.res_buildings
	var cleanup = cleanupfee * waste_fac_res
	
	# calc res portion
	increase += (waste_fac_res * player_stats.res_buildings) - cleanup
	if(increase < 0):
		increase = 0;
	# calc fac portion
	if ((player_stats.citizens/tax_factor) - cleanupfee) > 1:
		increase += (waste_fac_fac*player_stats.fac_buildings) * 0.9
	else:
		increase += (waste_fac_fac*player_stats.fac_buildings)
	
	return increase * factor

func calc_happiness_incease() -> float:
	var increase = 0
	# Happiness depending on pollution
	if player_stats.waste >= 30:
		increase -= 3
	elif player_stats.waste >= 60:
		if (!too_much_waste_message_printed):
			DialogManager.start_notification("Your waste is getting out of hand. Your citizens aren't happy about it!")
			too_much_waste_message_printed = true;
		increase -= 8

	if (player_stats.houses > 5 && !house_message_printed):
			DialogManager.start_notification("Congratilations! You've finished your first 5 buildings!")
			house_message_printed = true;
	
	# Happiness depending on res/fac ratio
	if player_stats.houses > 1: #atleast 1 building
		var ratio = abs((6 * player_stats.fac_buildings) - (1 * player_stats.res_buildings)) # compate the ratio, the closer to 0 the better
		increase += clampf(5 - (0.8 * ratio), 0 , 5) # ideal ratio = full 5 % else make less, clamp val 0 - 5
	
	# when player is too rich, decrease happiness
	if player_stats.capital > too_rich:
		if(!too_rich_message_printed):
			DialogManager.start_notification("You're too rich. Your citizens aren't happy about it!")
			too_rich_message_printed = true;
			increase -= 1.5
	
	increase += player_stats.happiness_multiplier # Gains for Decoration
	
	return increase

func calc_gold_increase() -> int:
	# Calculates income based on Citizen Tax and Factory gain 
	var income = ceil(player_stats.citizens/tax_factor) + player_stats.capital_gain
	return income
	

func calc_all():
	player_stats.change_capital(calc_gold_increase())
	player_stats.change_waste(calc_waste_incease())
	player_stats.change_happiness(calc_happiness_incease())

func _on_test_scene_ready():
	player_stats = $TestScene.new_stats
	player_stats.resources_changed.connect(update_interface)
	update_interface()

#for math
func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
