class_name Stats
extends Resource

# used to signal ui update
signal resources_changed

# set max/min values of the resourses
@export var max_capital = 500
@export var min_capital = 0
@export var max_waste = 500

# here are the resources of the player 
var capital: int : set = set_capital
var waste: int : set = set_waste

# setter for the resources
func set_capital(value: int):
	capital = clampi(value, min_capital, max_capital)
	resources_changed.emit()

func set_waste(value: int):
	waste = clampi(value, 0 , max_waste)
	resources_changed.emit()

# function to change capital, when negative lose capital
func change_capital(amount: int):
	self.capital += amount

func change_waste(amount: int):
	self.waste += amount

func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.capital = max_capital
	instance.waste = 0
	return instance
