extends Node

var allExcersizes :Array= []
var muscleGroupFilter := []
var filesToUse := [
	"res://assets/lowerbody.json",
	"res://assets/workouttest.json"
]

func _ready() -> void:
	getJsonData()

func getJsonData() -> void:
	allExcersizes  = []
	var json = JSON.new()
	for file in filesToUse:
		var fileAsString := FileAccess.get_file_as_string(file)
		var error = json.parse_string(fileAsString)
		allExcersizes.append_array(error)

func getArrayOfMuscleGroups() -> Array:
	var a := []

	for excersize in allExcersizes:
		for group in excersize["muscle_groups"]:
			if not a.has(group):
				a.append( group )
	print(a)
	return a

func grabFilteredExcersize() -> Dictionary:
	var d : Dictionary
	var subsetted := []

	for exersize in allExcersizes:
		for muscleGroup in muscleGroupFilter:
			if exersize["muscle_groups"].has(muscleGroup):
				subsetted.append(exersize)
	if subsetted == []:
			return grabRandomExcersize()
	return subsetted.pick_random()

func grabRandomExcersize() -> Dictionary:
	return allExcersizes.pick_random()
