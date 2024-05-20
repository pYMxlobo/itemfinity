extends TextureButton



func _on_pressed():
	Global.time = 0
	TransitionManager.change_scene("res://scenes/loading_scene.tscn", TransitionManager.TransitionType.FallDown)
