extends Node2D

@onready var cardpos := $cardStartPos
var arrOfExcersizes := []

func _ready() -> void:
	arrOfExcersizes = ExcersizeGrabber.getJsonData()
	spawnSwipeableCard()
	
func spawnSwipeableCard() -> void:
	var c := preload("res://src/gameScreen/card/genCard/general_card.tscn").instantiate()
	add_child(c)
	c.setStartPos(cardpos.global_position)
	c.useCardData(arrOfExcersizes[0])
	pass
