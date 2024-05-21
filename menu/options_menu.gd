extends Control

func _on_back_pressed():
	$Buttons_sfx.play()
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
