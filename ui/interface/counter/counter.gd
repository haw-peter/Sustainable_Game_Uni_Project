extends NinePatchRect


func _ready():
	# Connect to signals from the Interface node
	var interface_node = get_node("Camera2D/Interface")
	if interface_node:
		interface_node.connect("gold_updated", Callable(self, "_update_gold_label"))
		interface_node.connect("wood_updated", Callable(self, "_update_wood_label"))
		interface_node.connect("house_updated", Callable(self, "_update_house_label"))
	else:
		print("Interface node not found")

func _update_gold_label(gold_count):
	var gold_counter = $Counters/GoldCounter/Number
	if gold_counter:
		gold_counter.text = str(gold_count)
	else:
		print("Gold counter node not found")


func _update_wood_label(wood_count):
	var wood_counter = $Counters/WoodCounter/Number
	if wood_counter:
		wood_counter.text = str(wood_count)
	else:
		print("Wood counter node not found")
		

func _update_house_label(house_count):
	var house_counter = $Counters/HouseCounter/Number
	if house_counter:
		house_counter.text = str(house_count)
	else:
		print("House counter node not found")
