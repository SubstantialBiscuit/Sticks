extends "res://src/InteractableObject.gd"



func _ready():
	animated_sprite.frame = randi() % 2

func interact(player):
	player.add_sticks((randi() % 5) + 1)
	queue_free()
