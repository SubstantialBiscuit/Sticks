extends Area2D


onready var sprite_shader = $Sprite.material


func _on_InteractableObject_mouse_entered():
	# Outline the sprite on selection
	sprite_shader.set_shader_param("color", Color.white)


func _on_InteractableObject_mouse_exited():
	sprite_shader.set_shader_param("color", Color.black)


func _on_InteractableObject_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		interact()


func interact():
	# Overwrite function to define interact behaviour
	print("clicked")
	queue_free()
