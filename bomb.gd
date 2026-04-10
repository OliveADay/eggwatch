extends Area2D


func _on_timer_timeout() -> void:
	$Sprite2D.frame = 1
	for body in get_overlapping_bodies():
		body.queue_free()
	$explod_hold.start()


func _on_explod_hold_timeout() -> void:
	queue_free()
