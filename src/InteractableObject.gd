extends Area2D


export(String) var label_text = "Interact"

onready var sprite_shader = $Sprite.material


func outline(enable: bool):
	if enable:
		sprite_shader.set_shader_param("color", Color.white)
	else:
		sprite_shader.set_shader_param("color", Color.black)


func interact(player):
	# Overwrite function to define interact behaviour
	print("%s interacting with %s" % [player.name, name])
	queue_free()


func _on_InteractableObject_mouse_entered():
	outline(true)

func _on_InteractableObject_mouse_exited():
	outline(false)

func _on_InteractableObject_body_entered(body):
	outline(true)
	if body.name == "Player":
		body.entered(self)

func _on_InteractableObject_body_exited(body):
	outline(false)
	if body.name == "Player":
		body.exited(self)
