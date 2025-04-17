extends Node2D

# —— configurable parameters —— #
@export var rotation_factor: float = 0.001   # radians per pixel of X‑drag
@export var return_speed: float   = 5.0      # how fast to lerp back (higher = snappier)

# —— internal state —— #
var follow_mouse := false
var returning    := false
var start_position := Vector2.ZERO

func _ready() -> void:
	start_position = global_position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		follow_mouse = true
		returning    = false
	elif event.is_action_released("click") and follow_mouse:
		follow_mouse = false
		returning    = true

func _physics_process(delta: float) -> void:
	if follow_mouse:
		var mouse_pos = get_global_mouse_position()
		global_position = mouse_pos
		rotation = (mouse_pos.x - start_position.x) * rotation_factor
	elif returning:
		# 1) Position lerp
		global_position = lerp(global_position, start_position, return_speed * delta)
		# 2) Rotation lerp back to zero
		rotation = lerp(rotation, 0.0, return_speed * delta)
		# 3) Once “close enough,” snap and stop
		if global_position.distance_to(start_position) < 1.0 and abs(rotation) < 0.01:
			global_position = start_position
			rotation = 0.0
			returning = false
