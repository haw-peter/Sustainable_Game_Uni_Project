extends Node

@onready var text_box_scene = preload ("res://ui/textbox/textbox.tscn")

var notification_line: String = ""

var dialog_lines: Array[String] = []
var current_line_index = 0

var notification_box

var text_box
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false

func _ready():
	if NotificationManager.notification_parent != null:
		_show_notification_box()
	else:
		NotificationManager.connect("notification_parent_set", Callable(self, "_show_notification_box"))

func start_notification(line: String):
	notification_line = line

	_show_notification_box()
	
	is_dialog_active = true

func start_dialog(position: Vector2, lines: Array[String]):
	if is_dialog_active:
		return
	
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialog_active = true

func _show_notification_box():
	if NotificationManager.notification_parent != null && notification_line != "":
		notification_box = text_box_scene.instantiate()
		notification_box.finished_displaying.connect(_on_notification_box_finished_displaying)
		NotificationManager.notification_parent.add_child(notification_box)
		notification_box.display_text(notification_line)


func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	can_advance_line = false
	
func _on_text_box_finished_displaying():
		can_advance_line = true
		
func _on_notification_box_finished_displaying():
	$Timer.start()

func _unhaldled_input(event):
	if (
		event.is_action_pressed("advance_dialog") &&
		is_dialog_active &&
	can_advance_line
	):
		text_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			return
			
		_show_text_box()


func _on_timer_timeout():
	$Timer.stop()
	notification_box.queue_free()
