class_name Card
extends Resource

enum Type {BUILDING, RESOURCES, ENVIROMENT, DECKS}  #type of cards

@export_group("Card Attributes")
@export var id: String
@export var type: Type

func is_effecting_map() -> bool:
	return type == Type.BUILDING #returns true if CardType is BUILDING
