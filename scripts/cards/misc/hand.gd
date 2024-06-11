class_name Hand
extends HBoxContainer

@export var player_stats: PlayerStats

@onready var card_ui = preload("res://scenes/cards/card_ui.tscn")
@onready var cards_played := 0

func _ready():
	Events.card_played.connect(_on_card_played)
	Events.player_hand_drawn.connect(_on_hand_drawn)
	Events.draw_cards.connect(_on_draw_cards)

func _on_card_ui_reparent_requested(child: CardUI):
	child.reparent(self)
	var new_index := clampi(child.original_index - cards_played, 0, get_child_count())
	move_child.call_deferred(child, new_index)

func add_card(card: Card): 
	var new_card_ui = card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.player_stats = player_stats

func _on_card_played(_card: Card):
	cards_played += 1

func _on_hand_drawn():
	cards_played = 0

func _on_draw_cards(amount: int):
	cards_played += amount
