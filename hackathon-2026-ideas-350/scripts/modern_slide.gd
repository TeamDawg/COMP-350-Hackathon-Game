extends Node2D

@onready var beat_one : bool = false
@onready var beat_two : bool = false
@onready var beat_thr : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.JUMP_VELOCITY *= 1.85
	$BG1.visible = true
	$CorrectWord1.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Detect for correct words
func _on_correct_detectors_body_entered(body: Node2D) -> void:
	if body == $Player:
		$Player/Coin.play()
		if beat_two:
			beat_thr = true
		elif beat_one:
			beat_two = true
		else:
			beat_one = true
		if beat_thr:
			var tween = get_tree().create_tween()
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_1, "position:y", $CorrectWord3/CorrectWord3_1.position.y - 25, 0.25)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_1, "modulate:a", 1, 0.25)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_2, "position:y", $CorrectWord3/CorrectWord3_2.position.y - 25, 0.25)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_2, "modulate:a", 1, 0.25)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_3, "position:y", $CorrectWord3/CorrectWord3_3.position.y - 25, 0.25)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_3, "modulate:a", 1, 0.25)
			await get_tree().create_timer(0.5).timeout
			tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_1, "position:x", 907, 0.5)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_1, "position:y", 173, 0.5)
			await get_tree().create_timer(0.5).timeout
			tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_2, "position:x", 920, 0.5)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_2, "position:y", 202, 0.5)
			await get_tree().create_timer(0.5).timeout
			tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_3, "position:x", 900, 0.5)
			tween.parallel().tween_property($CorrectWord3/CorrectWord3_3, "position:y", 230, 0.5)
			await get_tree().create_timer(0.5).timeout
			$CorrectDetectors/Correct3.disabled = true
			$WrongDetectors/Wrong3_1.disabled = true
			$WrongDetectors/Wrong3_2.disabled = true
			get_tree().change_scene_to_file("res://scenes/conclusion.tscn")
		elif beat_two:
			var tween = get_tree().create_tween()
			tween.parallel().tween_property($CorrectWord2, "position:y", $CorrectWord2.position.y - 25, 0.25)
			tween.parallel().tween_property($CorrectWord2, "modulate:a", 1, 0.25)
			tween.parallel().tween_property($Gun/WordL, "position:y", $Gun/WordL.position.y + 150, 0.25)
			tween.parallel().tween_property($Gun/WordL, "modulate:a", 1, 0.25)
			tween.parallel().tween_property($Gun/WordL, "scale", Vector2(2,2), 0.25)
			await get_tree().create_timer(0.5).timeout
			tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.parallel().tween_property($CorrectWord2, "position:x", 505, 0.5)
			tween.parallel().tween_property($CorrectWord2, "position:y", 182, 0.5)
			await get_tree().create_timer(0.5).timeout
			tween = get_tree().create_tween()
			tween.parallel().tween_property($BG2, "modulate:a", 0, 0.25)
			$Boundaries/Text2.disabled = true
			$Boundaries/Text3.disabled = false
			$CorrectDetectors/Correct2.disabled = true
			$CorrectDetectors/Correct3.disabled = false
			$WrongDetectors/Wrong2.disabled = true
			$WrongDetectors/Wrong3_1.disabled = false
			$WrongDetectors/Wrong3_2.disabled = false
			$CorrectWord3.visible = true
			$Gun.monitoring = true
		elif beat_one:
			var tween = get_tree().create_tween()
			tween.parallel().tween_property($CorrectWord1, "position:y", $CorrectWord1.position.y - 25, 0.25)
			tween.parallel().tween_property($CorrectWord1, "modulate:a", 1, 0.25)
			await get_tree().create_timer(0.5).timeout
			tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.parallel().tween_property($CorrectWord1, "position:x", 114, 0.5)
			tween.parallel().tween_property($CorrectWord1, "position:y", 207, 0.5)
			await get_tree().create_timer(0.5).timeout
			tween = get_tree().create_tween()
			tween.parallel().tween_property($BG1, "modulate:a", 0, 0.25)
			$Boundaries/Text1.disabled = true
			$Boundaries/Text2.disabled = false
			$CorrectDetectors/Correct1.disabled = true
			$CorrectDetectors/Correct2.disabled = false
			$WrongDetectors/Wrong1.disabled = true
			$WrongDetectors/Wrong2.disabled = false
			$CorrectWord2.visible = true
			$Gun/WordL.visible = true

#Detect for wrong words
func _on_wrong_detectors_body_entered(body: Node2D) -> void:
	if body == $Player:
		$Player/Hurt.play()

#Enter the gun
func _on_gun_body_entered(body: Node2D) -> void:
	if body == $Player:
		$Gun/GunBlast.visible = true
		$Gun/GunShot.play()
		await get_tree().create_timer(1.0).timeout
		var tween = get_tree().create_tween()
		tween.parallel().tween_property($Gun/WordL, "modulate:a", 0, 0.25)
		tween.parallel().tween_property($Gun/GunBlast, "modulate:a", 0, 0.25)
		await get_tree().create_timer(0.25).timeout
		$Gun.monitoring = false
		$Gun.visible = false
	
