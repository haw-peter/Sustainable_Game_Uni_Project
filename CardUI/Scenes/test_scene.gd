extends Node2D

@export var player_stats: PlayerStats

@onready var turn_ui = $TurnUI as TurnUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler

func _ready():
	var new_stats: PlayerStats = player_stats.create_instance()
	turn_ui.player_stats = new_stats
	
	start_game(new_stats)

func start_game(stats: PlayerStats):
	player_handler.start_game(stats)
	print("Game has started!\n")

# here should be the turn mechanics and the end condition
