extends Node2D

#X-position of the mouth video
const video_vah_positionX : float = 507.0
const video_dah_positionX : float = -159.0
const video_bah_positionX : float = -825.0

#Archive the player's original jump velocity
@onready var original_jump_velocity : float = $Player.JUMP_VELOCITY

#An array of the words.
@onready var correct_order = ["vah", "dah", "bah", "vah", "dah", "bah", "vah", "dah", "bah"]
@onready var is_vah = false
@onready var is_dah = false
@onready var is_bah = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.JUMP_VELOCITY *= 1.85
	correct_order.shuffle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !correct_order.is_empty():
		match correct_order.front():
			"vah":
				$VideoStreamPlayer.position.x = video_vah_positionX
				is_vah = true
				is_dah = false
				is_bah = false
			"dah":
				$VideoStreamPlayer.position.x = video_dah_positionX
				is_vah = false
				is_dah = true
				is_bah = false
			"bah":
				$VideoStreamPlayer.position.x = video_bah_positionX
				is_vah = false
				is_dah = false
				is_bah = true

func _on_checkers_vah_body_entered(body: Node2D) -> void:
	if body == $Player:
		if is_vah:
			#$PlayPause.button_pressed = false
			correct_order.pop_at(0)
		else:
			death()

func _on_checkers_dah_body_entered(body: Node2D) -> void:
	if body == $Player:
		if is_dah:
			#$PlayPause.button_pressed = false
			correct_order.pop_at(0)
		else:
			death()

func _on_checkers_bah_body_entered(body: Node2D) -> void:
	if body == $Player:
		if is_bah:
			#$PlayPause.button_pressed = false
			correct_order.pop_at(0)
		else:
			death()

func death() -> void:
	$Player.JUMP_VELOCITY = original_jump_velocity
	$Player/Explosion.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene.call_deferred()

func _on_exit_body_entered(body: Node2D) -> void:
	if body == $Player:
		$Player.visible = false

func _on_play_pause_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$VideoStreamPlayer.paused = false
		$AudioStreamPlayer2D.playing = true
	else:
		$VideoStreamPlayer.paused = true
		$AudioStreamPlayer2D.playing = false
