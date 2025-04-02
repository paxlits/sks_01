extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$main_house/roof.show()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		$main_house/roof.hide()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		$main_house/roof.show()
