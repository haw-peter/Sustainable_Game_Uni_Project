extends CardState


func enter():
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill()
	card_ui.reparent_requested.emit(card_ui)

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("leftMouse") && card_ui.playable:
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)

func on_mouse_entered():
	card_ui.color.color = Color.STEEL_BLUE

func on_mouse_exited():
	card_ui.color.color = card_ui.card.color


