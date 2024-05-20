extends SpinBox


func _ready():
	value = Global.difficulty


func _on_value_changed(value):
	Global.difficulty = value
