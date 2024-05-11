extends TextureProgressBar

@export var player : CharacterBody2D



func _process(delta):
	max_value = player.max_slow
	value = player.slow_charge
