extends Area2D

@onready var animate_button: AnimatedSprite2D = $animateButton
@onready var player: CharacterBody2D = %player

var pressed : bool = false

func _on_body_entered(body: CharacterBody2D) -> void:
	if (body == player):
		if (pressed == false):
			animate_button.frame = 0
			pressed = true
	

func _on_body_exited(body: CharacterBody2D) -> void:
	if (body == player):
		if (pressed == true):
			animate_button.frame = 1
			pressed = false
