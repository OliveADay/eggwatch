extends Area2D

@export var COOLDOWN_MAX = 0.5
var cooldown_current = 0
var released = true
var first = false
var coin_ref = preload("res://coin.tscn")
signal coined(amount)

func _process(delta: float) -> void:
	position = get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and cooldown_current <= 0:
		$Sprite2D.rotation = 30
		if has_overlapping_bodies() and not first:
			spawn_coins()
			get_overlapping_bodies()[0].queue_free()
			first = true
		released = true
	else:
		first = false
		if not released:
			cooldown_current=COOLDOWN_MAX
		$Sprite2D.rotation = 0
		cooldown_current-=delta
		released = true
func spawn_coins():
	var total = 0
	print("exit")
	for i in range(0,randi_range(1,2)):
		var coin = coin_ref.instantiate()
		get_tree().root.add_child(coin)
		coin.position = position
		total+=1
	coined.emit(total)
