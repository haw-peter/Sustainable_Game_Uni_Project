extends Panel


var time: float = 0.0
var hours: int = 12
var minutes: int = 0


func _process(delta) -> void:
	time += delta
	minutes = fmod(time, 60) 
	hours = fmod(time, 3600) / 60
	$Hours.text = "%02d:" % hours
	$Minutes.text = "%02d" % minutes

func stop() -> void:
	set_process(false)
	
func get_time_formatted() -> String:
	return "%02d:%02d" % [hours, minutes]
