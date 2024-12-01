extends CenterContainer

signal update_health(amount)
signal reset

@export var value: float = 100.0

func _ready() -> void:
	self.update_health.connect(_on_update_health)
	self.reset.connect(_on_reset)

func _on_reset() -> void:
	value = 100
	$HungerOver.value = value
	$HungerUnder.value = value

func _on_update_health(_value: float) -> void:
	print("hp updated")
	print(_value)
	value = _value
	var tween = create_tween()
	tween.tween_property($HungerOver, "value", value, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($HungerUnder, "value", value, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
