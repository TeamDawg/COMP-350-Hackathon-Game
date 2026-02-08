extends Node2D

const object1 = preload("res://scenes/obstacle1.tscn")

@export var obstacle_scene: PackedScene  
@export var spawn_timer = 2.0

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = spawn_timer
	timer.timeout.connect(_spawn_obstacle)
	timer.start()

func _spawn_obstacle():
	var obstacle = object1.instantiate()
	
	add_child(obstacle)
	obstacle.position = Vector2(randi_range(50, 600), -50)
