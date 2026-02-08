extends Area2D

@export var speed = 300.0
@export var move_down = true

func _ready():
	# Connect collision signal
	body_entered.connect(_on_body_entered)

func _process(delta):
	# Move vertically
	if move_down:
		position.y += speed * delta
	else:
		position.y -= speed * delta
	
	# Remove when off-screen
	if position.y > 700 or position.y < -100:
		queue_free()

func _on_body_entered(body):
	if body is CharacterBody2D:  
		print("Player hit obstacle!")
		get_tree().reload_current_scene()
