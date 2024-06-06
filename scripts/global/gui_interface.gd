extends Control

signal ping_gold(count)

var gold_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	var gold = get_node(".")
	gold.connect("ping_gold", Callable(self, "_fetching_gold"))
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
	#
func fetching_gold(new_count: int) -> void:
	gold_count = new_count
	emit_signal("gold_count_changed", gold_count)
	$MarginContainer/Counters/Ressources/Backround/gold_amount.text = str(6)
