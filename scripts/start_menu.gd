extends Control

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_settings_pressed() -> void:
	$Label.text = "иди нахуй"


func _on_leave_pressed() -> void:
	get_tree().quit()
