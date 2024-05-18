extends Node2D

#var first_random = randi_range(0, 2)
@export var loading : AudioStreamPlayer

#var second_random = randi_range(0, 3)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.dead == true:
		set_process_input(false)
	else:
		set_process_input(true)
	
	
	if Global.loading_room == true:
		loading.play()
	else:
		loading.stop()
