class_name Stats
extends Resource

# used to signal ui update
signal resources_changed

# set max/min values of the resourses
@export var max_capital = 500
@export var min_capital = 0
@export var max_waste = 500
#@export var max_citizens = 9999
#@export var max_houses = 25

# here are the resources of the player 
var capital: int : set = set_capital
var waste: float : set = set_waste
var happiness : float : set = set_happiness
var citizens : int : set = set_citizens
var houses : int : set = set_houses

# passive gain for now
var waste_multiplier : float : set = set_waste_multiplier
var happiness_multiplier : float : set = set_happiness_multiplier

var capital_gain : float : set = set_capital_gain # passive capital gain for buildings such as factories

var res_buildings : int : set = set_res_buildings
var fac_buildings : int : set = set_fac_buildings

# setter for the resources
func set_capital(value: int):
	capital = clampi(value, min_capital, max_capital)
	resources_changed.emit()

func set_waste(value: float):
	waste = clampf(value, 0 , max_waste)
	resources_changed.emit()

func set_happiness(value: float):
	happiness = clampf(value, 0 , 100)
	resources_changed.emit()

func set_citizens(value: int):
	citizens = value
	resources_changed.emit()

func set_houses(value: int):
	houses = value
	resources_changed.emit()
	
func set_waste_multiplier(value: float):
	waste_multiplier = value
	
func set_happiness_multiplier(value: float):
	happiness_multiplier = value
	
func set_capital_gain(value: float):
	capital_gain = value

func set_res_buildings(value: int):
	res_buildings = value

func set_fac_buildings(value: int):
	fac_buildings = value

# function to change capital, when negative lose capital
func change_capital(amount: int):
	self.capital += amount
func change_houses(amount: int): #new
	self.houses += amount
func change_waste(amount: float):
	self.waste += amount
func change_happiness(amount: float):
	self.happiness += amount
func change_citizens(amount: int):
	self.citizens += amount
func change_happiness_multiplier(amount: int):
	self.happiness_multiplier += amount
func change_waste_multiplier(amount: int):
	self.waste_multiplier += amount
func change_capital_gain(amount: int):
	self.capital_gain += amount
func change_res_buildings(amount: int):
	res_buildings += amount
func change_fac_buildings(amount: int):
	fac_buildings += amount
