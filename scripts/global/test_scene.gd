extends Node2D

@export var discard_cost: int = 100
@export var player_stats: PlayerStats

@onready var new_stats: PlayerStats = player_stats.create_instance()

@onready var turn_ui = $TurnUI as TurnUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler


func _ready():
	turn_ui.player_stats = new_stats
	$TurnUI/Button.text = "Discard Hand for: " + str(discard_cost)
	
	start_game(new_stats)

func start_game(stats: PlayerStats):
	player_handler.start_game(stats)
	print("Game has started!\n")

# here should be the turn mechanics and the end condition

func _on_button_pressed():
	if new_stats.capital >= discard_cost:
		$TurnUI/Button.disabled = true
		player_handler.discard_hand()
		new_stats.change_capital(-discard_cost)
		await get_tree().create_timer(1.0).timeout
		$TurnUI/Button.disabled = false
	else:
		$PlayerHandler/AnimationPlayer.play("button_shake")
