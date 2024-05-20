extends Node2D

var pre_bgm = Global.bgm
@onready var bgm_1 : AudioStreamPlayer = $purity as AudioStreamPlayer
@onready var bgm_2 : AudioStreamPlayer = $finalboss as AudioStreamPlayer
@onready var bgm_3 : AudioStreamPlayer = $wrath as AudioStreamPlayer

func music_change():
	if bgm_1 != null:
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

func _process(_delta):
	if Global.bgm != pre_bgm:
		music_change()
		pre_bgm = Global.bgm
