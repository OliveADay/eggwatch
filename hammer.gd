extends Area2D

@export var COOLDOWN_MAX = 0.5
var cooldown_current = 0
var released = true
var first = false

func _process(delta: float) -> void:
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("mouse1") and cooldown_current <= 0:
		$Sprite2D.rotation = 30
		$hit.play()
		cooldown_current=COOLDOWN_MAX
		if has_overlapping_bodies() and not first:
			get_overlapping_bodies()[0].coined.emit()
			get_overlapping_bodies()[0].queue_free()
			first = true
	else:
		first = false
		$Sprite2D.rotation = 0
		cooldown_current-=delta
