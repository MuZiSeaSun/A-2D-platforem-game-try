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
onready var idle = preload("res://player_states/idle.gd")  # 闲置
onready var walk = preload("res://player_states/walk.gd")  # 行走
onready var jump = preload("res://player_states/jump.gd")  # 跳跃
onready var fall = preload("res://player_states/fall.gd")  # 坠落
onready var catch_wall = preload("res://player_states/catch_wall.gd")  # 抓墙

# 子节点
onready var ray_cast_wall = $RayCastWall
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D
onready var coyote_timer = $coyoteTimer  # 跳跃能力保持
onready var jump_request_timer = $JumpRequestTimer  # 跳跃请求有效
onready var catch_wall_timer = $CatchWallTimer  # 抓墙持续时间
onready var catch_request_timer = $CatchRequestTimer  # 抓墙请求有效

func _ready():
	state_machine = StateMachine.new(idle.new(self))  # 实例化状态机 ## 实例化默认状态

	pass

func _physics_process(delta):
	var snap 
	velocity = move_and_slide_with_snap(velocity,snap,Vector2.UP)  # 移动

func _input(event):
	# 跳跃请求
	if event.is_action_pressed("jump"):
		jump_request_timer.start()
#	if event.is_action_released("jump")&&velocity.y<jump_speed/2&&jump_cont==1:
#		print("small jump")
#		velocity.y = 0
	
	# 抓墙请求
	if event.is_action_pressed("catch_wall"):
		catch_request_timer.start()
	if event.is_action_released("catch_wall"):
		catch_wall_timer.stop()
		

func _process(delta):
	# 重力
	velocity.y += gravity*delta
	
	if is_on_wall():
		is_wall_on_right = ray_cast_wall.get_collider() is TileMap
#		print(ray_cast_wall.get_collider())
#		print(is_wall_on_right)
		
	# 状态机更新
	state_machine._update(delta)

