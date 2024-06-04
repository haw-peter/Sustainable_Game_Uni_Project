extends Node

func export_log_to_csv(log_file_path: String, csv_file_path: String):
	var log_file = FileAccess.open(log_file_path, FileAccess.READ)
	if not log_file:
		print("Failed to open log file:", log_file_path)
		return
		  
	var csv_file = FileAccess.open(csv_file_path, FileAccess.WRITE)
	if not csv_file:
		print("Failed to create CSV file:", csv_file_path)
		log_file.close()
		return
	
	var csv_content = "Gold,Building,Population,Happiness,Pollution\n" # CSV header
	var in_game_data = false
	var gold = 0
	var building = 0 
	var population = 0
	var happiness = 0
	var pollution = 0.0
	
	while !log_file.eof_reached():
		var line = log_file.get_line().strip_edges()
		if line == "":
			continue
		
		if line == "Game has started!":
			in_game_data = true
			continue
		
		if in_game_data:
			if line.begins_with("Gold:"):
				gold = line.get_slice(':', 1).strip_edges().to_int()
			elif line.begins_with("Building:"):
				building = line.get_slice(':', 1).strip_edges().to_int()
			elif line.begins_with("Population:"):
				population = line.get_slice(':', 1).strip_edges().to_int()
			elif line.begins_with("Happiness:"):
				happiness = line.get_slice(':', 1).strip_edges().to_int()
			elif line.begins_with("Pollution:"):
				pollution = line.get_slice(':', 1).strip_edges().to_float()
				
				# Write data to CSV
				csv_content += str(gold) + "," + str(building) + "," + str(population) + "," + str(happiness) + "," + str(pollution) + "\n"
	
	log_file.close()
	csv_file.store_string(csv_content)
	csv_file.close()
	print("CSV file created successfully:", csv_file_path)

