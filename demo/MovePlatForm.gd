extends Node2D

onready var platform:=$Platform
onready var target := $Path2D/PathFollow2D

var max_speed = 60
var velocity :Vector2

#func _physics_process(delta):
#	var direction = (target.position-platform.position).normalized()
#	velocity.y = move_toward(velocity.y,max_speed*direction.y,120*delta)
#	platform.position.y += velocity.y*delta
