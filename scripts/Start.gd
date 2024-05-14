extends TextureButton



func _on_pressed():
	TransitionManager.change_scene("res://scenes/testo.tscn", TransitionManager.TransitionType.FallDown)
