extends RigidBody2D
@export var SPEED = 2
var egg:Node2D
var coin_ref = preload("res://coin.tscn")
signal coined(amount)


func _ready() -> void:
	egg = get_tree().get_first_node_in_group("egg")
	coined.connect(spawn_coins)
	
func _process(delta: float) -> void:
	if egg == null:
		egg = get_tree().get_first_node_in_group("egg")	
	look_at(egg.position)
	
func _physics_process(delta: float) -> void:
	var vec = Vector2(egg.position.x-position.x,egg.position.y-position.y)
	move_and_collide(vec.normalized()*SPEED)
	
func spawn_coins():
	var total = 0
	print("exit")
	for i in range(0,randi_range(1,2)):
		var coin = coin_ref.instantiate()
		get_tree().root.add_child(coin)
		coin.position = position
		total+=1
	coined.emit(total)
	
	
