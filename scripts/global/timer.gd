extends Timer

func _ready():
	_on_option_button_item_selected(0) # set intital state

func _on_option_button_item_selected(index):
	match index:
		0:
			set_paused(true)
		1:
			set_wait_time(1)
			set_paused(false)
		2:
			set_wait_time(0.2)
			set_paused(false)
