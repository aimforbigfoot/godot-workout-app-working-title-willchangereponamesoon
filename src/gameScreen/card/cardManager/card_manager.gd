extends Node2D


func _ready() -> void:
	spawnSwipeableCard()

func spawnSwipeableCard() -> void:
	var c := preload("res://src/gameScreen/card/genCard/general_card.tscn").instantiate()
	add_child(c)
	pass
