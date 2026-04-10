extends Node2D

var knife_ref = preload("res://knife.tscn")
var egg_shell_ref = preload("res://egg shell.tscn")
var bomb_ref = preload("res://bomb.tscn")
var x_bounds_outer = [-21.0,280.0]
var x_bounds_inner = [-14.0,271.0]
var y_bounds_outer = [-22.0,166.0]
var y_bounds_inner = [-14.0,158.0]
var egg:Node2D
var egged = false
signal done
var knifes = []
var coins = 0
var score = 0
var explosions = []
var coin_press= false
var scoreFilePath=  "user://score.cfg"
var best_score = 0
var to_be_erazed = []

@export var INTERVAL_MAX = 5
var interval_current = 0
var spawning = true

func _ready() -> void:
	egg = get_tree().get_first_node_in_group("egg")
	load_best_score()

func _process(delta: float) -> void:
	if egg==null:
		egg = get_tree().get_first_node_in_group("egg")
	if interval_current <= 0 and spawning:
		var knife = knife_ref.instantiate()
		knifes.append(knife)
		get_tree().root.add_child(knife)
		knife.position = generate_position()
		knife.coined.connect(_on_hammer_coined)
		interval_current = INTERVAL_MAX
		if INTERVAL_MAX > 0.5:
			INTERVAL_MAX*=0.95
	else:
		interval_current-=delta
	if Input.is_action_just_pressed("mouse2") and coins >= 3:
		var bomb = bomb_ref.instantiate()
		explosions.append(bomb)
		get_tree().root.add_child(bomb)
		bomb.position = get_global_mouse_position()
		coins-=3
	$CanvasLayer2/gold.text = "gold: "+str(coins)
	$CanvasLayer2/score.text = "score: "+str(score)
	
	

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
	return pos


func _on_egg_body_entered(body: Node2D) -> void:
	if egged:
		return
	var egg_shell = egg_shell_ref.instantiate()
	get_tree().root.add_child(egg_shell)
	egg_shell.position = egg.position
	spawning = false
	egg.visible = false
	egg.monitoring = false
	egged = true
	


func _on_egg_out_body_entered(body: Node2D) -> void:
	$CanvasLayer.visible = true
	body.get_parent().queue_free()


func _on_restart_pressed() -> void:
	done.emit()
	reset()
	for child in get_children():
		child.queue_free()
	queue_free()
func reset():
	if best_score < score:
		save_best_score()
	for knife in knifes:
		if knife == null:
			knifes.erase(knife)
	for knife in knifes:
		if knife != null:
			knife.queue_free()
	for explosion in explosions:
		if !is_instance_valid(explosion):
			explosions.erase(explosion)
	for explosion in explosions:
		explosion.queue_free()


func _on_back_mm_pressed() -> void:
	$CanvasLayer.visible = false
	reset()
	for child in get_children():
		child.queue_free()
	queue_free()
	get_tree().reload_current_scene()


func _on_hammer_coined(amount: Variant) -> void:
	coins+=amount
	score+=1
	
	
func load_best_score():
	var config = ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error!=OK:
		best_score = 0
		return
	best_score = config.get_value("main","best_score")
	
func save_best_score():
	var config = ConfigFile.new()
	best_score = score
	config.set_value("main","best_score",best_score)
	config.save(scoreFilePath)
