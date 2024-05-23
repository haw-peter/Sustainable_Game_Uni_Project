class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL = 0.25

@export var hand: Hand

var player: PlayerStats

func start_game(player_stats: PlayerStats):
	player = player_stats
	player.draw_pile = player.deck.duplicate(true)
	player.draw_pile.shuffle()
	player.discard_pile = CardPile.new()
	start_turn()

func start_turn():
	draw_cards(player.cards_per_turn)

func draw_card():
	hand.add_card(player.draw_pile.draw_card())

func draw_cards(amount: int):
	var tween = create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(func(): Events.player_hand_drawn.emit())
