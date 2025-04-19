extends Node

func getJsonData() -> Array:
	var json = JSON.new()
	var fileAsString := FileAccess.get_file_as_string("res://assets/workouttest.json")
	print(fileAsString)
	var error = json.parse_string(fileAsString)
	var arrOfWorkouts: Array = error
	print(arrOfWorkouts[0])
	return arrOfWorkouts
