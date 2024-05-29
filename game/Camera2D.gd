extends Camera2D

@export var EDGE_SCROLL = true

var BorderSize = 30 # Variable to set the Bordersize for camera
var CameraSpeed = 5 # Variable to adjust the camera movespeed

func _ready():
	NotificationManager.set_notification_parent(self)

func _process(_delta):

# Block to check if the Mouse is on the edge of the screen, if yes move the camera
	if EDGE_SCROLL:
		# Camera left
		if get_viewport().get_mouse_position().x <= BorderSize:
			position.x = lerp(position.x, position.x - CameraSpeed, 0.8)
			
		# Camera right
		if get_viewport().get_mouse_position().x >= get_viewport().get_visible_rect().size.x - BorderSize:
			position.x = lerp(position.x, position.x + CameraSpeed, 0.8)
			
		# Camera up
		if get_viewport().get_mouse_position().y <= BorderSize:
			position.y = lerp(position.y, position.y - CameraSpeed, 0.8)
			
		# Camera down
		if get_viewport().get_mouse_position().y >= get_viewport().get_visible_rect().size.y - BorderSize:
			position.y = lerp(position.y, position.y + CameraSpeed, 0.8)
	
	if Input.is_action_pressed("up"):
		position.y = lerp(position.y, position.y - CameraSpeed, 0.8)
	if Input.is_action_pressed("down"):
		position.y = lerp(position.y, position.y + CameraSpeed, 0.8)
	if Input.is_action_pressed("left"):
		position.x = lerp(position.x, position.x - CameraSpeed, 0.8)
	if Input.is_action_pressed("right"):
		position.x = lerp(position.x, position.x + CameraSpeed, 0.8)
	

func _input(event):
	
	# Zooms in/out Camera with Mwheel
	if event.is_action_pressed("Zoom+"):
		if zoom.x < 3:
			zoom = zoom + Vector2(0.05, 0.05)
	if event.is_action_pressed("Zoom-"):
		if zoom.x > 0.1:
			zoom = zoom - Vector2(0.05, 0.05)
