extends TextureButton



func _on_pressed():
	TransitionManager.change_scene("res://scenes/titlescreen.tscn", TransitionManager.TransitionType.ZoomOut)
