extends Camera2D

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var shake_active = false

@export var single = true

var rng = RandomNumberGenerator.new


var shake_strength: float = 0.0


func _process(delta):
	if shake_active == true:
		apply_shake()
		if single == true:
			shake_active = false
	
	
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		offset = randomOffset()



func apply_shake():
	shake_strength = randomStrength


func randomOffset() -> Vector2:
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
