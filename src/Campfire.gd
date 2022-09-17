extends "res://src/InteractableObject.gd"


onready var fct_manager = $FCTManager
onready var fuel = 100
onready var light = $Light


func _ready():
	animated_sprite.playing = true


func interact(player):
	# Add fuel to fire
	if fuel > 90:
		fct_manager.show_value("Fire full")
	elif player.remove_sticks(10):
		fuel += 10
		update_animation()


func update_animation():
	var fuel_proportion = float(fuel) / 100.0
	light.texture_scale = 3.0 + 7.0 * fuel_proportion
	light.energy = 0.5 + 0.5 * fuel_proportion

	if fuel > 70:
		animated_sprite.animation = "large"
	elif fuel > 30:
		animated_sprite.animation = "medium"
	elif fuel > 0:
		animated_sprite.animation = "small"
	else:
		animated_sprite.animation = "dead"


func _on_Timer_timeout():
	if fuel > 0:
		fuel = max(0, fuel - 1)
		update_animation()
