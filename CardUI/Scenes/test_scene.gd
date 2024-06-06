extends Node2D
@export var player_stats: PlayerStats
@onready var new_stats: PlayerStats = player_stats.create_instance()

@onready var turn_ui = $TurnUI as TurnUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler

var script_instance = preload("res://ui/ui-logs.gd").new() #new 

func _ready():
	turn_ui.player_stats = new_stats
	
	start_game(new_stats)

	new_stats.resources_changed.connect(_check_waste_level) #new
		
		
func start_game(stats: PlayerStats): 
	player_handler.start_game(stats)
	print("Game has started!\n")
	generate_unique_id() #new
	
# here should be the turn mechanics and the end condition

func _check_waste_level(): #new
	if new_stats.waste >= 1:
		end_game()
		script_instance.export_log_to_csv("user://logs/godot.log", "res://ui/logs.csv")
			
			
func end_game(): #new
		if(self.is_inside_tree()):
			get_tree().change_scene_to_file("res://menu/end_menu.tscn")
			print("Game Over! Waste level exceeded 100.")	
			
			
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
							
	print("Unique ID:", unique_id)

func _on_button_pressed():
	player_handler.draw_card()
