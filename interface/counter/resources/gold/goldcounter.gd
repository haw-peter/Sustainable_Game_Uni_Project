extends NinePatchRect


func _on_Interface_gold_changed(count):
	$Label.value = str(count)
