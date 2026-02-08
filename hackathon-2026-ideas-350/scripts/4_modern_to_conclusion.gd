extends VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GlassBreak.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/conclusion.tscn")
