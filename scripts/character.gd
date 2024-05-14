extends Node2D

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame_coords = Vector2i(randi_range(24, 31), randi_range(0, 4))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
