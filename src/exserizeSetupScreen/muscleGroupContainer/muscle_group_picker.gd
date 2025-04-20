extends VBoxContainer


func _ready() -> void:
	$startWorkout.pressed.connect(startWorkout)
	for group in ExcersizeGrabber.getArrayOfMuscleGroups():
		var mgc := preload("res://src/exserizeSetupScreen/muscleGroupContainer/mgc.tscn").instantiate()
		$ScrollContainer/VBoxContainer.add_child(mgc)
		mgc.setName(group)


func startWorkout() -> void:
	get_tree().change_scene_to_file("res://src/gameScreen/game_screen.tscn")
