extends RigidBody2D
@export var SPEED = 2
var egg:Node2D

func _ready() -> void:
	egg = get_tree().get_first_node_in_group("egg")
	
func _process(delta: float) -> void:
	look_at(egg.position)
	
func _physics_process(delta: float) -> void:
	var vec = Vector2(egg.position.x-position.x,egg.position.y-position.y)
	move_and_collide(vec.normalized()*SPEED)
