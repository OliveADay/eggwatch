extends RigidBody2D
var total = 0

func _process(delta: float) -> void:
	scale.x = sin(total)
	total+=delta*10
