extends RigidBody2D
var total = 0
var decrease_amount = 0
var decrease_increment = 0.03

func _ready() -> void:
	set_axis_velocity(Vector2(randf_range(-50,50),randf_range(-50,50)))

func _process(delta: float) -> void:
	scale.x = sin(total)*(1-decrease_amount)
	scale.y = (1-decrease_amount)
	total+=delta*10
func _physics_process(delta: float) -> void:
	if(decrease_amount < 1):
		decrease_amount+=decrease_increment
	else:
		queue_free()
	
