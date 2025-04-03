extends CharacterBody2D

var nearest_area_object
var nearest_body_object
var can_dialog = false
var can_train = false
var can_train2 = true
var last_direction = Vector2.ZERO
@export var SPEED = 600.0
var WALK_SPEED = 600
var RUN_SPEED = 2000
var state_dialog = false
func _ready():
	$GPUParticles2D.emitting = false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("run"):
		SPEED = RUN_SPEED
	else:
		SPEED = WALK_SPEED
	dialog_player()
	move_player()
	move_and_slide()


func dialog_player():
	if can_dialog and !state_dialog:
		$CanvasLayer/Tip.text = "Нажмите \"E\", чтобы поговорить"
		$CanvasLayer/Tip.modulate = Color(255, 255, 255, 1)
		$CanvasLayer/Tip.show()
	elif can_train:
		$CanvasLayer/Tip.text = "Нажмите \"ЛКМ\", чтобы ударить"
		$CanvasLayer/Tip.modulate = Color(255, 255, 255, 1)
		$CanvasLayer/Tip.show()
	else:
		$CanvasLayer/Tip.hide()
	if Input.is_action_just_pressed("ui_interact"):
		if can_dialog and !state_dialog:
			state_dialog = true
			
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/" + nearest_body_object.name + ".dialogue"), "start")
			await DialogueManager.dialogue_ended
			state_dialog = false
	if can_train and Input.is_action_just_pressed("attack") and can_train2:
		State.up_strength(1)
		$"../train_dummy".kicked()
		update_strength()
		can_train2 = false
		await get_tree().create_timer(1.0).timeout
		can_train2 = true
	
func update_strength():
	$CanvasLayer/strength_player.text = "Сила: %s" %State.strength_status

func location_found(name):
	$CanvasLayer/WelcomeLabel.text = name
	$CanvasLayer/WelcomeLabel/AnimationPlayer.play("show_text")

	await get_tree().create_timer(3.0).timeout
	$CanvasLayer/WelcomeLabel/AnimationPlayer.play("hide_text")
	$CanvasLayer/WelcomeLabel.modulate = Color(255, 255, 255, 0)

func move_player():
	var input_direction := Vector2(
	Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	if input_direction != Vector2.ZERO:
		last_direction = input_direction
		velocity = input_direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	if velocity == Vector2.ZERO:
		$AudioStreamPlayer2D.stop()
		if last_direction.y > 0:
			$AnimatedSprite2D.play("idle_down")
		elif last_direction.y < 0:
			$AnimatedSprite2D.play("idle_up")
		elif last_direction.x > 0:
			$AnimatedSprite2D.play("idle_side")
			$AnimatedSprite2D.flip_h = true
		elif last_direction.x < 0:
			$AnimatedSprite2D.play("idle_side")
			$AnimatedSprite2D.flip_h = false
	else:
		if !$AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()
		if velocity.y > 0:
			$AnimatedSprite2D.play("down")
		elif velocity.y < 0:
			$AnimatedSprite2D.play("up")
		elif velocity.x < 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side")
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side")

	


func _on_player_area_entered(area: Area2D) -> void:
	nearest_area_object = area
	if nearest_area_object.name == "train":
		can_train = true



func _on_player_area_exited(area: Area2D) -> void:
	$'..'.after_pause_dialog = false
	can_dialog = false
	can_train = false


func _on_player_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("npcs"):
		nearest_body_object = body
		can_dialog = true
