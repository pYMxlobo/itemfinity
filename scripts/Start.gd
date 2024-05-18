extends TextureButton



func _on_pressed():
	TransitionManager.change_scene("res://scenes/loading_scene.tscn", TransitionManager.TransitionType.FallDown)
