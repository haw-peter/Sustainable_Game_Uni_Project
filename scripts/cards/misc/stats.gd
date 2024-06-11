class_name Stats
extends Resource

# used to signal ui update
signal resources_changed

# set max/min values of the resourses
@export var max_capital = 500
@export var min_capital = 0
@export var max_waste = 500
@export var max_citizens = 9999

# here are the resources of the player 
var capital: int : set = set_capital
var waste: float : set = set_waste
var happiness : int : set = set_happiness
var citizens : int : set = set_citizens

var waste_multiplier : float : set = set_waste_multiplier
var happiness_multiplier : float : set = set_happiness_multiplier

# setter for the resources
func set_capital(value: int):
	capital = clampi(value, min_capital, max_capital)
	resources_changed.emit()

func set_waste(value: float):
	waste = clamp(value, 0 , max_waste)
	resources_changed.emit()

func set_happiness(value: int):
	happiness = clampi(value, 0 , 100)
	resources_changed.emit()

func set_citizens(value: int):
	citizens = clampi(value, 0 , max_citizens)
	resources_changed.emit()
	
func set_waste_multiplier(value: float):
	waste_multiplier = value
	
func set_happiness_multiplier(value: float):
	happiness_multiplier = value

# function to change capital, when negative lose capital
func change_capital(amount: int):
	self.capital += amount

func change_waste(amount: float):
	self.waste += amount

func change_happiness(amount: int):
	self.happiness += amount

func change_citizens(amount: int):
	self.citizens += amount

func create_instance() -> Resource:
	var instance: PlayerStats = self.duplicate()
	instance.capital = 500
	instance.waste = 0
	instance.happiness = 50
	instance.citizens = 0
	instance.waste_multiplier = 1.0
	instance.happiness_multiplier = 1.0
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard_pile = CardPile.new()
	return instance
