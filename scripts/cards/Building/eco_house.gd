extends Card

func apply_effects(player_stats: PlayerStats):
	player_stats.capital -= self.cost
	player_stats.citizens += self.inhabitants
	player_stats.houses += 1
	player_stats.waste_multiplier += 0.01
	player_stats.happiness_multiplier += 0.01
	print("Card Played: " + self.id)
