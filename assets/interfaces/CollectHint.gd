extends AnimatedSprite2D

# If holding more than 5, hint towards collecting them
func _process(delta: float) -> void:
	self.visible = (Globals.HeldCount > 5)
	self.speed_scale = 1
	self.play()
