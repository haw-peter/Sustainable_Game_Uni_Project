extends Card

func apply_effects(player_stats: PlayerStats):
	player_stats.houses += 1
	player_stats.change_waste(-10)


