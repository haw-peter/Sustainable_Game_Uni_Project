extends Card

func apply_effects(player_stats: PlayerStats):
	player_stats.capital -= self.cost
	player_stats.waste_multiplier -= 0.01
	player_stats.happiness -= 0.05
	
