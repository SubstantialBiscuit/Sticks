extends KinematicBody2D


export(int) var MAX_SPEED = 100

var velocity = Vector2.ZERO

onready var animated_sprite := $Viewport/AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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

