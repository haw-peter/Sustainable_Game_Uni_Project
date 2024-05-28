class_name TurnUI
extends CanvasLayer

@export var player_stats: PlayerStats : set = _set_player_stats

@onready var hand: Hand = $Hand as Hand

func _set_player_stats(value: PlayerStats):
	player_stats = value
	hand.player_stats = player_stats
