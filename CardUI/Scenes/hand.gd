class_name Hand
extends HBoxContainer

@onready var card_ui = preload("res://CardUI/Scenes/card_ui.tscn")


func _ready():
	for child in get_children():
		var card_ui := child as CardUI
		card_ui.parent = self
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	Events.delete_card.connect(remove_card)

func _on_card_ui_reparent_requested(child: CardUI):
	child.reparent(self)

func add_card(card: Card): 
	var new_card_ui = card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self

func remove_card(card_ui: CardUI):
	card_ui.queue_free()

