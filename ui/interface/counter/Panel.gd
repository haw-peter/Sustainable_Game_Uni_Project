extends Panel

signal time_changed(hours: int, minutes: int)

var time: float = 0.0
var hours: int = 12
var minutes: int = 0

var time_accumulator: float = 0.0
var gold_increment_interval: float = 10.0  # Interval for gold increment in seconds
var gold_increment_amount: int = 50  # Amount of gold to increment

func _ready():
	# Connect to the gold count changed signal from interface.gd
	var interface_node = get_node("/root/Main/Camera2D/Interface")
	if interface_node:
		interface_node.connect("gold_count_changed", Callable(self, "_update_gold_label"))

func _process(delta) -> void:
	time += delta
	minutes = fmod(time, 60) 
	hours = fmod(time, 3600) / 60
	$Hours.text = "%02d:" % hours
	$Minutes.text = "%02d" % minutes
	
	#emit_signal("time_changed", hours, minutes)  # Emit signal whenever time changes

	time_accumulator += delta
	# Check if it's time to increment gold
	if time_accumulator >= gold_increment_interval:
		time_accumulator -= gold_increment_interval  # Reset the accumulator
		# Increment gold count
		var interface_node = get_node("/root/Main/Camera2D/Interface")
		if interface_node:
			interface_node.gold_count += gold_increment_amount


#
func _update_gold_label(gold_count: String) -> void:
	print("Updating gold label: ", gold_count)  # Debug print
	$Counters/GoldCounter/Number.text = str(gold_count)
	$Counters/GoldCounter/Number/AnimationPlayer.play("shake")

func stop() -> void:
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d" % [hours, minutes]


