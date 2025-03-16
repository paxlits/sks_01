extends Area2D

@export var location_name: String = "название локи"


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		var player = area.get_parent()
		var particle = player.get_node("GPUParticles2D")
		particle.emitting = true
		player.location_found(location_name)


func _on_area_exited(area: Area2D) -> void:
	if area.name == "Player":
		var player = area.get_parent()
		var particle = player.get_node("GPUParticles2D")
		particle.emitting = false
