extends Control
#removed unrelevant code, only what's relevant is there (copy it all)
signal health_updated(value)
signal gold_updated(count)
signal house_updated(count)
signal citizen_updated(count)
signal health_bar_changed(value)
signal waste_bar_changed(value)


var time: float = 0.0
var hours: int = 12
var minutes: int = 0
var timestamp = "%02d:%02d" % [hours, minutes]

func _ready():
	# Connect to the update signals
	var interface_node = get_node(".")
	interface_node.connect("gold_updated", Callable(self, "_update_gold_label"))
	interface_node.connect("house_updated", Callable(self, "_update_house_label"))
	interface_node.connect("citizen_updated", Callable(self, "_update_citizen_label"))
	interface_node.connect("health_bar_changed", Callable(self, "_update_health_bar"))
	interface_node.connect("waste_bar_changed", Callable(self, "_update_waste_bar"))

	
func _process(delta):
	# Increment time
	time += delta
	minutes = fmod(time, 60) 
	hours = fmod(time, 3600) / 60
	# Update timestamp
	hours += 12
	timestamp = "%02d:%02d" % [hours, minutes]


func _update_gold_label(_gold_count):
	print("Timestamp: ", timestamp)
	print("Gold: ", _gold_count)  # Debug print
	$Counters/GoldCounter/Number.text = str(_gold_count)
	$Counters/GoldCounter/Number/AnimationPlayer.play("shake")


func _update_house_label(house_count):
	print("Building: ", house_count)  # Debug print
	$Counters/HouseCounter/Number.text = str(house_count)
	$Counters/HouseCounter/Number/AnimationPlayer.play("shake")

func _update_citizen_label(_citizen_count):
	print("Population: ", _citizen_count)  # Debug print
	$Counters/CitizenCounter/Number.text = str(_citizen_count)
	$Counters/CitizenCounter/Number/AnimationPlayer.play("shake")

func _update_health_bar(_health_count):
	print("Happiness: ", _health_count)  # Debug print
	$Bars/LifeBar/Count/Number.text = str(_health_count)
	$Bars/LifeBar/TextureProgress.value = _health_count
	$Bars/LifeBar/TextureProgress/AnimationPlayer.play("shake")

func _update_waste_bar(_waste_count):
	print("Pollution: ", _waste_count)  # Debug print
	$Bars/WasteBar/Count/Number.text = str(_waste_count)
	$Bars/WasteBar/TextureProgress.value = _waste_count
	$Bars/WasteBar/TextureProgress/AnimationPlayer.play("shake")

	
