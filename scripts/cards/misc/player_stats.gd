class_name PlayerStats
extends Stats

@export var starting_deck: CardPile
@export var cards_per_turn: int # defines amount of cards drawn in per turn

@export var innit_capital : int
@export var innit_capital_gain : int
@export var innit_waste : float
@export var innit_happiness : float

var deck: CardPile
var discard_pile: CardPile
var draw_pile: CardPile

# prototype for later, checks if card can be played based on parameters yet to be defined
func can_play_card(_card: Card) -> bool:
	return false

# creates a Deck we can add cards to without changing the original resource
# initial values for resources here
func create_instance() -> Resource:
	var instance: PlayerStats = self.duplicate()
	instance.capital = innit_capital
	instance.waste = innit_waste
	instance.houses = 0
	instance.happiness = innit_happiness
	instance.citizens = 0
	instance.waste_multiplier = 0.0
	instance.happiness_multiplier = 0.0
	instance.capital_gain = innit_capital_gain
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard_pile = CardPile.new()
	return instance
