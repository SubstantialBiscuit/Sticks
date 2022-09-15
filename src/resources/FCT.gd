extends Label

onready var tween = $Tween

func show_value(value, travel, duration, spread, color=Color.white):
	text = value
	add_color_override("font_color", color)
	
	var movement = travel.rotated(rand_range(-spread / 2, spread / 2))
	rect_pivot_offset = rect_size / 2
	
	tween.interpolate_property(
		self, "rect_position", rect_position, rect_position + movement, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		self, "modulate:a", 1.0, 0.0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	
	tween.start()
	yield(tween, "tween_all_completed")
	queue_free()
