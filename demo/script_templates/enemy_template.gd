extends KinematicBody2D

# 运动相关常量
var velocity := Vector2.ZERO
const max_speed = 300.0
const jump_speed = -500
var catch_wall_speed = 0
const gravity = 2000
const acceleration = max_speed/0.2
const air_acceleration = max_speed/0.05
const max_jump_cont = 2
var jump_cont = 0
var is_wall_on_right = false

# 状态机
var state_machine : StateMachine

# 状态


# 子节点
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D

func _ready():
	state_machine = StateMachine.new(null)  # 实例化状态机 ## 实例化默认状态
	pass

func _physics_process(delta):
#	snap = Vector2(0,16) if state_machine.current_state.get_name()!="jump" else Vector2.ZERO
	velocity = move_and_slide(velocity,Vector2.UP)  # 移动 #_with_snap  ,snap

func _process(delta):
	# 重力
	velocity.y += gravity*delta
	
	state_machine._update(delta)



func _on_HurtBox_hurt():
	print("enemy_1 is hurt")
	pass # Replace with function body.
