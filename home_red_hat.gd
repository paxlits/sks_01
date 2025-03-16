extends RigidBody2D

var is_red_hat_home := false

# Добавьте эти сигналы через редактор Godot
func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		is_red_hat_home = true

func _on_area_2d_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		is_red_hat_home = false

# Убраны неиспользуемые параметры
func _on_body_shape_entered(_body_rid: RID, body: Node, _body_shape_index: int, _local_shape_index: int) -> void:
	pass  # Этот метод можно удалить, если не используется

func _process(_delta: float) -> void:
	if is_red_hat_home and Input.is_action_just_pressed("e"):
		get_tree().change_scene_to_file("res://scenes/home_krasnaya_chapochka/inHouse.tscn")
