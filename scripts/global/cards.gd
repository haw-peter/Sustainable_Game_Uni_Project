class_name Card
extends Resource

enum Type {BUILDING, RESOURCES, ENVIROMENT, DECKS}  #type of cards

@export_group("Card Attributes")
@export var id: String # card name
@export var type: Type
@export var tile_id: int
@export var pic: Texture
@export var description: String
@export var color: Color
@export var layer: int = 1

@export var cost : int
@export var inhabitants : int
# values for gaining every timeframe
@export var capital_gain : int
@export var waste_gain : float
@export var happiness_gain : float


func is_effecting_map() -> bool:
	return (type == Type.BUILDING) || (type == Type.ENVIROMENT) #returns true if CardType is BUILDING or ENVIRONMENT

func card_type() -> String:
	return Type.keys()[type]

func play(player_stats: PlayerStats):
	player_stats.capital -= self.cost
	player_stats.citizens += self.inhabitants
	player_stats.capital_gain += self.capital_gain
	player_stats.waste_multiplier += self.waste_gain
	player_stats.happiness_multiplier += self.happiness_gain
	print("Card Played: " + self.id)
	apply_effects(player_stats)
	Events.card_played.emit(self)
	# here change the player stats
	

#abstract function for the specific cards
func apply_effects(_player_stats: PlayerStats):
	pass
########## Remove underscore _ in function call, if you use var player_stats ########## 
