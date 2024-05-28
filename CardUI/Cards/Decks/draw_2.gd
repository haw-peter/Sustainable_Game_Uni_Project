extends Card

# here do things specified by the type of card
func apply_effects():
	Events.draw_cards.emit(2)
