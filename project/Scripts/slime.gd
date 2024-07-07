extends Node2D

const speed = 30
var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down_right = $RayCastDownRight
@onready var ray_cast_down_left = $RayCastDownLeft
@onready var animated_sprite = $AnimatedSprite2D


func _process(delta):
	if direction > 0:
		if ray_cast_right.is_colliding() || !ray_cast_down_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
	if direction < 0:
		if ray_cast_left.is_colliding() || !ray_cast_down_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = false

	position.x += speed * delta * direction
