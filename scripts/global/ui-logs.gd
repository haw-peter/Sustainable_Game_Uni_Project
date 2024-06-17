extends Node

func export_log_to_csv(log_file_path: String, csv_file_path: String):
	var log_file = FileAccess.open(log_file_path, FileAccess.READ)
	if not log_file:
		print("Failed to open log file:", log_file_path)
		return
		
	var csv_content = ""
	var in_game_data = false
	var unique_id = ""
	var timestamp = ""
	var gold = 0
	var building = 0
	var population = 0
	var happiness = 0
	var pollution = 0.0
	var action = "0"
	var card_drawn = false
	var card_discarded = false
	var inventory_cards = {"Draw 2": 0, "Recycling Station": 0, "House": 0, "Eco-House": 0, "Factory": 0, "Buy Tile": 0}
	
	while not log_file.eof_reached():
		var line = log_file.get_line().strip_edges()
		if line == "":
			continue
			
		if line == "Game has started!":
			in_game_data = true
			continue
		
		
		if in_game_data:
			if line.begins_with("Unique ID:"):
				unique_id = line.get_slice(':', 1).strip_edges()
			elif line.begins_with("Card Played:"):
				action = line.get_slice(':', 1).strip_edges()	
			elif line.begins_with("Timestamp:"):
					if timestamp != "":
						csv_content += unique_id + "," + timestamp + "," + str(gold) + "," + str(building) + "," + str(population) + "," + str(happiness) + "," + str(pollution)
						csv_content += "," + action + "," + str(inventory_cards["Draw 2"]) + "," + str(inventory_cards["Recycling Station"]) + "," + str(inventory_cards["House"]) + "," + str(inventory_cards["Eco-House"]) + "," + str(inventory_cards["Factory"]) + "," + str(inventory_cards["Buy Tile"])
						csv_content += "," + str(card_drawn) + "," + str(card_discarded) + "\n"
						for key in inventory_cards.keys():
							inventory_cards[key] = 0
						card_drawn = false
						card_discarded = false
						action = "0"
					timestamp = line.substr(line.find(":") + 2).strip_edges()
			elif line.begins_with("Gold:"):
				gold = line.get_slice(':', 1).strip_edges().to_int()
			elif line.begins_with("Building:"):
				building = line.get_slice(':', 1).strip_edges().to_int()
			elif line.begins_with("Population:"):
				population = line.get_slice(':', 1).strip_edges().to_int()
			elif line.begins_with("Happiness:"):
				happiness = line.get_slice(':', 1).strip_edges().to_int()
			elif line.begins_with("Pollution:"):
				pollution = line.get_slice(':', 1).strip_edges().to_float()
			elif line.begins_with("Inventory:"):
				for key in inventory_cards.keys():
					if line.find(key) != -1:
						inventory_cards[key] = 1
			elif line.begins_with("Cards Drawn:"):
				card_drawn = "true"
			elif line.begins_with("Cards Discarded:"):
				card_discarded = "true"	
	
	# Write the last row
	if timestamp != "":
		csv_content += unique_id + "," + timestamp + "," + str(gold) + "," + str(building) + "," + str(population) + "," + str(happiness) + "," + str(pollution)
		csv_content += "," + action + "," + str(inventory_cards["Draw 2"]) + "," + str(inventory_cards["Recycling Station"]) + "," + str(inventory_cards["House"]) + "," + str(inventory_cards["Eco-House"]) + "," + str(inventory_cards["Factory"]) + "," + str(inventory_cards["Buy Tile"])
		csv_content += "," + str(card_drawn) + "," + str(card_discarded) + "\n"
	
	log_file.close()
	
	if not FileAccess.file_exists(csv_file_path):
		var csv_file = FileAccess.open(csv_file_path, FileAccess.WRITE)
		var csv_header = "PlayerID,Timestamp,Gold,Building,Population,Happiness,Pollution,Action,Draw 2,Recycling Station,House,Eco-House,Factory,Buy Tile,isCardDrawn,isCardDiscarded\n" 
		csv_file.store_string(csv_header)
		csv_file.store_string(csv_content)
	else:     
		var csv_file = FileAccess.open(csv_file_path, FileAccess.READ_WRITE)
		# Append the new content
		csv_file.seek_end()
		csv_file.store_string(csv_content)
		csv_file.close()
	print("CSV file updated successfully:", csv_file_path)
