extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$house/roof.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		$house/roof.hide()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		$house/roof.show()
