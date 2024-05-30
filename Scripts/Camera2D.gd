extends Camera2D

var BorderSize = 30 # Variable to set the Bordersize for camera
var CameraSpeed = 30 # Variable to adjust the camera movespeed

func _process(_delta):

# Block to check if the Mouse is on the edge of the screen, if yes move the camera
	if get_viewport().get_mouse_position().x <= BorderSize:
		position.x = lerp(position.x, position.x - CameraSpeed, 0.8)
		
	if get_viewport().get_mouse_position().x >= get_viewport().get_visible_rect().size.x - BorderSize:
		position.x = lerp(position.x, position.x + CameraSpeed, 0.8)
		
	if get_viewport().get_mouse_position().y <= BorderSize:
		position.y = lerp(position.y, position.y - CameraSpeed, 0.8)
		
	if get_viewport().get_mouse_position().y >= get_viewport().get_visible_rect().size.y - BorderSize:
		position.y = lerp(position.y, position.y + CameraSpeed, 0.6)
	

func _input(event):
# Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
	#elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		# Alternative CameraMovement
		#if Input.is_action_pressed("CameraMove"):
			#position += Vector2(-event.relative.x / 2, -event.relative.y / 2)
	# Zooms in/out Camera with Mwheel
	if zoom.x < 1.6 :
		if event.is_action_pressed("Zoom+") :
			zoom = zoom + Vector2(0.1, 0.1)
	if zoom.x > 0.4 :
		if event.is_action_pressed("Zoom-"):
			zoom = zoom - Vector2(0.1, 0.1)
			
	scale = Vector2(1 / zoom.x, 1 / zoom.y)
   # Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
	#print("Viewport Zoom: ", zoom)
