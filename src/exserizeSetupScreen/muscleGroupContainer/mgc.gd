extends HBoxContainer

var muscleGroupName := ""

func _ready() -> void:
	$isPartOfFilter.toggled.connect(addOrRemoveFromMainFilter)

func addOrRemoveFromMainFilter(isToBeAdded:bool) -> void:
	if isToBeAdded:
		ExcersizeGrabber.muscleGroupFilter.append(muscleGroupName)
	else:
		var indOfThingIWant := ExcersizeGrabber.muscleGroupFilter.find(muscleGroupName)
		ExcersizeGrabber.muscleGroupFilter.remove_at( indOfThingIWant )
	print(ExcersizeGrabber.muscleGroupFilter)
func setName(_muscleGroupName:String) -> void:
	$muscleGroupText.text = _muscleGroupName
	muscleGroupName = _muscleGroupName
