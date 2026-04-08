extends Area2D

@export var COOLDOWN_MAX = 0.5
var cooldown_current = 0
var released = true

func _process(delta: float) -> void:
	position = get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and cooldown_current <= 0:
		$Sprite2D.rotation = 30
		if has_overlapping_bodies():
			for body in get_overlapping_bodies():
				body.queue_free()
		released = false
	else:
		if not released:
			cooldown_current=COOLDOWN_MAX
		$Sprite2D.rotation = 0
		cooldown_current-=delta
		released = true
