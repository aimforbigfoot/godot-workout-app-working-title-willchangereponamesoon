extends Control


func _ready() -> void:
	$VBoxContainer/HBoxContainer2/tryAgain.pressed.connect(btnPress)

func btnPress() -> void:
	get_tree().change_scene_to_file("res://src/exserizeSetupScreen/exersize_setup_screen.tscn")
	pass
