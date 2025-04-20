extends Node2D

@onready var cardpos := $cardStartPos
var arrOfExcersizes := []
var totalCardsDone := 0
var timeTakenForSet :float = 0.0
var totalTimeOfWorkout :float= 0.0
var timeOfSet := 0.0
func _ready() -> void:
	spawnSwipeableCard()
	$BottomUI/HBoxContainer/VBoxContainer2/finishRun.pressed.connect(finishRun)

func finishRun() -> void:
	get_tree().change_scene_to_file("res://src/finishScreen/finish_screen.tscn")

func spawnSwipeableCard() -> void:
	totalCardsDone += 1
	timeOfSet = 0.0
	var c := preload("res://src/gameScreen/card/genCard/general_card.tscn").instantiate()
	add_child(c)
	c.setStartPos(cardpos.global_position)
	var e := ExcersizeGrabber.grabFilteredExcersize()
	print(e)
	var repCount := randi_range(e.reps.min, e.reps.max)
	var b := e.has("isSeconds")
	print(b)
	setRepCount(repCount, b  )
	c.useCardData(e )

	c.cardSwipped.connect(showNextCard)

func showNextCard() -> void:
	$TopUI/HBoxContainer/VBoxContainer2/HBoxContainer/totalCardCounts.text = str(totalCardsDone)

	spawnSwipeableCard()


func setRepCount(repsOrSeconds:int, isSeconds:bool)  -> void:
	$TopUI/HBoxContainer/VBoxContainer/HBoxContainer/numOfThing.text = str(repsOrSeconds)
	if isSeconds:
		$TopUI/HBoxContainer/VBoxContainer/HBoxContainer/repsOrSeconds.text = "Secs"
	else:
		$TopUI/HBoxContainer/VBoxContainer/HBoxContainer/repsOrSeconds.text = "Reps"



func _physics_process(delta: float) -> void:
	totalTimeOfWorkout += delta
	timeOfSet += delta

	if totalTimeOfWorkout < 999.0:
		$TopUI/HBoxContainer/VBoxContainer2/HBoxContainer2/totalTime.text = str(totalTimeOfWorkout).left(5).pad_decimals(2)
	else:
		$TopUI/HBoxContainer/VBoxContainer2/HBoxContainer2/totalTime.text = str(totalTimeOfWorkout).left(5).pad_decimals(0)

	$TopUI/HBoxContainer/VBoxContainer2/HBoxContainer3/timeOfSet.text = str(timeOfSet).pad_decimals(2)
