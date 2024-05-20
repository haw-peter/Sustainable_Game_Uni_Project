extends Node2D

var start_size = 20
var dic = {}
var last_indicator = Vector2i(0,0)
var tile_dic = get_all_tile_coords($TileMap.get_tileset().get_source(1))

var selected_item = 1
var selected_tile: int
@onready var tilemap = $TileMap

var aiming = false

# Called when the node enters the scene tree for the first time.
func _ready():
# initial Mapgeneration
	#for x in range(-start_size, start_size, 1):
		#for y in range(-start_size, start_size, 1):
			#dic[str(Vector2i(x,y))] = {
				#"Type" : "Grass"
				#}
			#tilemap.set_cell(0, Vector2i(x,y), 0, Vector2i(5,1),0)
	
	Events.card_aim_started.connect(show_cursor)
	Events.card_aim_ended.connect(hide_cursor)
	Events.place_tile.connect(place_tile)



func _input(event):
	if aiming:
		if event.is_action_pressed("Change+"):
			if selected_item < 64:
				selected_item += 1
			else:
				selected_item = 1
		if event.is_action_pressed("Change-"):
			if selected_item == 1:
				selected_item = 64
			else:
				selected_item -= 1
		
		#if event.is_action_pressed("Place"):
			#$TileMap.set_cell(1, $TileMap.local_to_map(get_global_mouse_position()), 1, tile_dic[selected_item],0)
		#if event.is_action_pressed("Remove"):
			#$TileMap.erase_cell(1, $TileMap.local_to_map(get_global_mouse_position()))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("Selected Index", selected_item)\
	if aiming:
		$TileMap.clear_layer(2)
		#$TileMap.set_cell(2, $TileMap.local_to_map(get_global_mouse_position()), 1, tile_dic[selected_item],0)
		$TileMap.set_cell(2, $TileMap.local_to_map(get_global_mouse_position()), selected_tile, Vector2i.ZERO, 0) 

static func get_all_tile_coords(tile_source: TileSetSource) -> Array[Vector2i]:	
	var coords: Array[Vector2i] = []

	for i in tile_source.get_tiles_count():
		coords.append(tile_source.get_tile_id(i))

	return coords

func show_cursor(tile: int):
	aiming = true
	selected_tile = tile
	tilemap.set_layer_enabled(2, true)

func hide_cursor():
	aiming = false
	tilemap.set_layer_enabled(2, !true)

func place_tile():
	$TileMap.set_cell(1, $TileMap.local_to_map(get_global_mouse_position()), selected_tile, Vector2i.ZERO, 0)


