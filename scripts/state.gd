extends Node

var strength_status = 0
var helped_sister = false
var killed = []


func up_strength():
	strength_status += 1

func change_strength(currency):
	var root = get_tree().get_root()
	var player = root.get_node("Main/Player")
	strength_status = int(currency)
	player.update_strength()
func killing(name):
	var root = get_tree().get_root()
	var character = root.get_node("Main/" + name)
	print(root.get_children())
	killed.append(name)
	print(character)
	if character.name == "goblin":
		helped_sister = true
	character.hide()  # Скрыть объект
	character.set_process(false)  # Отключить обработку
	character.set_physics_process(false)

func recovery(name):
	var root = get_tree().get_root()
	var character = root.get_node("Main/" + name)
	print(root.get_children())
	print(character)
	if character.name == "goblin":
		helped_sister = false
	character.show()
	character.set_process(true)
	character.set_physics_process(true)

func cut_strength(currency):
	var root = get_tree().get_root()
	var player = root.get_node("Main/Player")
	var camera = player.get_node("Camera2D")
	camera.apply_shake()
	strength_status -= currency
	player.update_strength()

func show_boobs():
	var root = get_tree().get_root()
	var boobs = root.get_node("Main/boobs")
	var anim = boobs.get_node("AnimatedSprite2D")
	anim.play("showing")
	await get_tree().create_timer(1.0).timeout
	anim.play("idle")
