class_name CardUI
extends Control

signal reparent_requested(card_ui: CardUI)
signal card_set(card_id: CardUI)

@export var card: Card : set = _set_card
@export var player_stats: PlayerStats : set = _set_player_stats

@onready var color: ColorRect = $Color
@onready var label: Label = $Label
@onready var picture: TextureRect = $Picture
@onready var description: Label = $Description
@onready var cost: Label = $Cost

@onready var card_state_mashine: CardStateMashine = $CardStateMashine as CardStateMashine
@onready var drop_point_detector = $DropPointDetector
@onready var targets: Array[Node] = []
@onready var original_index = self.get_index()

var parent: Control
var tween: Tween

var playable : bool = true 

func _ready():
	card_state_mashine.init(self)

func _input(event: InputEvent):
	card_state_mashine.on_input(event)

func animate_to_position(new_position: Vector2, duration: float):
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)

func play():
	if not card:
		return
	card.play(player_stats)
	player_stats.discard_pile.add_card(self.card)
	queue_free()

func on_gui_input(event: InputEvent):
	card_state_mashine.on_gui_input(event)

func on_mouse_entered():
	card_state_mashine.on_mouse_entered()
	
func on_mouse_exited():
	card_state_mashine.on_mouse_exited()

func _set_playable() -> void:
	if card.cost <= player_stats.capital:
		playable = true
		cost.modulate = Color(1, 1, 1, 1)
		picture.modulate = Color(1, 1 ,1 , 1)
		
	else:
		playable = false
		cost.modulate = Color(1, 0, 0, 1)
		picture.modulate = Color(1, 1 , 1 , 0.5)
	
	# special condition for draw 2 card
	if card.id == "Draw 2" && player_stats.draw_pile.cards.size() < 2:
		playable = false
		cost.modulate = Color(1, 0, 0, 1)
		picture.modulate = Color(1, 1 , 1 , 0.5)


func _set_player_stats(value: PlayerStats):
	player_stats = value
	player_stats.resources_changed.connect(_set_playable)
	_set_playable()
	

func _set_card(value: Card):
	if not is_node_ready():
		await ready
	card = value
	color.color = card.color
	label.text = card.id
	picture.texture = card.pic
	description.text = card.description
	cost.text = str(card.cost)
	

func _on_drop_point_detector_area_entered(area: Area2D):
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D):
	targets.erase(area)
