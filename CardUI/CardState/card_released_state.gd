extends CardState

var played: bool

func enter():
	card_ui.color.color = Color.DARK_VIOLET
	card_ui.label.text = "Released"
	
	#played = false
	#
	#if not card_ui.targets.is_empty():
		#played = true
	card_ui.play()


