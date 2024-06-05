extends Card

func apply_effects(_player_stats: PlayerStats):
	Events.draw_cards.emit(2)
########## Remove underscore _ in function call, if you use var player_stats ########## 
