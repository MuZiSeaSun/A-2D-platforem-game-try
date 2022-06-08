extends State

var animation_player :AnimationPlayer
var sprite :Sprite
var coyote_timer :Timer
var jump_request_timer :Timer
var catch_wall_timer :Timer
var catch_request_timer :Timer


func _init(o).(o):
	owner = o
	animation_player = owner.animation_player
	sprite = owner.sprite
	coyote_timer = owner.coyote_timer
	jump_request_timer = owner.jump_request_timer
	catch_wall_timer = owner.catch_wall_timer
	catch_request_timer = owner.catch_request_timer

	pass

func _enter():
	pass

func _execute(delta):
	pass

func _exit():
	pass

func get_name():
	return "unknow state"
