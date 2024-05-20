extends Node

# Card-related events
signal card_aim_started(tile: int)
signal card_aim_ended(card_ui: CardUI)
signal place_tile()

signal delete_card(card_ui: CardUI)
