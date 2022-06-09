extends State

var animation_player :AnimationPlayer
var sprite :Sprite


func _init(o).(o):
	owner = o
	animation_player = owner.animation_player
	sprite = owner.sprite

	pass

func _enter():
	pass

func _execute(delta):
	pass

func _exit():
	pass

func get_name():
	return "unknow state"
