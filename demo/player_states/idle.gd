extends State

var animation_player :AnimationPlayer
var sprite :Sprite
var jump_request_timer :Timer

var gravity 

func _init(o).(o):
	owner = o
	animation_player = owner.animation_player
	sprite = owner.sprite
	jump_request_timer = owner.jump_request_timer
	
	pass

func _enter():
	animation_player.play("idle")
	owner.jump_cont = 0
	pass

func _execute(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
#	owner.sprite.flip_h = direction>=0
	
	if direction!=0 or owner.velocity.x!=0:
		owner.state_machine._change_state(owner.walk.new(owner))
	
	var can_jump = true
	if can_jump&&owner.jump_request_timer.time_left>0:
		owner.state_machine._change_state(owner.jump.new(owner))
	
	if !owner.is_on_floor():
		owner.state_machine._change_state(owner.fall.new(owner))
		
	pass

func _exit():
	pass

func get_name():
	return "idle"
