extends Node2D

var world_rev = preload("res://world.tscn")


func _on_play_pressed() -> void:
	var world = world_rev.instantiate()
	get_tree().root.add_child(world)
	world.done.connect(_on_play_pressed)
	$CanvasLayer.visible =false
	
