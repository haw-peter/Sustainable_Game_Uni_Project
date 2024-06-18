extends Node2D

@export var discard_cost: int = 100
@export var player_stats: PlayerStats

@onready var new_stats: PlayerStats = player_stats.create_instance()

@onready var turn_ui = $TurnUI as TurnUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler

var script_instance = preload("res://scripts/global/ui-logs.gd").new()


func _ready():
	turn_ui.player_stats = new_stats
	$TurnUI/Button.text = "Discard Hand for: " + str(discard_cost)
	
	start_game(new_stats)
	new_stats.resources_changed.connect(_check_waste_level)
	new_stats.resources_changed.connect(_notification)
	
func start_game(stats: PlayerStats):
	player_handler.start_game(stats)
	print("Game has started!\n")
	generate_unique_id()
	
# here should be the turn mechanics and the end condition	
	
	# game end condition
func _check_waste_level(): 
	if new_stats.waste >= 12: 
		end_game()
		script_instance.export_log_to_csv("user://logs/godot.log", "res://logs/logs.csv")
			
			
func end_game(): 
		if(self.is_inside_tree()):
			get_tree().change_scene_to_file("res://scenes/end_menu.tscn")
			print("Game Over! Waste level exceeded 100.")	
			
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		script_instance.export_log_to_csv("user://logs/godot.log", "res://logs/logs.csv")
		get_tree().quit()			
# Function to generate a unique ID based on the player's IP address
func generate_unique_id(): #new
	var ip_address = ""
								
	# get the first ipv4 address
	for address in IP.get_local_addresses():
								
		if (address.split('.').size() == 4):
			ip_address = address	
			break
							
	# hash the IP address to generate a unique ID
	var hash_value = hash(ip_address)
						
	# generate a random number
	var random_number = randi()
						
	# concatenate the random number to the hash value
	var unique_id = str(hash_value) + "_" + str(random_number)
							
	print("Unique ID: ", unique_id)

		
		
func _on_button_pressed():
	if new_stats.capital >= discard_cost:
		$TurnUI/Button.disabled = true
		player_handler.discard_hand()
		new_stats.change_capital(-discard_cost)
		await get_tree().create_timer(1.0).timeout
		$TurnUI/Button.disabled = false
		print("Cards Discarded: True")
	else:
		$PlayerHandler/AnimationPlayer.play("button_shake")
