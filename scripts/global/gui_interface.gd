extends Control

signal gold(count)
signal happiness(count)
signal pollution(value)
signal citizen(count)


# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	var resources = get_node(".")
	resources.connect("gold", Callable(self, "updating_gold"))
	resources.connect("happiness", Callable(self, "updating_happiness"))
	resources.connect("pollution", Callable(self, "updating_pollution"))
	resources.connect("citizen", Callable(self, "updating_citizen"))
	
func updating_gold(from_signal_gold):
	$MarginContainer/Counters/Ressources/Backround/gold_amount.text = str(from_signal_gold)
func updating_citizen(from_signal_citizen):
	$MarginContainer/Counters/Ressources/Backround/citizens_amount.text = str(from_signal_citizen)
func updating_pollution(from_signal_pollution):
	$MarginContainer/Bars/bar_one/Scale/Gauge.value = from_signal_pollution
func updating_happiness(from_signal_happiness):
	$MarginContainer/Bars/bar_one/Scale/Gauge_hap.value = from_signal_happiness

