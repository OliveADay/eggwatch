extends Node2D

var knife_ref = preload("res://knife.tscn")
var x_bounds_outer = [-21.0,280.0]
var x_bounds_inner = [-14.0,271.0]
var y_bounds_outer = [-22.0,166.0]
var y_bounds_inner = [-14.0,158.0]

@export var INTERVAL_MAX = 5
var interval_current = 0

func _process(delta: float) -> void:
	if interval_current <= 0 :
		var knife = knife_ref.instantiate()
		get_tree().root.add_child(knife)
		knife.position = generate_position()
		interval_current = INTERVAL_MAX
	else:
		interval_current-=delta
	

func generate_position():
	var pos = Vector2(0,0)
	var i = randi_range(0,3)
	if i == 0:
		pos.x = randf_range(x_bounds_outer[0],x_bounds_inner[0])
		pos.y = randf_range(y_bounds_outer[0],y_bounds_outer[1])
	elif i == 1:
		pos.x = randf_range(x_bounds_inner[1],x_bounds_outer[1])
		pos.y = randf_range(y_bounds_outer[0],y_bounds_outer[1])
	elif i == 2:
		pos.x = randf_range(x_bounds_outer[0],x_bounds_outer[1])
		pos.y = randf_range(y_bounds_outer[0],y_bounds_inner[0])
	else:
		pos.x = randf_range(x_bounds_outer[0],x_bounds_outer[1])
		pos.y = randf_range(y_bounds_inner[1],y_bounds_outer[1])
