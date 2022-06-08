extends Object
class_name State

var owner = null

func _init(o):
	owner = o
	pass

func _enter():
	pass

func _execute(delta):
	pass

func _exit():
	pass

func get_name():
	return "unknow_state"
