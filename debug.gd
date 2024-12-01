extends Label

func _process(delta: float) -> void:
	get_node(".").text = str(Engine.get_frames_per_second()) + " FPS\n"
	get_node(".").text += ("%.2fms" % (delta * 1000)) + "\n"
	get_node(".").text += OS.get_keycode_string(Globals.SelectedKey) + " :Key\n"
	get_node(".").text += str(Globals.ForwardRotationDirection) + " :CW\n"
	get_node(".").text += "%.2f" % Globals.DebugAngle + " :Angle\n"
	get_node(".").text += "%.f" % Globals.HeldCount + " :Held\n"
	pass

