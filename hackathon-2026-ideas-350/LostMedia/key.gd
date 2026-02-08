extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		# Tell the player they got the key
		body.has_key = true
		print("Key collected!")
		
		# Remove the key
		queue_free()
