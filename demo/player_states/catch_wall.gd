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
	catch_wall_timer = owner.catch_wall_timer

	pass

func _enter():
	animation_player.play("catch_wall")
	print("catch")
#	owner.jump_cont = 0
	catch_wall_timer.start()
	owner.catch_request_timer.stop()
	pass

func _execute(delta):
	var acc = owner.acceleration
	owner.velocity.y = move_toward(owner.velocity.y, owner.catch_wall_speed, acc)
	owner.sprite.flip_h = owner.is_wall_on_right
	
	
	var can_jump = true
	if can_jump&&owner.jump_request_timer.time_left>0:
		owner.state_machine._change_state(owner.jump.new(owner))
	
	if !catch_wall_timer.time_left>0||!owner.is_on_wall():
		if !catch_wall_timer.time_left>0:
			print("time out")
		if !owner.is_on_wall():
			print("is not on wall")
		owner.state_machine._change_state(owner.fall.new(owner))
	
	
	pass

func _exit():
	owner.jump_cont = 0
	pass

func get_name():
	return "catch_wall"
