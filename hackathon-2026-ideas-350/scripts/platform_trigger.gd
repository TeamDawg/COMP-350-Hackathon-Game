extends Area2D
@onready var player: CharacterBody2D = %player

func _on_body_entered(body: CharacterBody2D) -> void:
	if body == player:
		$AnimationPlayer.play("Why...")
		
