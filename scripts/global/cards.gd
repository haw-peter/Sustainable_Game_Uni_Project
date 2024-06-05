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

@export var cost : int
@export var inhabitants : int

func is_effecting_map() -> bool:
	return type == Type.BUILDING #returns true if CardType is BUILDING

func card_type() -> String:
	return Type.keys()[type]

func play(player_stats: PlayerStats):
	apply_effects(player_stats)
	Events.card_played.emit(self)
	# here change the player stats
	#remove 
	

#abstract function for the specific cards
func apply_effects(_player_stats: PlayerStats):
	pass
########## Remove underscore _ in function call, if you use var player_stats ########## 
