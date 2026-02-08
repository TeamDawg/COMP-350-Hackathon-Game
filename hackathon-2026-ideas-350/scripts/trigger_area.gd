extends Area2D
@onready var player: CharacterBody2D = %player
@onready var label: Label = $Label

func _on_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		label.visible = true
		
