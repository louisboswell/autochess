extends Node2D

var character = preload("res://characters/base.tscn")
@onready var tilemap = get_node("TileMap")

var battle_array : Array = []

func _ready():
	_init_array()

# Initialise the battle array
func _init_array():
	var tilemap_size = tilemap.get_used_rect().size
	for x in range(tilemap_size.x):
		battle_array.append([])
		for y in range(tilemap_size.y):
			battle_array[x].append(0)

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = to_local(get_global_mouse_position())
		var tileset_coords = tilemap.local_to_map(mouse_pos)

		# If coords outside array size
		if tileset_coords.x < 0 or tileset_coords.y < 0 or tileset_coords.x >= battle_array.size() or tileset_coords.y >= battle_array[0].size():
			return

		if not battle_array[tileset_coords.x][tileset_coords.y]:
			var new_character = character.instantiate()
			new_character.position = tilemap.map_to_local(tileset_coords)
			add_child(new_character)

			battle_array[tileset_coords.x][tileset_coords.y] = new_character

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var mouse_pos = to_local(get_global_mouse_position())
		var tileset_coords = tilemap.local_to_map(mouse_pos)

		# If coords outside array size
		if tileset_coords.x < 0 or tileset_coords.y < 0 or tileset_coords.x >= battle_array.size() or tileset_coords.y >= battle_array[0].size():
			return

		if battle_array[tileset_coords.x][tileset_coords.y]:
			battle_array[tileset_coords.x][tileset_coords.y].queue_free()
			battle_array[tileset_coords.x][tileset_coords.y] = 0
