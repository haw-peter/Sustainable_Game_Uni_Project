class_name CardUI
extends Control

signal reparent_requested(card_ui: CardUI)

@export var card: Card

@onready var color: ColorRect = $Color
@onready var label: Label = $Label
@onready var card_state_mashine: CardStateMashine = $CardStateMashine as CardStateMashine
@onready var drop_point_detector = $DropPointDetector
@onready var targets: Array[Node] = []

var parent: Control
var tween: Tween

func _ready():
	card_state_mashine.init(self)

func _input(event: InputEvent):
	card_state_mashine.on_input(event)

func animate_to_position(new_position: Vector2, duration: float):
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)

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
