class_name CardUI
extends Control

signal reparent_requested(card_ui: CardUI)

@onready var color: ColorRect = $Color
@onready var label: Label = $Label
@onready var card_state_mashine: CardStateMashine = $CardStateMashine as CardStateMashine
@onready var drop_point_detector = $DropPointDetector
@onready var targets: Array[Node] = []



func _ready():
	card_state_mashine.init(self)

func _input(event: InputEvent):
	card_state_mashine.on_input(event)

#func on_input(event: InputEvent):
	#card_state_mashine.on_input(event)

func on_gui_input(event: InputEvent):
	card_state_mashine.on_gui_input(event)

func on_mouse_entered():
	card_state_mashine.on_mouse_entered()
	
func on_mouse_exited():
	card_state_mashine.on_mouse_exited()



func _on_drop_point_detector_area_entered(area: Area2D):
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detector_area_exited(area: Area2D):
	targets.erase(area)
