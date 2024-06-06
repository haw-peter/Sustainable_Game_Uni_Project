extends Card

func apply_effects(player_stats: PlayerStats):
	player_stats.capital -= self.cost
	player_stats.citizens += self.inhabitants
	player_stats.houses += 1 # added house incrementer
	player_stats.waste_multiplier -= 0.05
	print("Card ID: 5") # print card id

