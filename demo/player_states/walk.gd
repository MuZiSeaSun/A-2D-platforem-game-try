extends State

var animation_player :AnimationPlayer
var sprite :Sprite
var coyote_timer :Timer
var jump_request_timer :Timer
var catch_wall_timer :Timer
var catch_request_timer :Timer
var state_machine :StateMachine


func _init(o).(o):
	owner = o
	
	animation_player = owner.animation_player
	sprite = owner.sprite
	coyote_timer = owner.coyote_timer
	jump_request_timer = owner.jump_request_timer
	catch_wall_timer = owner.catch_wall_timer
	catch_request_timer = owner.catch_request_timer
	state_machine = owner.state_machine
	
	pass

func _enter():
	animation_player.play("walk")
	pass

func _execute(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var acc = owner.acceleration
	owner.velocity.x = move_toward(owner.velocity.x, direction*owner.max_speed, acc*delta)
	owner.sprite.flip_h = owner.velocity.x>0
	
	if owner.velocity.x==0:
		owner.state_machine._change_state(owner.idle.new(owner))
	
	var can_jump = true
	if can_jump&&owner.jump_request_timer.time_left>0:
		owner.state_machine._change_state(owner.jump.new(owner))
	
	if !owner.is_on_floor():
		owner.state_machine._change_state(owner.fall.new(owner))
	pass

func _exit():
	pass

func get_name():
	return "walk"
