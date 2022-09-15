extends "res://src/Spawner.gd"

var spawn_area: PoolVector2Array
var triangle_areas: Array
var triangle_coordinates: Array
var triangle_cummulative_areas: Array

func setup_ready():
	spawn_area = get_node("SpawnArea").polygon

	# Setup the polygon triangles 
	calculate_triangles()
	triangle_cummulative_areas = cummulative_sum(triangle_areas)

func calculate_triangles():
	# Calculate triangles within polygon and their respective areas
	var triangles = Geometry.triangulate_polygon(spawn_area)
	triangle_coordinates = []
	triangle_areas = []

	for i in range(0, triangles.size(), 3):
		var a = triangles[i]
		var b = triangles[i + 1]
		var c = triangles[i + 2]

		triangle_coordinates.append(
			[spawn_area[a], spawn_area[b], spawn_area[c]]
		)
		triangle_areas.append(
			int(round(area_of_triangle(spawn_area[a], spawn_area[b], spawn_area[c])))
		)

func area_of_triangle(a: Vector2, b: Vector2, c: Vector2) -> float:
	# Calculate the area of a triangle from 3 points using Heron's formula
	var ab = a.distance_to(b)
	var bc = b.distance_to(c)
	var ac = a.distance_to(c)

	var semiperim = (ab + bc + ac) / 2
	return sqrt(
		semiperim * (semiperim - ab) * (semiperim - bc) * (semiperim - ac)
	)

func cummulative_sum(areas: Array) -> Array:
	# Create array of cumulative sums of values in weights
	var tot = 0
	var cum_sum = []
	for i in areas:
		tot += i
		cum_sum.append(tot)

	return cum_sum

func choose_triangle() -> Array:
	# Randomly chooses a triangle based on the weights
	var rand = randi() % (triangle_cummulative_areas[-1] + 1)
	var choice = 0
	
	# Selects the first scene where the random number is less than the cummulative
	# weight at that position
	for i in triangle_cummulative_areas:
		if rand <= i:
			return triangle_coordinates[choice]
		choice += 1

	return triangle_coordinates[-1]

func random_point(a: Vector2, b: Vector2, c: Vector2) -> Vector2:
	var p = randf()
	var q = randf()

	if (p + q) > 1:
		p = 1 - p
		q = 1 - q

	# A + AB * p + BC * q
	var x = a.x + (b.x - a.x) * p + (c.x - b.x) * q
	var y = a.y + (b.y - a.y) * p + (c.y - b.y) * q
	return Vector2(x, y)

func spawn_position():
	var triangle = choose_triangle()

	return random_point(triangle[0], triangle[1], triangle[2])
