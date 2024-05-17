extends Node2D

#var first_random = randi_range(0, 2)
@export var delay_load : Timer
#var second_random = randi_range(0, 3)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.dead == true:
		set_process_input(false)
