extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity_horizontal: bool = false
var coins_in_range: Array = []

func _ready() -> void:
	# Add to Player group first
	add_to_group("Player")
	print("Player added to 'Player' group")
	
	# Wait one frame for all nodes to be ready
	await get_tree().process_frame
	
	# Connect to coins in the scene
	var coins = get_tree().get_nodes_in_group("coins")
	print("Found ", coins.size(), " coins in 'coins' group")
	
	for coin in coins:
		print("Attempting to connect to coin: ", coin.name)
		if coin.has_signal("coin_collected"):
			coin.coin_collected.connect(_on_coin_collected)
			print("Successfully connected to coin: ", coin.name)
		else:
			print("ERROR: Coin ", coin.name, " doesn't have 'coin_collected' signal!")

func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if gravity_horizontal:
			velocity.x = JUMP_VELOCITY if velocity.x > 0 else -JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY
		$Jump.play()

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
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		if gravity_horizontal:
			velocity.x += get_gravity().x * delta
		else:
			velocity += get_gravity() * delta
	
	# Handle the movement/deceleration.
	if gravity_horizontal:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_coin_collected() -> void:
	print("!!!!! COIN COLLECTED SIGNAL RECEIVED !!!!!")
	print("Setting gravity_horizontal to TRUE")
	gravity_horizontal = true
	print("gravity_horizontal is now: ", gravity_horizontal)
