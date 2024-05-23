class_name PlayerStats
extends Stats

@export var starting_deck: CardPile
@export var cards_per_turn: int # defines amount of cards drawn in per turn

var deck: CardPile
var discard_pile: CardPile
var draw_pile: CardPile

# prototype for later, checks if card can be played based on parameters yet to be defined
func can_play_card(card: Card) -> bool:
	return false

# creates a Deck we can add cards to without changing the original resource
func create_instance() -> Resource:
	var instance: PlayerStats = self.duplicate()
	instance.capital = max_capital
	instance.waste = 0
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard_pile = CardPile.new()
	return instance
