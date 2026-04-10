extends Area2D
var exploding = false

func _process(delta: float) -> void:
	if exploding:
		for body in get_overlapping_bodies():
			body.coined.emit()
			body.queue_free()

func _on_timer_timeout() -> void:
	$Sprite2D.frame = 1
	exploding = true
	$explod_hold.start()


func _on_explod_hold_timeout() -> void:
	exploding = false
	queue_free()
