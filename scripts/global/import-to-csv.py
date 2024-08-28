import csv
import os
import glob

def export_logs_to_csv(log_directory, csv_file_path):
    # Find all log files matching the pattern "godot*.log" in the specified directory
    log_files = glob.glob(os.path.join(log_directory, 'godot*.log'))
    
    if not log_files:
        print(f"No log files found in directory: {log_directory}")
        return

    csv_header = [
        "PlayerID", "Timestamp", "Gold", "Building", "Population", "Happiness", "Pollution",
        "Action", "Draw 2", "Recycling Station", "House", "Eco-House", "Factory", "Buy Tile",
        "isCardDrawn", "isCardDiscarded"
    ]

    csv_content = []
    
    for log_file_path in log_files:
        try:
            with open(log_file_path, 'r') as log_file:
                log_lines = log_file.readlines()
        except IOError:
            print(f"Failed to open log file: {log_file_path}")
            continue

        in_game_data = False
        unique_id = ""
        timestamp = ""
        gold = 0
        building = 0
        population = 0
        happiness = 0
        pollution = 0.0
        action = "null"
        card_drawn = False
        card_discarded = False
        inventory_cards = {"Draw 2": 0, "Recycling Station": 0, "House": 0, "Eco-House": 0, "Factory": 0, "Buy Tile": 0}

        def append_csv_row():
            nonlocal csv_content, unique_id, timestamp, gold, building, population, happiness, pollution, action, card_drawn, card_discarded, inventory_cards
            row = [
                unique_id, timestamp, gold, building, population, happiness, pollution,
                action, inventory_cards["Draw 2"], inventory_cards["Recycling Station"], inventory_cards["House"],
                inventory_cards["Eco-House"], inventory_cards["Factory"], inventory_cards["Buy Tile"],
                card_drawn, card_discarded
            ]
            csv_content.append(row)
            for key in inventory_cards.keys():
                inventory_cards[key] = 0
            card_drawn = False
            card_discarded = False
            action = "null"

        for line in log_lines:
            line = line.strip()
            if not line:
                continue

            if line == "Game has started!":
                in_game_data = True
                continue

            if in_game_data:
                if line.startswith("Unique ID: "):
                    unique_id = line.split(":", 1)[1].strip()
                elif line.startswith("Card Played: "):
                    action = line.split(":", 1)[1].strip()
                elif line.startswith("Timestamp: "):
                    if timestamp:
                        append_csv_row()
                    timestamp = line.split(":", 1)[1].strip()
                elif line.startswith("Gold: "):
                    gold = int(line.split(":", 1)[1].strip())
                elif line.startswith("Building: "):
                    building = int(line.split(":", 1)[1].strip())
                elif line.startswith("Population: "):
                    population = int(line.split(":", 1)[1].strip())
                elif line.startswith("Happiness: "):
                    happiness = int(line.split(":", 1)[1].strip())
                elif line.startswith("Pollution: "):
                    pollution = float(line.split(":", 1)[1].strip())
                elif line.startswith("Inventory: "):
                    inventory_item = line.split(":", 1)[1].strip()
                    if inventory_item in inventory_cards:
                        inventory_cards[inventory_item] += 1
                elif line.startswith("Cards Drawn: "):
                    card_drawn = True
                elif line.startswith("Cards Discarded: "):
                    card_discarded = True

        # Write the last row if there is one
        if timestamp:
            append_csv_row()

    try:
        with open(csv_file_path, 'w', newline='') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(csv_header)
            writer.writerows(csv_content)
        print(f"CSV file successfully created: {csv_file_path}")
    except IOError:
        print(f"Failed to write CSV file: {csv_file_path}")

# Example usage
log_directory = '/Users/ahmed.aboshtaia/Documents/Logging-to-csv/'  # Replace with your directory containing log files
csv_file_path = '/Users/ahmed.aboshtaia/Documents/logs.csv'  # Replace with desired CSV output path
export_logs_to_csv(log_directory, csv_file_path)