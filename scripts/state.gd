extends Node

var strength_status = 0
var helped_sister = false
var killed = []

func up_strength(currency):
	strength_status += currency

func change_strength(currency):
	var player = get_node("/root/Main/Player")
	strength_status = int(currency)
	player.update_strength()

func killing_without_save(name):
	var player = get_node("/root/Main/Player")
	var character = get_node("/root/Main/" + name)
	var anim = character.get_node("AnimationPlayer")
	var camera = player.get_node("Camera2D")
	var audio = player.get_node("sound_damage")
	
	anim.play("death")
	audio.play()
	camera.apply_shake(5)
	await anim.animation_finished
	killing(name)
	strength_status += character.reward
	player.update_strength()
func killing(name):
	var current_delta = get_process_delta_time()
	var player = get_node("/root/Main/Player")
	var character = get_node("/root/Main/" + name)
	
	killed.append(name)
	if character.name == "goblin":
		helped_sister = true
	var collision_character = character.get_node("CollisionShape2D")
	var area_character = character.get_node("Dialogue")
	area_character.monitorable = false # Делаем ноду немониторируемой для других объектов
	area_character.monitoring = false  # Отключаем мониторинг сигналов
	collision_character.disabled = true
	character.hide()  # Скрыть объект
	character.set_process(false)
	character.set_physics_process(false)
	

func recovery(name):
	var root = get_tree().get_root()
	var character = root.get_node("Main/" + name)
	
	if character is CharacterBody2D:
		if character.has_node("Dialogue"):
			var collision_character = character.get_node("CollisionShape2D")
			var area_character = character.get_node("Dialogue")
			area_character.monitoring = true
			area_character.monitorable = true
			if character.name == "goblin":
				helped_sister = false
			collision_character.disabled = false
			character.show()
			character.set_process(true)
			character.set_physics_process(true)


func cut_strength(currency):
	var player = get_node("/root/Main/Player")
	var camera = player.get_node("Camera2D")
	var audio = player.get_node("sound_damage")
	audio.play()
	camera.apply_shake(30)
	strength_status -= currency
	player.update_strength()

func show_boobs():
	var root = get_tree().get_root()
	var boobs = root.get_node("Main/boobs")
	var anim = boobs.get_node("AnimatedSprite2D")
	anim.play("showing")
	await get_tree().create_timer(1.0).timeout
	anim.play("idle")
