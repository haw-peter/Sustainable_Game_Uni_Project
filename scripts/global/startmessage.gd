extends Control

const line: String = "Hello Player! Welcome to our city! We love it here and want to see the city grow and prosper. Maybe you can help us?"

func _ready():
	DialogManager.start_notification(line)
