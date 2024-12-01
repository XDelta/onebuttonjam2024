extends CenterContainer

signal update_health(amount)
signal reset

@export var value: float = 100.0

func _ready() -> void:
	self.update_health.connect(_on_update_health)
	self.reset.connect(_on_reset)
	#timer for passive drain
	var UI_timer = Timer.new()
	UI_timer.wait_time = 5
	UI_timer.autostart = true
	add_child(UI_timer)
	UI_timer.timeout.connect(_on_uitimer_interval)

func _on_reset() -> void:
	value = 100
	$HungerOver.value = value
	$HungerUnder.value = value

func _on_update_health(_value: float) -> void:
	value = _value
	var tween = create_tween()
	tween.tween_property($HungerOver, "value", value, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($HungerUnder, "value", value, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _process(delta: float) -> void:
	if(value < 1):
		emit_signal("reset")
		$"../..".emit_signal("gameover")

func _on_uitimer_interval():
	if (Globals.Started == false):
		return
	emit_signal("update_health", value - 10.0)
