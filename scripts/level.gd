extends Node2D

var character = preload("res://characters/base.tscn")
@onready var tilemap = get_node("TileMap")

@onready var label = get_node("Label")

var battle_array : Array = []
var damage : int = 0
var attacking : bool = false

func _ready():
	_init_array()

func _process(delta):
	label.text = str(damage)
	pass

# Initialise the battle array
func _init_array():
	var tilemap_size = tilemap.get_used_rect().size
	for x in range(tilemap_size.x):
		var row = []
		for y in range(tilemap_size.y):
			row.append(0)
		battle_array.append(row)
	

func _input(event):

	if attacking:
		return

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


func _on_button_pressed():
	attacking = true
	var timer = 0.5

	
	for y in range(battle_array[0].size()):
		for x in range(battle_array.size()):
			if battle_array[x][y]:
				await get_tree().create_timer(0.1).timeout
				battle_array[x][y].attack(battle_array)
	attacking = false
