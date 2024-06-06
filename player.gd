extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -180.0
@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canDouble = true;

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if !canDouble && is_on_floor():
		canDouble = true;
	if Input.is_action_just_pressed("jump") and canDouble:
		velocity.y = JUMP_VELOCITY
		if !is_on_floor():
			canDouble = false;

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	# Determine animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:	
		velocity.x = direction * SPEED
		# Make sure that our sprite is facing the right way
		if animated_sprite.flip_h != (direction == -1):
			animated_sprite.flip_h = (direction == -1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
