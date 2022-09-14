extends Node2D

export(PackedScene) var spawn_scene
export(int, 0, 100) var max_spawns = 1
export(int) var spawn_delay_milliseconds = 1000
export(int, 0, 100) var initial_spawns = 1

onready var spawned = $Spawned

onready var timer = $Timer

func _ready():
	set_timer()
	setup_ready()
	spawn(initial_spawns)
	
func setup_ready():
	# Function to be overwritten in sub-classes for setup
	print("Standard spawner setup %s" % position)
	pass


func set_timer():
	timer.wait_time = float(spawn_delay_milliseconds) / 1000
	timer.start()

func spawn_position():
	return Vector2.ZERO

func spawn_one():
	if spawned.get_child_count() >= max_spawns:
		return
	
	var entity = spawn_scene.instance()
	entity.position = spawn_position()
	spawned.add_child(entity)

func spawn(n):
	for _i in range(n):
		spawn_one()

func _on_Timer_timeout():
	spawn_one()
