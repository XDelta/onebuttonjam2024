extends Node

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 2
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_on_timer_interval)

func _on_timer_interval():
	randomize()
	if (Globals.Started == false):
		return
	
	var item = preload("res://items/collectableItem.tscn")
	if (Globals.currentSpawnedItemCount < Globals.maxSpawnedItemCount):
		var window = get_viewport().size #DisplayServer.screen_get_size()
		var newitem = item.instantiate()
		newitem.position.x = randf_range(5, window.x - 5)
		newitem.position.y = randf_range(5, window.y - 5)
		add_child(newitem)
		Globals.currentSpawnedItemCount += 1
