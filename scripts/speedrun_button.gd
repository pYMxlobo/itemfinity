extends CheckButton




func _on_toggled(toggled_on):
	Global.speedrun = toggled_on
	#print("speedrun check: " + str(Global.speedrun))
