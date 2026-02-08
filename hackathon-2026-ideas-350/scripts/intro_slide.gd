extends TextureRect

func _ready() -> void:
	Music.play()

func _input(event):
	if event is InputEventKey and event.pressed:
		get_tree().change_scene_to_file("res://scenes/optic_slide.tscn")
		print("hi")
