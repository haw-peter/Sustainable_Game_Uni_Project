extends Node

# Card-related events
signal card_aim_started(tile: int)
signal card_aim_ended(card_ui: CardUI)
signal card_played(card: Card)
signal delete_card(card_ui: CardUI)

signal player_hand_drawn

signal draw_cards(amount: int)
signal place_tile(card: Card)
signal tile_placed()
