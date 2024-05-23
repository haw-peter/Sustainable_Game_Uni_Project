class_name Hand
extends HBoxContainer

@export var player_stats: PlayerStats

@onready var card_ui = preload("res://CardUI/Scenes/card_ui.tscn")


func _ready():
	pass


func _on_card_ui_reparent_requested(child: CardUI):
	child.reparent(self)

func add_card(card: Card): 
	var new_card_ui = card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.player_stats = player_stats



