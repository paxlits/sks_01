extends RigidBody2D

var next_level_path = "res://scenes/home krasnaya chapochka/inHouse.tscn"

# Добавьте эти сигналы через редактор Godot
func _on_area_2d_body_entered(body: Node) -> void:
	print("чел подошёл")
	if body.name == ("Player"):
		get_tree().change_scene_to_file(next_level_path)
		#var next_level = load(next_level_path)
		#var next_level_instance = next_level.instantiate()
		#var spawn_point = next_level_instance.get_node("PlayerSpawnPoint")  # Убедитесь, что такая точка существует
		#if spawn_point:
			#body.global_position = spawn_point.global_position
		#get_tree().current_scene.call_deferred("queue_free")
		#get_tree().root.add_child(next_level_instance)
		#get_tree().current_scene = next_level_instance

# Убраны неиспользуемые параметры
func _on_body_shape_entered(_body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	pass  # Этот метод можно удалить, если не используется

		
