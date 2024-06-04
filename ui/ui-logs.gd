extends Node
# put time and 
func export_log_to_csv(file_path: String):
	var log_file = FileAccess.open(file_path, FileAccess.READ)
	var csv_content = "Gold,Building,Population,Happiness,Pollution\n" # CSV header
	
	if log_file:
		while !log_file.eof_reached():
			var line = log_file.get_line()
			if line.strip_edges().length() > 0:  # Skip empty lines
				var values = line.split(": ")[1].split(", ")  # Assuming log format is consistent
				
				# Extract values and append to CSV content
				var gold = values[0]
				var building = values[1]
				var population = values[2]
				var happiness = values[3]
				var pollution = values[4].strip_edges()  # Remove newline character
				
				csv_content += gold + "," + building + "," + population + "," + happiness + "," + pollution + "\n"
		
		log_file.close()
		
		# Write CSV content to file
		var csv_file = FileAccess.open(file_path.replace(".txt", ".csv"), FileAccess.WRITE)
		if csv_file:
			csv_file.store_string(csv_content)
			csv_file.close()
			print("Log data exported to CSV successfully!")
		else:
			print("Failed to create CSV file!")
	else:
		print("Failed to open log file!")

# Example usage
# export_log_to_csv("path/to/logfile.log")
