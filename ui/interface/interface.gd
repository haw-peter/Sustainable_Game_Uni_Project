extends Control

signal health_updated(value)
signal gold_updated(count)
signal house_updated(count)
signal citizen_updated(count)
signal health_bar_changed(value)
signal waste_bar_changed(value)


func _ready():
	# Connect to the update signals
	var interface_node = get_node(".")
	interface_node.connect("gold_updated", Callable(self, "_update_gold_label"))
	interface_node.connect("house_updated", Callable(self, "_update_house_label"))
	interface_node.connect("citizen_updated", Callable(self, "_update_citizen_label"))
	interface_node.connect("health_bar_changed", Callable(self, "_update_health_bar"))
	interface_node.connect("waste_bar_changed", Callable(self, "_update_waste_bar"))
	

func _update_gold_label(_gold_count):
	print("Timestamp: ","%02d:" % get_parent().get_parent().time.x , "%02d" % get_parent().get_parent().time.y)
	get_parent().get_parent().in_hand(null)
	print("Gold: ", _gold_count)  
	$Counters/GoldCounter/Number.text = str(_gold_count)
	$Counters/GoldCounter/Number/AnimationPlayer.play("shake")


func _update_house_label(house_count):
	print("Building: ", house_count)  
	$Counters/HouseCounter/Number.text = str(house_count)
	$Counters/HouseCounter/Number/AnimationPlayer.play("shake")

func _update_citizen_label(_citizen_count):
	print("Population: ", _citizen_count)  
	$Counters/CitizenCounter/Number.text = str(_citizen_count)
	$Counters/CitizenCounter/Number/AnimationPlayer.play("shake")

func _update_health_bar(_health_count):
	print("Happiness: ", _health_count)  
	$Bars/LifeBar/Count/Number.text = str(_health_count)
	$Bars/LifeBar/TextureProgress.value = _health_count
	$Bars/LifeBar/TextureProgress/AnimationPlayer.play("shake")

func _update_waste_bar(_waste_count):
	print("Pollution: ", _waste_count) 
	$Bars/WasteBar/Count/Number.text = str(_waste_count)
	$Bars/WasteBar/TextureProgress.value = _waste_count
	$Bars/WasteBar/TextureProgress/AnimationPlayer.play("shake")

	
