extends TextureRect

@onready var disappearing_step: TextureRect = $disappearingStep
@onready var button: Area2D = $button
@onready var player: CharacterBody2D = %player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (button.pressed == false):
		disappearing_step.visible = false
	else:
		button.pressed = true
		disappearing_step.visible = true
	
func _on_door_body_entered(body: Node2D) -> void:
	if body == $player:
		get_tree().change_scene_to_file("res://scenes/transitions/1_OpticalToTactile.tscn")
