extends Node2D

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	Globals.currentSpawnedItemCount -= 1
	Globals.HeldCount += 1
	queue_free()
