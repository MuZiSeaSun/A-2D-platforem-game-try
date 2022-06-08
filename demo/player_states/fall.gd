extends State


var precious_state 

var can_catch = false

func _init(o).(o):
	owner = o

	pass

func _enter():
	precious_state = owner.state_machine.precious_state
	if precious_state== "walk" or precious_state== "idle" or precious_state== "catch_wall": # "walk" or "idle" or "catch_wall"
		print(precious_state)
		print("coyote time start")
		owner.coyote_timer.start()
	
	if precious_state== "walk" :  # or precious_state== "jump"
		can_catch = true
	
	if precious_state== "jump" and not owner.is_on_wall():
		can_catch = true
	owner.animation_player.play("fall")
	pass

func _execute(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var acc = owner.air_acceleration
	owner.velocity.x = move_toward(owner.velocity.x, direction*owner.max_speed, acc*delta)
	print(owner.velocity.x)
	owner.sprite.flip_h = owner.velocity.x>0
	
	var can_jump = owner.coyote_timer.time_left>0||owner.jump_cont<owner.max_jump_cont
	if can_jump and owner.jump_request_timer.time_left>0:
		print("jumpp")
		owner.state_machine._change_state(owner.jump.new(owner))
	
	if owner.is_on_floor():
		owner.state_machine._change_state(owner.idle.new(owner))
	
	can_catch = owner.is_on_wall()
	if can_catch&&owner.catch_request_timer.time_left>0:
		owner.state_machine._change_state(owner.catch_wall.new(owner))
	pass

func _exit():
	owner.coyote_timer.stop()
	pass

func get_name():
	return "fall"
