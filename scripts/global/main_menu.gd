extends Control
	
func _on_exit_pressed():
	$Buttons_sfx.play()
	get_tree().quit()
	

func _on_play_pressed():
	$Buttons_sfx.play()
	get_tree().change_scene_to_file("res://scenes/game.tscn")

