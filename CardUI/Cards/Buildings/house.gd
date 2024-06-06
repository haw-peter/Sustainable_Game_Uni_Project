extends Card

func apply_effects(player_stats: PlayerStats):
	player_stats.capital -= self.cost
	player_stats.citizens += self.inhabitants
	player_stats.houses += 1 # added house incrementer
	print("Card ID: 4") # added card id
