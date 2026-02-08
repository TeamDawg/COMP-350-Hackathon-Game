extends Node2D

@onready var hurt : bool = false
@onready var done : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hurt:
		$RubberHand.monitoring = false
		$RealHand.position.x += 8
	if done:
		done = false
		await get_tree().create_timer(0.7).timeout
		$RubberHand/MetalBar.play()

# Upon entering rubber hand.
func _on_rubber_hand_body_entered(body: Node2D) -> void:
	if body == $Player:
		$RubberHand/RubberSFX.play()
		$RubberHand/Ouch.play()
		hurt = true
		done = true
