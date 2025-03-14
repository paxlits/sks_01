extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func kicked():
	$AnimatedSprite2D.play("kicked")
	$AudioStreamPlayer2D.play()
