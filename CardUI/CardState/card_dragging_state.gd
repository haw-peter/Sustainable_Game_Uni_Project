extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05
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
	var mouseMotion := event is InputEventMouseMotion
	var cancel := event.is_action_pressed("rightMouse")
	var confirm := event.is_action_pressed("leftMouse") or event.is_action_released("leftMouse")
	
	if mouseMotion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)

