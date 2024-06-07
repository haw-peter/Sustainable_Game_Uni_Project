extends Node

func export_log_to_csv(log_file_path: String, csv_file_path: String):
	var log_file = FileAccess.open(log_file_path, FileAccess.READ)
	if not log_file:
		print("Failed to open log file:", log_file_path)
		return
		  
	var csv_content = "Timestamp,Gold,Building,Population,Happiness,Pollution,CardID\n" # CSV header
	var in_game_data = false
	var gold = 0
	var building = 0 
	var population = 0
	var happiness = 0
	var pollution = 0.0
	var card_id = ""
	var timestamp = ""
	var unique_id = ""
	
	while not log_file.eof_reached():
		var line = log_file.get_line().strip_edges()
		if line == "":
			continue
		
		if line == "Game has started!":
			in_game_data = true
			continue
			
		# Rename the CSV file with the unique ID appended
		if line.begins_with("Unique ID:"):
			unique_id = line.get_slice(':', 1).strip_edges()
			print("Unique ID found:", unique_id)			
		
		if in_game_data:
			if line.begins_with("Card ID:"):
				card_id = line.get_slice(':', 1).strip_edges()
			elif line.begins_with("Timestamp:"):
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
				# Write data to CSV after reading the full block (Pollution is the last line in the block)
				csv_content += timestamp + "," + str(gold) + "," + str(building) + "," + str(population) + "," + str(happiness) + "," + str(pollution)
				if card_id != "":
					csv_content += "," + card_id
					card_id = ""
				else: 	
					csv_content += " "
				csv_content += "\n"
	
	log_file.close()
	
	# Create a unique CSV file name based on timestamp
	csv_file_path = csv_file_path.replace(".csv", "_" + unique_id + ".csv")
	
	var csv_file = FileAccess.open(csv_file_path, FileAccess.WRITE)
	if not csv_file:
		print("Failed to create CSV file:", csv_file_path)
		return
	
	csv_file.store_string(csv_content)
	csv_file.close()
	print("CSV file created successfully:", csv_file_path)
