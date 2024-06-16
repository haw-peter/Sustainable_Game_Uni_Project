extends Card

func apply_effects(_player_stats: PlayerStats):
	Events.draw_cards.emit(2)
	_player_stats.resources_changed.emit()
########## Remove underscore _ in function call, if you use var player_stats ########## 
