extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.1
var minimum_drag_time_elapsed := false

func enter():
	var uiLayer := get_tree().get_first_node_in_group("ui_layer")
	if uiLayer:
		card_ui.reparent(uiLayer)
	
	card_ui.color.color = Color.NAVY_BLUE
	card_ui.label.text = "DRAGGING"
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)

func on_input(event: InputEvent):
	var is_effecting_map := card_ui.card.is_effecting_map()
	var mouseMotion := event is InputEventMouseMotion
	var cancel := event.is_action_pressed("rightMouse")
	var confirm := event.is_action_pressed("leftMouse") or event.is_action_released("leftMouse")
	var inside_play_area := not card_ui.targets.is_empty()
	
	if is_effecting_map and mouseMotion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return
	
	if mouseMotion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm and inside_play_area:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)

