extends AnimatedSprite2D

# If holding more than 5, hint towards collecting them
func _process(delta: float) -> void:
	self.visible = (Globals.HeldCount > 5)
	self.speed_scale = 1
	self.play()

func _on_collection_area_body_entered(body: Node2D) -> void:
	var held = Globals.HeldCount
	Globals.StoredCount += Globals.HeldCount
	var current_hp = $"../../../UI/UI_Bars".value;
	var bonus = 0
	if(held > 5):
		bonus = 10
	var new_hp = current_hp + (held * 10) + bonus
	$"../../../UI/UI_Bars".emit_signal("update_health", new_hp)
	Globals.HeldCount = 0
