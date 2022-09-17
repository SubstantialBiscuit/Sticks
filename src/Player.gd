extends KinematicBody2D


export(int) var MAX_SPEED = 100

var velocity = Vector2.ZERO

onready var animated_sprite := $Viewport/AnimatedSprite
onready var sticks = 0
onready var fct_manager = $FCTManager
var object_names: Array = []
var interactable_objects: Array = []


func _physics_process(delta):
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
	else:
		velocity.x = 0
		
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
	else:
		velocity.y = 0
		
	# Normilize to max speed
	velocity = velocity.normalized() * MAX_SPEED * delta
	
	move_and_collide(velocity)


func entered(object):
	# Ran when the player enters an interactable object
	if object.has_method("interact"):
		object_names.append(object.name)
		interactable_objects.append(object)


func exited(object):
	# Ran when player exits an interactable object
	var index = object_names.find(object.name)
	if index != -1:
		object_names.remove(index)
		interactable_objects.remove(index)


func _unhandled_input(event):
	if event.is_action_pressed("ui_select") and not object_names.empty():
		interactable_objects[0].interact(self)


func add_sticks(n: int):
	fct_manager.show_value("+ %s sticks" % n)
	sticks += n


func remove_sticks(n: int):
	if sticks >= n:
		fct_manager.show_value("- %s sticks" % n)
		sticks -= n
		return true
	
	fct_manager.show_value("not enough sticks")
	return false
