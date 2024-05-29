#extends Control
#
#signal health_updated(value)
#signal gold_updated(count)
#signal wood_updated(count)
#signal house_updated(count)
#signal citizen_updated(count)
#signal health_bar_changed(value)
#signal waste_bar_changed(value)
#
#
#signal gold_count_changed(count)
#
##signal waste_bar_animation(value)
##signal health_bar_animation(value)
#
#@onready var tilemap_main = $"../../Tilemap Main"
##@onready var animation_health = $Bars/LifeBar/AnimationPlayer
##@onready var animation_waste = $Bars/WasteBar/AnimationPlayer
#
#var gold_count: int = 100 # Starting gold count
#var wood_count: int = 15  # Starting wood count
#var house_count: int = 0  # Starting house count
#var citizen_count: int = 0 # Starting citizens count
#var health_count: int = 50  # Starting health
#var waste_count: int = 50  # Starting waste
#var maximum = 100
#var minimum = 0
#var current_health = 50
#var current_waste = 0	
#
#func _ready():
	## Connect to the tile placed signal
	#call_deferred("_connect_tilemap_signal")
#
	## Connect to the update signals
	#var interface_node = get_node(".")
	#interface_node.connect("gold_updated", Callable(self, "_update_gold_label"))
	#interface_node.connect("wood_updated", Callable(self, "_update_wood_label"))
	#interface_node.connect("house_updated", Callable(self, "_update_house_label"))
	#interface_node.connect("citizen_updated", Callable(self, "_update_citizen_label"))
	#interface_node.connect("health_bar_changed", Callable(self, "_update_health_bar"))
	#interface_node.connect("waste_bar_changed", Callable(self, "_update_waste_bar"))
	###interface_node.connect("waste_bar_animation", Callable(self, "_on_Interface_waste_updated"))
	###interface_node.connect("health_bar_animation", Callable(self, "_on_Interface_health_updated"))
#
	#
#func _connect_tilemap_signal():
	#var tile_map_node = tilemap_main #get_node("/root/Main/Tilemap Main")
	#if tile_map_node:
		#tile_map_node.connect("tile_placed", Callable(self, "_on_tile_placed"))
	#else:
		#print("Tilemap Main node not found!")
#
#func _on_tile_placed(amount):
	#gold_count = clamp(gold_count -15, minimum, 999999)
	#wood_count = clamp(gold_count -1, minimum, 999999)
	#house_count += 1
	#health_count = clamp(health_count - 10, minimum, maximum)
	#waste_count = clamp(waste_count + 5, minimum, maximum)
	#citizen_count += 4
	#
	## Emit signals to update the UI elements
	#emit_signal("gold_updated", gold_count)
	#emit_signal("wood_updated", wood_count)
	#emit_signal("house_updated", house_count)
	#emit_signal("citizen_updated", citizen_count)
	#emit_signal("health_bar_changed", health_count)
	#emit_signal("waste_bar_changed", waste_count)
	#emit_signal("waste_bar_animation", waste_count)
	#emit_signal("health_bar_animation", health_count)
#
	## Debug prints to verify values
	#print("Gold count: ", gold_count)
	#print("Wood count: ", wood_count)
	#print("House count: ", house_count)
	#print("Health count: ", health_count)
	#print("Waste count: ", waste_count)
	#
	#if  waste_count >= 100:
		#const line1: String = "OOPS! The pollution in your city killed everyone!. Do you want to play again?"
		#DialogManager.start_notification(line1)
		#_switch_to_game_over_scene()
	#
	#if  gold_count < 0:
		#const line2: String = "OOPS! It looks like you got into debt!. Do you want to play again?"
		#DialogManager.start_notification(line2)
		#_switch_to_game_over_scene()
	#
	#if  wood_count <= 10:
		#const line3: String = "OOPS! It looks like you are running out of wood! You need more wood to continue building Tiles!. Press 'W' to buy 15 Wood for 100 Gold!" # still to be implemented
		#DialogManager.start_notification(line3)
	#
	#if waste_count >= 90 and waste_count <= 99:
		#const line4: String = "OOPS! It seems that the pollution in your city reached an unlivable condition. Press 'P' to pay 50 gold to reduce your waste by 20%!"
		#DialogManager.start_notification(line4)
		#
#func _input(event: InputEvent) -> void:
	#if waste_count == 95:
		#if event is InputEventKey and event.is_action_pressed("ui_accept"):
			#if gold_count >= 50:
			## Reduce waste by 20%
				#waste_count -= int(waste_count * 0.20)
				#_update_waste_bar(waste_count)
			## Deduct 50 gold
				#gold_count -= 50
				#_update_gold_label(gold_count)
			#else:
				#const line5: String = "OOPS! It looks like you don't have enough gold at the moment! wait 10 seconds for your passive income!"	
				#DialogManager.start_notification(line5)	
	#if wood_count <= 10:
		#if event is InputEventKey and event.is_action_pressed("ui_accept"):
			## if player have 100 or more
			#if gold_count >= 100:
				## deduct 100 gold
				#gold_count -= 100
				#_update_gold_label(gold_count)
				## increase wood by 15
				#wood_count += 15
				#_update_wood_label(wood_count)
				#
				## Increase waste by 20%
				#waste_count += int(waste_count * 0.20)
				#_update_waste_bar(waste_count)
			#else:
				#const line5: String = "OOPS! It looks like you don't have enough gold at the moment! wait 10 seconds for your passive income!"	
				#DialogManager.start_notification(line5)
			#
				#
#
## Update functions for the UI elements
#func _update_gold_label(gold_count):
	#print("Updating gold label: ", gold_count)  # Debug print
	#$Counters/GoldCounter/Number.text = str(gold_count)
	#$Counters/GoldCounter/Number/AnimationPlayer.play("shake")
#
## Function to update the gold count
#func update_gold_count(new_count: int) -> void:
	#gold_count = new_count
	#emit_signal("gold_count_changed", gold_count)
	#
#func _update_wood_label(wood_count):
	#print("Updating wood label: ", wood_count)  # Debug print
	#$Counters/WoodCounter/Number.text = str(wood_count)
#
#func _update_house_label(house_count):
	#print("Updating house label: ", house_count)  # Debug print
	#$Counters/HouseCounter/Number.text = str(house_count)
	#
#func _update_citizen_label(citizen_count):
	#print("Updating citizen label: ", citizen_count)  # Debug print
	#$Counters/CitizenCounter/Number.text = str(citizen_count)
	#
#func _update_health_bar(health_count):
	#print("Updating health bar: ", health_count)  # Debug print
	#$Bars/LifeBar/Count/Number.text = str(health_count)
	#$Bars/LifeBar/Count/AnimationPlayer.play("shake")
	#$Bars/LifeBar/TextureProgress.value = health_count
	#$Bars/LifeBar/TextureProgress/AnimationPlayer.play("shake")
##
#func _update_waste_bar(waste_count):
	#print("Updating waste bar: ", waste_count)  # Debug print
	#$Bars/WasteBar/Count/Number.text = str(waste_count)
	#$Bars/WasteBar/Count/AnimationPlayer.play("shake")
	#$Bars/WasteBar/TextureProgress.value = waste_count
	#$Bars/WasteBar/TextureProgress/AnimationPlayer.play("shake")
	#
			#
#func _switch_to_game_over_scene():
	#print("Switching to game over scene")
	#get_tree().change_scene_to_file("res://menu/end_menu.tscn")
	
	
extends Control

signal health_updated(value)
signal gold_updated(count)
signal wood_updated(count)
signal house_updated(count)
signal citizen_updated(count)
signal health_bar_changed(value)
signal waste_bar_changed(value)

signal gold_count_changed(count)

@onready var tilemap_main = $"../../Tilemap Main"

var gold_count: int = 100 # Starting gold count
var wood_count: int = 15  # Starting wood count
var house_count: int = 0  # Starting house count
var citizen_count: int = 0 # Starting citizens count
var health_count: int = 50  # Starting health
var waste_count: int = 50  # Starting waste
var maximum = 100
var minimum = 0
var current_health = 50
var current_waste = 0

var current_action: String = "" # Track the current action the player wants to take

func _ready():
	# Connect to the tile placed signal

	# Connect to the update signals
	var interface_node = get_node(".")
	interface_node.connect("gold_updated", Callable(self, "_update_gold_label"))
	interface_node.connect("wood_updated", Callable(self, "_update_wood_label"))
	interface_node.connect("house_updated", Callable(self, "_update_house_label"))
	interface_node.connect("citizen_updated", Callable(self, "_update_citizen_label"))
	interface_node.connect("health_bar_changed", Callable(self, "_update_health_bar"))
	interface_node.connect("waste_bar_changed", Callable(self, "_update_waste_bar"))
	interface_node.connect("gold_count_changed", Callable(self, "update_gold_count"))


#func _connect_tilemap_signal():
	#Events.tile_placed.connect(_on_tile_placed)

#func _on_tile_placed():
	#gold_count = clamp(gold_count - 15, minimum, 999999)
	#wood_count = clamp(wood_count - 1, minimum, 999999)
	#house_count += 1
	#health_count = clamp(health_count - 2, minimum, maximum)
	#waste_count = clamp(waste_count + 5, minimum, maximum)
	#citizen_count += 4
	#
	## Emit signals to update the UI elements
	#emit_signal("gold_updated", gold_count)
	#emit_signal("wood_updated", wood_count)
	#emit_signal("house_updated", house_count)
	#emit_signal("citizen_updated", citizen_count)
	#emit_signal("health_bar_changed", health_count)
	#emit_signal("waste_bar_changed", waste_count)
	#
	## Debug prints to verify values
	#print("Gold count: ", gold_count)
	#print("Wood count: ", wood_count)
	#print("House count: ", house_count)
	#print("Health count: ", health_count)
	#print("Waste count: ", waste_count)
	#
	##if waste_count >= 100:
		##const line1: String = "OOPS! The pollution in your city killed everyone! Do you want to play again?"
		##DialogManager.start_notification(line1)
		##_switch_to_game_over_scene()
	##
	##if gold_count < 0:
		##const line2: String = "OOPS! It looks like you got into debt! Do you want to play again?"
		##DialogManager.start_notification(line2)
		##_switch_to_game_over_scene()
	##
	##if wood_count <= 10:
		##const line3: String = "OOPS! It looks like you are running out of wood! You need more wood to continue building Tiles! Press 'W' to buy 15 Wood for 100 Gold!"
		##DialogManager.start_notification(line3)
	##
	##if waste_count >= 90 and waste_count <= 99:
		##const line4: String = "OOPS! It seems that the pollution in your city reached an unlivable condition. Press 'P' to pay 50 gold to reduce your waste by 20%!"
		##DialogManager.start_notification(line4)
#
##func _handle_delayed_effects():
	##waste_count = clamp(waste_count + 10, minimum, maximum)
	##health_count = clamp(health_count - 5, minimum, maximum)
	##emit_signal("health_bar_changed", health_count)
	##emit_signal("waste_bar_changed", waste_count)
##
	##var messages = [
		##{"text": "Due to CO2 emissions, your waste has increased and health has decreased!", "action": "none"},
		##{"text": "Since you didn't take any action, a few citizens decided to leave and your health decreased even more!", "action": "decrease_citizens"},
		##{"text": "Would you like to pay 50 gold to remove some pollution?", "action": "reduce_waste"}
	##]
##
	##var random_index = randi() % messages.size()
	##var selected_message = messages[random_index]
##
	##DialogManager.start_notification(selected_message["text"])
##
	##match selected_message["action"]:
		##"decrease_citizens":
			##citizen_count = max(citizen_count - 2, 0)
			##emit_signal("citizen_updated", citizen_count)
			##health_count = clamp(health_count - 10, minimum, maximum)
			##emit_signal("health_bar_changed", health_count)
		##"reduce_waste":
			##if gold_count >= 50:
				##gold_count -= 50
				##waste_count = max(waste_count - 20, 0)
				##emit_signal("gold_updated", gold_count)
				##emit_signal("waste_bar_changed", waste_count)
			##else:
				##DialogManager.start_notification("You don't have enough gold to reduce pollution. Wait for your passive income.")
##
	### Check for critical conditions
	##if waste_count >= 100:
		##DialogManager.start_notification("OOPS! The pollution in your city killed everyone! Do you want to play again?")
		##_switch_to_game_over_scene()
	##elif gold_count < 0:
		##DialogManager.start_notification("OOPS! It looks like you got into debt! Do you want to play again?")
		##_switch_to_game_over_scene()
	##elif wood_count <= 10:
		##DialogManager.start_notification("OOPS! It looks like you are running out of wood! You need more wood to continue building Tiles! Press 'W' to buy 15 Wood for 100 Gold!")
	##elif waste_count >= 70 and waste_count <= 95:
		##DialogManager.start_notification("OOPS! It seems that the pollution in your city reached an unlivable condition. Press 'P' to pay 50 gold to reduce your waste by 20%!")
	##elif health_count >= 15 and health_count <= 25:
		##DialogManager.start_notification("WARNING! Your citizens are not happy and might immigrate. Press 'H' to pay 50 gold to reduce your happiness by 10%!")	
	##elif health_count <= 10:
		##DialogManager.start_notification("Unfortunately! 2 Families are not happy and decided to immigrate.")
		##citizen_count -= 8
		##emit_signal("citizen_updated", citizen_count)
		##$Counters/CitizenCounter/Number/AnimationPlayer.play("shake")
		##DialogManager.start_notification("Good News! Your poulltion decreased by 5%")
		##waste_count = max(waste_count - int(waste_count * 0.05), 0)
		##emit_signal("waste_bar_changed", waste_count)
		##$Bars/WasteBar/TextureProgress/AnimationPlayer.play("shake")
		##
		##health_count = max(health_count - int(health_count * 0.10), 0)
		##emit_signal("health_bar_changed", health_count)
		##$Bars/LifeBar/Count/AnimationPlayer.play("shake")
		##$Bars/LifeBar/TextureProgress/AnimationPlayer.play("shake")
		##DialogManager.start_notification("But your Happiness decreased by 10%!")
			#
#
##func _input(event: InputEvent) -> void:
	##if event is InputEventKey:
		##if event.is_action_pressed("pay_taxes"):  # Example for 'P' to reduce waste
			##if waste_count >= 70 and waste_count <= 95:
				##if gold_count >= 100:
					##waste_count = max(waste_count - int(waste_count * 0.20), 0)
					##gold_count -= 100
					##emit_signal("waste_bar_changed", waste_count)
					##$Bars/WasteBar/TextureProgress/AnimationPlayer.play("shake")
					##emit_signal("gold_updated", gold_count)
					##$Counters/GoldCounter/Number/AnimationPlayer.play("shake")
					##DialogManager.start_notification("You paid 50 gold to reduce waste by 20%!")
				##else:
					##DialogManager.start_notification("You don't have enough gold to reduce pollution. Wait for your passive income.")
		##elif event.is_action_pressed("buy_wood"):  # Example for 'W' to buy wood
			##if wood_count <= 10:
				##if gold_count >= 100:
					##gold_count -= 100
					##wood_count += 15
					##emit_signal("gold_updated", gold_count)
					##$Counters/GoldCounter/Number/AnimationPlayer.play("shake")
					##emit_signal("wood_updated", wood_count)
					##$Counters/WoodCounter/Number/AnimationPlayer.play("shake")
					##waste_count += int(waste_count * 0.20)
					##emit_signal("waste_bar_changed", waste_count)
					##$Bars/WasteBar/TextureProgress/AnimationPlayer.play("shake")
					##DialogManager.start_notification("You bought 15 wood for 100 gold and increased waste by 20%!")
				##else:
					##DialogManager.start_notification("You don't have enough gold to buy wood. Wait for your passive income.")
		##elif event.is_action_pressed("increase_happiness"):  # Example for 'H' to buy wood
			##if health_count >= 15 and health_count <= 25:
				##if gold_count >= 50:
					##gold_count -= 50
					##emit_signal("gold_updated", gold_count)
					##$Counters/GoldCounter/Number/AnimationPlayer.play("shake")
					##health_count += int(health_count * 0.20)
					##emit_signal("health_bar_changed", health_count)
					##$Bars/LifeBar/Count/AnimationPlayer.play("shake")
					##$Bars/LifeBar/TextureProgress/AnimationPlayer.play("shake")
					##DialogManager.start_notification("You increased 10% Happiness for 50 gold!")
				##else:
					##DialogManager.start_notification("You don't have enough gold to buy increase Happiness. Wait for your passive income.")

# Update functions for the UI elements
func _update_gold_label(_gold_count):
	#print("Updating gold label: ", _gold_count)  # Debug print
	$Counters/GoldCounter/Number.text = str(_gold_count)
	$Counters/GoldCounter/Number/AnimationPlayer.play("shake")
	
func update_gold_count(new_count: int) -> void:
	gold_count = new_count
	emit_signal("gold_count_changed", gold_count)

func _update_wood_label(_wood_count):
	#print("Updating wood label: ", _wood_count)  # Debug print
	$Counters/WoodCounter/Number.text = str(_wood_count)
	$Counters/WoodCounter/Number/AnimationPlayer.play("shake")

func _update_house_label(_house_count):
	#print("Updating house label: ", _house_count)  # Debug print
	$Counters/HouseCounter/Number.text = str(_house_count)
	$Counters/HouseCounter/Number/AnimationPlayer.play("shake")

func _update_citizen_label(_citizen_count):
	#print("Updating citizen label: ", _citizen_count)  # Debug print
	$Counters/CitizenCounter/Number.text = str(_citizen_count)
	$Counters/CitizenCounter/Number/AnimationPlayer.play("shake")

func _update_health_bar(_health_count):
	#print("Updating health bar: ", _health_count)  # Debug print
	$Bars/LifeBar/Count/Number.text = str(_health_count)
	#$Bars/LifeBar/Count/AnimationPlayer.play("shake")
	$Bars/LifeBar/TextureProgress.value = _health_count
	$Bars/LifeBar/TextureProgress/AnimationPlayer.play("shake")

func _update_waste_bar(_waste_count):
	#print("Updating waste bar: ", _waste_count)  # Debug print
	$Bars/WasteBar/Count/Number.text = str(_waste_count)
	#$Bars/WasteBar/Count/AnimationPlayer.play("shake")
	$Bars/WasteBar/TextureProgress.value = _waste_count
	$Bars/WasteBar/TextureProgress/AnimationPlayer.play("shake")

func _switch_to_game_over_scene():
	var game_over_scene = load("res://path/to/game_over_scene.tscn")
	get_tree().change_scene_to(game_over_scene)

	
