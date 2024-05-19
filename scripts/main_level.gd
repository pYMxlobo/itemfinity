extends Node2D

#var first_random = randi_range(0, 2)
@export var loading : AudioStreamPlayer

@export var boss_door : TileMap

@export var refs : TileMap
#var second_random = randi_range(0, 3)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	refs.position = Vector2(-100000, -100000)

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
	
	
	if Global.boss_active == true:
		boss_door.position = Vector2(-200, -200)
