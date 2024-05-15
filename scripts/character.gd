extends Node2D

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	#sprite.frame_coords = Vector2i(randi_range(24, 31), randi_range(0, 4))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(battle_array):
	animation_player.play("Attack")
	get_parent().damage += 1
