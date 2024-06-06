extends Control

signal gold_updated(count)
signal gold_count_changed(count)

#@onready var tilemap_main = $"../../TilemapMain"

var gold_count: int = 40 # Starting gold count
#var current_action: String = "" # Track the current action the player wants to take

func _ready():
	# Connect to the tile placed signal
	# Connect to the update signals
	var interface_node = get_node(".")
	interface_node.connect("gold_updated", Callable(self, "_update_gold_label"))

# Update functions for the UI elements
func _update_gold_label(_gold_count):
	#print("Updating gold label: ", _gold_count)  # Debug print
	$Counters/GoldCounter/Number.text = str(_gold_count)
	
func update_gold_count(new_count: int) -> void:
	gold_count = new_count
	emit_signal("gold_count_changed", gold_count)


func _switch_to_game_over_scene():
	var game_over_scene = load("res://path/to/game_over_scene.tscn")
	get_tree().change_scene_to(game_over_scene)

	
