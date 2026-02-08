extends CharacterBody2D

var SPEED = 130.0
var JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D 


func reverse_gravity(boolean: bool):
	animated_sprite.flip_v = boolean 
	if boolean:
		up_direction = Vector2.DOWN
		collision_shape.position = Vector2(0, 0) 
	else:
		up_direction = Vector2.UP
		collision_shape.position = Vector2(0, 0) 

	

func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Jump.play()
	
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		if not $Walking.playing:
			$Walking.play()
		else:
			$Walking.stop()

	# Get the input direction (-1, 0, 1)
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations & add the gravity.
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		
		elif Input.is_action_pressed("shift"):
			animated_sprite.play("run")
			
		else:
			animated_sprite.play("walk")
				
	else:
		animated_sprite.play("jump")
		velocity += get_gravity() * delta
	
	# Handle the movement/deceleration.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
