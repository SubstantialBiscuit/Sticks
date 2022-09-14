extends "res://src/InteractableObject.gd"

var region_position = Vector2(256, 785)
onready var sprite: Sprite = $Sprite


func _ready():
	# TODO Fix selecting one of the two sprites
	if randi() % 2 == 1:
		sprite.region_rect = Rect2(
			region_position.x, region_position.y, 64, 64
		)
	else:
		sprite.region_rect = Rect2(
			region_position.x + 64, region_position.y, 64, 64
		)

func interact(player):
	print("Have some fucking sticks!")
	queue_free()
