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
	Events.card_played.connect(check_hand_empty)
	Events.draw_cards.connect(draw_cards)
	start_turn()

func start_turn():
	draw_cards(player.cards_per_turn)
	Events.player_hand_drawn.emit()

func draw_card():
	if(player.draw_pile.empty()):
			for c in player.discard_pile.cards.size():
				player.draw_pile.add_card(player.discard_pile.draw_card())
			player.draw_pile.shuffle()
	print("Inventory: ", player.draw_pile.cards[0].id)		
	hand.add_card(player.draw_pile.draw_card())

func draw_cards(amount: int):
	var tween = create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(func(): Events.player_hand_drawn.emit())

func discard_hand() -> void:
	for n in range(0, hand.get_child_count()):
		discard_card(n)
	
	start_turn()

func discard_card(index: int):
	player.discard_pile.add_card(hand.get_child(index).card)
	hand.get_child(index).queue_free()

func check_hand_empty(card: Card) -> void:
	# If (currently) draw from Deck, then dont fill hand
	if(card.type == card.Type.DECKS):
		return

	if(hand.get_child_count() < 1):
		start_turn()
