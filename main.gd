extends Node2D

@onready var confirm_quit_dialog = $ConfirmQuit
@onready var button_select_prompt = $"Center Button"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	#Close if ESC is pressed
	if Input.is_key_pressed(KEY_ESCAPE):
			confirm_quit_dialog.popup_centered()

func _on_ConfirmQuitDialog_confirmed() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		#Set first key pressed as the SelectedKey, only if it is not the escape key
		if event.keycode != KEY_ESCAPE && Globals.Started == false:
			Globals.Started = true
			Globals.SelectedKey = event.keycode
			button_select_prompt.visible = false


# key press, key held, key held for x time to close (or ESC, which will always be used to close)
