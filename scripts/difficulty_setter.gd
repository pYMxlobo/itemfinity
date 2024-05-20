extends SpinBox


func _ready():
	value = Global.difficulty
	DisplayServer.window_set_title("ItemFinity")


func _on_value_changed(value):
	Global.difficulty = value
