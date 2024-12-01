extends Node2D

@onready var confirm_quit_dialog = $ConfirmQuit
@onready var button_select_prompt = $"Center Button"
@onready var title_label = $"Center Button/Title"
@onready var gameover_prompt = $"Game_Over"
@onready var gameover_label = $"Game_Over/Results"
@onready var player = $"World/Player"


signal gameover

func _ready() -> void:
	gameover_prompt.visible = false
	button_select_prompt.visible = true

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
			gameover_prompt.visible = false
			title_label.visible = false

# key press, key held, key held for x time to close (or ESC, which will always be used to close)


func _on_gameover() -> void:
	gameover_label.text = "Key of choice: "+ OS.get_keycode_string(Globals.SelectedKey)+"\n"
	gameover_label.text += "On Hand: %.f" % Globals.HeldCount + "\n"
	gameover_label.text += "Stored: %.f" % Globals.StoredCount
	#show end screen
	gameover_prompt.visible = true
	button_select_prompt.visible = true
	
	#Reset stuffs
	Globals.SelectedKey = KEY_NONE
	Globals.ForwardRotationDirection = true
	Globals.DebugAngle = 0
	Globals.Started = false
	Globals.HeldCount = 0
	Globals.StoredCount = 0
	Globals.currentSpawnedItemCount = 0
	
	#Reset player position
	
	player.position = Vector2(640,448)
	player.rotation = 0
