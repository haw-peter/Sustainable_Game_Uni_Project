extends Control

signal health_updated(value)
signal gold_updated(count)
#signal wood_updated(count)
signal house_updated(count)
signal citizen_updated(count)
signal health_bar_changed(value)
signal waste_bar_changed(value)

#var gold_count: int = 100 # Starting gold count
#var wood_count: int = 15  # Starting wood count
#var house_count: int = 0  # Starting house count
#var citizen_count: int = 0 # Starting citizens count
#var health_count: int = 50  # Starting health
#var waste_count: int = 50  # Starting waste
#var maximum = 100
#var minimum = 0
#var current_health = 50
#var current_waste = 0

func _ready():

	# Connect to the update signals
	var interface_node = get_node(".")
	interface_node.connect("gold_updated", Callable(self, "_update_gold_label"))
	interface_node.connect("house_updated", Callable(self, "_update_house_label"))
	interface_node.connect("citizen_updated", Callable(self, "_update_citizen_label"))
	interface_node.connect("health_bar_changed", Callable(self, "_update_health_bar"))
	interface_node.connect("waste_bar_changed", Callable(self, "_update_waste_bar"))
	#interface_node.connect("gold_count_changed", Callable(self, "update_gold_count"))


# Update functions for the UI elements
func _update_gold_label(_gold_count):
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
	#$Bars/LifeBar/Count/AnimationPlayer.play("shake")
	$Bars/LifeBar/TextureProgress.value = _health_count
	$Bars/LifeBar/TextureProgress/AnimationPlayer.play("shake")

func _update_waste_bar(_waste_count):
	print("Pollution: ", _waste_count)  # Debug print
	print("-----------------------------------------------------")
	$Bars/WasteBar/Count/Number.text = str(_waste_count)
	#$Bars/WasteBar/Count/AnimationPlayer.play("shake")
	$Bars/WasteBar/TextureProgress.value = _waste_count
	$Bars/WasteBar/TextureProgress/AnimationPlayer.play("shake")


	
