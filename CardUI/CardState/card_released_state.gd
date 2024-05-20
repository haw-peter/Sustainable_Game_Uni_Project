extends CardState

var played: bool

func enter():
	card_ui.color.color = Color.DARK_VIOLET
	card_ui.label.text = "Released"
	
	played = false
	
	if not card_ui.targets.is_empty():
		played = true
		print("play card for target(s):", card_ui.targets)

func on_input(event: InputEvent):
	if played:
		Events.delete_card.emit(self.card_ui)
		return
	
	Events.delete_card.emit(self.card_ui)
	#transition_requested.emit(self, CardState.State.BASE)
