extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_CHARGE = 0.6
const MAX_SPEED = 800.0
const VECTOR_LENGTH = 50.0
const VECTOR_ROTATION_SPEED = 4.0
const MOVE_DURATION = 0.5

var time_held = 0.0
var is_charging = false
var direction = Vector2.ZERO
var line_angle = 0.0
var move_timer = 0.0

func _physics_process(delta: float) -> void:
	if Globals.Started == false:
		return
	
	# Charging
	if Input.is_key_pressed(Globals.SelectedKey):
		if not is_charging:
			move_timer = 0.0
			velocity = Vector2.ZERO
			is_charging = true
			time_held = 0.0
		else:
			time_held = min(time_held + delta, MAX_CHARGE)
	
	# Key Released
	if not Input.is_key_pressed(Globals.SelectedKey) and is_charging == true:
		is_charging = false
		Globals.ForwardRotationDirection = !Globals.ForwardRotationDirection
		var speed = lerp(SPEED, MAX_SPEED, time_held / MAX_CHARGE)
		velocity = Vector2(1, 0).rotated(line_angle) * speed
		move_timer = MOVE_DURATION
	
	# Apply velocity and move
	if move_timer > 0:
		$PlayerParticles.emitting = true
		move_timer -= delta
		if move_timer <= 0:
			$PlayerParticles.emitting = false
			velocity = Vector2.ZERO  # Stop movement when timer expires

	move_and_slide()
	Globals.DebugAngle = fmod(rad_to_deg(line_angle),360)
	
func _process(delta: float) -> void:
	if not is_charging and velocity.length() == 0:
		line_angle += VECTOR_ROTATION_SPEED * delta * (1 if Globals.ForwardRotationDirection else -1)

	queue_redraw() #hm, shouldn't be needed but forcing redraw.
	
var vertices = PackedVector2Array([Vector2(50.0, 0), Vector2(-10, -17.32), Vector2(-10, 17.32)])
var vertices_translated = PackedVector2Array([Vector2(50.0, 0), Vector2(-10, -17.32), Vector2(-10, 17.32)])

func _draw() -> void:
	if is_charging:
		vertices[0].x = lerp(20, 50, time_held / MAX_CHARGE)
	else:
		if vertices[0].x > 20:
			vertices[0].x -= get_process_delta_time() * 20
	for i in range(vertices.size()):
		vertices_translated[i] = vertices[i].rotated(deg_to_rad(fmod(rad_to_deg(line_angle),360)))
		 
	draw_polygon(vertices_translated,[Color.GREEN])
	var line_end = Vector2(VECTOR_LENGTH, 0).rotated(line_angle)
	draw_line(Vector2.ZERO, line_end, Color.AQUA, 1.0,true)
	var charge = lerp(20, 40, time_held / MAX_CHARGE)
