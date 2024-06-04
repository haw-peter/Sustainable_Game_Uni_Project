class_name PlayerStats
extends Stats

@export var starting_deck: CardPile
@export var cards_per_turn: int # defines amount of cards drawn in per turn

var deck: CardPile
var discard_pile: CardPile
var draw_pile: CardPile

# prototype for later, checks if card can be played based on parameters yet to be defined
func can_play_card(_card: Card) -> bool:
	return false

# creates a Deck we can add cards to without changing the original resource
func create_instance() -> Resource:
	var instance: PlayerStats = self.duplicate()
	instance.capital = 500
	instance.waste = 0
	instance.houses = 0
	instance.happiness = 50
	instance.citizens = 0
	instance.waste_multiplier = 0.01
	instance.happiness_multiplier = 1.0
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard_pile = CardPile.new()
	return instance

