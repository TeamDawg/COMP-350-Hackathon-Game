extends TextureRect

signal coin_collected

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	# Add to coins group FIRST
	add_to_group("coins")
	print("Coin '", name, "' added to 'coins' group")
	print("Coin has signal 'coin_collected': ", has_signal("coin_collected"))


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("===== COIN COLLISION =====")
	print("Body name: ", body.name)
	print("Body groups: ", body.get_groups())
	print("Is in 'Player' group: ", body.is_in_group('Player'))
	
	if body.is_in_group('Player'):
		print("***** EMITTING coin_collected SIGNAL *****")
		coin_collected.emit()
		print("Signal emitted, destroying coin...")
		queue_free()
	else:
		print("Body is NOT in Player group, ignoring...")
