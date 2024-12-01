extends Node2D

func _on_body_entered(body: Node2D) -> void:
	Globals.currentSpawnedItemCount -= 1
	Globals.HeldCount += 1
	queue_free()

func _process(delta: float) -> void:
	if (Globals.Started == false):
		queue_free()
