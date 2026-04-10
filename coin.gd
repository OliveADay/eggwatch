extends RigidBody2D
var total = 0

func _ready() -> void:
	set_axis_velocity(Vector2(randf_range(-50,50),randf_range(-50,50)))

func _process(delta: float) -> void:
	scale.x = sin(total)
	total+=delta*10
