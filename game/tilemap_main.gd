extends Node2D

var StartSize = 20
var Dic = {}
var LastIndicator = Vector2i(0,0)
var TileDic = get_all_tile_coords($TileMap.get_tileset().get_source(1))

var SelectedItem = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap = $TileMap
	
# initial Mapgeneration
	for x in range(-StartSize, StartSize, 1):
		for y in range(-StartSize, StartSize, 1):
			Dic[str(Vector2i(x,y))] = {
				"Type" : "Grass"
				}
			tilemap.set_cell(0, Vector2i(x,y), 0, Vector2i(5,1),0)


func _input(event):
	
	#if event is InputEventMouseMotion:
		#$TileMap.set_cell(1, LastIndicator, 1, Vector2i(0,0),-1) # delete old 
		#$TileMap.clear_layer(1)
		#$TileMap.set_cell(1, $TileMap.local_to_map(get_global_mouse_position()), 1, TileDic[SelectedItem],0) # 
		
	if event.is_action_pressed("Change+"):
		if SelectedItem < 64:
			SelectedItem += 1
		else:
			SelectedItem = 1
	if event.is_action_pressed("Change-"):
		if SelectedItem == 1:
			SelectedItem = 64
		else:
			SelectedItem -= 1
	
	if event.is_action_pressed("Place"):
		$TileMap.set_cell(1, $TileMap.local_to_map(get_global_mouse_position()), 1, TileDic[SelectedItem],0)
	if event.is_action_pressed("Remove"):
		$TileMap.erase_cell(1, $TileMap.local_to_map(get_global_mouse_position()))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("Selected Index", SelectedItem)
	$TileMap.clear_layer(2)
	$TileMap.set_cell(2, $TileMap.local_to_map(get_global_mouse_position()), 1, TileDic[SelectedItem],0) # 

static func get_all_tile_coords(tile_source: TileSetSource) -> Array[Vector2i]:	
	var coords: Array[Vector2i] = []

	for i in tile_source.get_tiles_count():
		coords.append(tile_source.get_tile_id(i))

	return coords
