extends Node2D

var world_rev = preload("res://world.tscn")
var scoreFilePath=  "user://score.cfg"
var best_score = 0
func load_best_score():
	var config = ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error!=OK:
		best_score = 0
		return
	best_score = config.get_value("main","best_score")
	
func _ready() -> void:
	load_best_score()
	$CanvasLayer/score.text = "best score:"+str(best_score)


func _on_play_pressed() -> void:
	$AudioStreamPlayer2D.play()
	var world = world_rev.instantiate()
	get_tree().root.add_child(world)
	world.done.connect(_on_play_pressed)
	$CanvasLayer.visible =false
	
