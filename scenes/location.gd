extends Area2D

@export var location_name: String = "название локи"


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		var player = area.get_parent()
		print(player.name)
		player.location_found(location_name)
