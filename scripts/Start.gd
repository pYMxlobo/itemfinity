extends TextureButton



func _on_pressed():
	TransitionManager.change_scene("res://scenes/main_level.tscn", TransitionManager.TransitionType.FallDown)
