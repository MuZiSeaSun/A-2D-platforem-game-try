extends Object

class_name StateMachine

var current_state : State = null
var precious_state  = null

func _init(state : State):
	current_state = state
	if current_state != null:
		current_state._enter()

func _change_state(state : State):
	precious_state = current_state.get_name()
	if current_state != null:
		current_state._exit()
		current_state.call_deferred("free") # _deferred
	
	current_state = state
	
	if current_state != null:
		current_state._enter() 

func _update(delta):
	if current_state != null:
		current_state._execute(delta)

func _is_state(state : State) -> bool:
	if state == current_state:
		return true
	else :
		return false
