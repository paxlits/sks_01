extends Camera2D

@export var zoom_speed: float = 0.1
@export var min_zoom: Vector2 = Vector2(0.5, 0.5)
@export var max_zoom: Vector2 = Vector2(2, 2)

var target_zoom: Vector2 = Vector2(1, 1)

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func apply_shake():
	shake_strength = randomStrength
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade*delta)
		offset = randomOffset()
	# Обработка ввода для зума
	if Input.is_action_just_released("zoom_up"):
		target_zoom -= Vector2(zoom_speed, zoom_speed)
	if Input.is_action_just_released("zoom_down"):
		target_zoom += Vector2(zoom_speed, zoom_speed)
	
	# Ограничение целевого зума
	target_zoom = target_zoom.clamp(min_zoom, max_zoom)
	
	# Плавное изменение зума
	zoom = zoom.lerp(target_zoom, 0.1)
