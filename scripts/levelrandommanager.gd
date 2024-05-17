extends Node2D

@export var number : int

@export var chunk_id : int

# Called when the node enters the scene tree for the first time.
func _ready():
	if chunk_id == 0:
		if get_parent().get_parent().first_random == number:
			pass
		else:
			queue_free()
	elif chunk_id == 1:
		if get_parent().get_parent().second_random == number:
			pass
		else:
			queue_free()
