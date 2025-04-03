extends Node2D

@onready var pause_menu = $Player/PauseMenu
var paused = false
var save_path = "user://save.save"
var after_pause_dialog = false
func _ready() -> void:
	load_scene()
	pause_menu.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		save_scene()
	if Input.is_action_just_pressed("load"):
		load_scene()
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func save_scene():
	var save_data = {
		"player_position": [$Player.position.x, $Player.position.y],
		"strength": 0,
		"killed": []
	}
	save_data["player_position"] = [$Player.position.x, $Player.position.y]
	save_data["strength"] = State.strength_status
	save_data["killed"] = State.killed
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
func load_scene():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var json_string = file.get_as_text()
		file.close()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if parse_result == OK:
			var save_data = json.get_data()
			var player_position_array = save_data["player_position"]
			
			var player_position = Vector2(player_position_array[0], player_position_array[1])

			# Присваиваем позицию игроку
			$Player.position = player_position
			
			# Создаём список объектов, которые должны существовать
			var killed = save_data["killed"]
			State.change_strength(save_data["strength"])
			for obj in $".".get_children():
				if obj.name in killed:
					State.killing(obj.name)
				else:
					State.recovery(obj.name)  # Удаляем объект, если он не должен существовать
		

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		if after_pause_dialog:
			$Player.can_dialog = true
	else:
		if $Player.can_dialog:
			$Player.can_dialog = false
			after_pause_dialog = true
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
