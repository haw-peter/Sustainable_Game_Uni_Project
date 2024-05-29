extends Card

func apply_effects(player_stats: PlayerStats):
	Events.draw_cards.emit(2)
