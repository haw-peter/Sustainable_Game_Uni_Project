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

func is_effecting_map() -> bool:
	return type == Type.BUILDING #returns true if CardType is BUILDING

func card_type() -> String:
	return Type.keys()[type]

func play(_player_stats: PlayerStats):
	apply_effects()
	Events.card_played.emit(self)
	# here change the player stats
	

# abstract function for the specific cards
func apply_effects():
	pass
