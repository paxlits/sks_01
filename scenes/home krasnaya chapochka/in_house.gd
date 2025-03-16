extends Node2D

var next_level_path = "res://scenes/main.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("чел подошёл")
	if body.name == ("Player"):
		var next_level = load(next_level_path)
		var next_level_instance = next_level.instantiate()
		var spawn_point = next_level_instance.get_node("PlayerSpawnPoint")  # Убедитесь, что такая точка существует
		if spawn_point:
			body.global_position = spawn_point.global_position
		get_tree().current_scene.queue_free()
		get_tree().root.add_child(next_level_instance)
		get_tree().current_scene = next_level_instance
