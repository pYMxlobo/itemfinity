extends Node2D

#var first_random = randi_range(0, 2)

@export var bgm_1 : AudioStreamPlayer
@export var bgm_2 : AudioStreamPlayer
@export var bgm_3 : AudioStreamPlayer


#var second_random = randi_range(0, 3)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	music_change(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.dead == true:
		set_process_input(false)
	else:
		set_process_input(true)

func music_change(id : int):
	if id == 1:
		bgm_1.play()
		bgm_2.stop()
		bgm_3.stop()
	if id == 2:
		bgm_1.stop()
		bgm_2.play()
		bgm_3.stop()
	if id == 3:
		bgm_1.stop()
		bgm_2.stop()
		bgm_3.play()
