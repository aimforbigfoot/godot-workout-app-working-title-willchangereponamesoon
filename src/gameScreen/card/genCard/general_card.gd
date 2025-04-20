extends Node2D

signal cardSwipped
signal userFailedSet
signal completedSet

const DISTTHATTRIGGERSCLICK := 160000.0
const DISTTOSHOWTHEMESSAGE := 230.0
@export var rotation_factor: float = 0.001   # radians per pixel of X‑drag
@export var return_speed: float   = 5.0      # how fast to lerp back (higher = snappier)

var cardBeingUsed := true
var follow_mouse := false
var returning := true
var start_position := Vector2.ZERO
var isDoneSet := false
var failedSet := false


func _ready() -> void:
	userFailedSet.connect(userDoneWithCard)
	completedSet.connect(userDoneWithCard)

func userDoneWithCard(didUserWin :bool) -> void:
	cardBeingUsed = false
	var t := create_tween()
	if didUserWin:
		t.tween_property(self, "global_position", Vector2(-2000, global_position.y + 100), 0.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	else:
		t.tween_property(self, "global_position", Vector2(2000, global_position.y + 100), 0.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	t.play()
	t.finished.connect(  getRidOfCard )

func getRidOfCard() -> void:
	cardSwipped.emit()
	queue_free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		var dist := global_position.distance_squared_to(get_global_mouse_position())
		if dist < DISTTHATTRIGGERSCLICK:
			follow_mouse = true
			returning = false
	elif event.is_action_released("click") and follow_mouse:
		follow_mouse = false
		returning  = true
	if event.is_action_pressed("R"):
		get_tree().reload_current_scene()



func _physics_process(delta: float) -> void:
	if cardBeingUsed:
		if follow_mouse:
			var mouse_pos = get_global_mouse_position()
			global_position = lerp(global_position, mouse_pos, 0.5)
			rotation = (mouse_pos.x - start_position.x) * rotation_factor

			var diffOfCardFromCenter := (start_position - global_position)
			var distFromStart :float = diffOfCardFromCenter.length_squared()

			if diffOfCardFromCenter.x > DISTTOSHOWTHEMESSAGE:
				$completedComp.visible = true
				isDoneSet = true
			else:
				$completedComp.visible = false
				isDoneSet = false
			if diffOfCardFromCenter.x < -DISTTOSHOWTHEMESSAGE:
				$failComp.visible = true
				failedSet = true
			else:
				$failComp.visible = false
				failedSet = false



		elif returning:
			# 1) Position lerp
			if not failedSet and not isDoneSet:
				global_position = lerp(global_position, start_position, return_speed * delta)
				# 2) Rotation lerp back to zero
				rotation = lerp(rotation, 0.0, return_speed * delta)
				# 3) Once “close enough,” snap and stop
				if global_position.distance_to(start_position) < 1.0 and abs(rotation) < 0.01:
					global_position = start_position
					rotation = 0.0
					returning = false
			if failedSet:
				failedSet = false
				userFailedSet.emit(false)
			if isDoneSet:
				isDoneSet = false
				completedSet.emit(true)

func setStartPos(p:Vector2) -> void:
	start_position = p
	global_position = Vector2(start_position.x, -100.0)

func useCardData(cardDeets : Dictionary) -> void:
	$exersizeComp/excersizeName.text = cardDeets.name
	pass
