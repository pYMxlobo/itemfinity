extends Node2D

var pre_bgm = Global.bgm
@export var bgm_1 : AudioStreamPlayer
@export var bgm_2 : AudioStreamPlayer
@export var bgm_3 : AudioStreamPlayer

func music_change():
	if Global.bgm == 1:
		bgm_1.play()
		bgm_2.stop()
		bgm_3.stop()
	if Global.bgm == 2:
		bgm_1.stop()
		bgm_2.play()
		bgm_3.stop()
	if Global.bgm == 3:
		bgm_1.stop()
		bgm_2.stop()
		bgm_3.play()

func _ready():
	Global.loading_room = false
	music_change()

func _process(delta):
	if Global.bgm != pre_bgm:
		music_change()
