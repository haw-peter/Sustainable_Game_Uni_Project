extends Card

func apply_effects(player_stats: PlayerStats):
	player_stats.capital -= self.cost

