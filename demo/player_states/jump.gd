extends State

var precious_state

var can_catch = true

func _init(o).(o):
	owner = o

	pass

func _enter():
	precious_state = owner.state_machine.precious_state
	owner.animation_player.play("jump")
	owner.velocity.y += owner.jump_speed
	owner.jump_request_timer.stop()
	owner.jump_cont+=1
	print(owner.jump_cont)
	
	
	if precious_state=="catch_wall":
		can_catch = false
	pass

func _execute(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var acc = owner.air_acceleration
	owner.velocity.x = move_toward(owner.velocity.x, direction*owner.max_speed, acc)
	owner.sprite.flip_h = owner.velocity.x>0
	
	
	var can_jump = owner.jump_cont < owner.max_jump_cont
	if can_jump and owner.jump_request_timer.time_left>0:
		print("jump2")
		owner.state_machine._change_state(owner.jump.new(owner))
	
	if owner.velocity.y>=0:
		owner.state_machine._change_state(owner.fall.new(owner))
	
	if owner.is_on_floor():
		owner.state_machine._change_state(owner.idle.new(owner))
	
	can_catch = owner.is_on_wall() and can_catch
	if can_catch and owner.catch_request_timer.time_left>0:
		owner.state_machine._change_state(owner.catch_wall.new(owner))
	pass

func _exit():
	pass

func get_name():
	return "jump"
