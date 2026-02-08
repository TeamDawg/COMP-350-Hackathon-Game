extends Area2D


func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		# Check if player has the key
		if body.has_key:
			print("You win! Level complete!")
			end_game()
		else:
			print("You need the key first!")

func end_game():
	# Option 1: Restart the level
	get_tree().reload_current_scene()
	
	
