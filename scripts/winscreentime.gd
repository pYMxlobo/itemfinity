extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.speedrun == true:
		show()
		if Global.time > Global.lowest_time:
			text = "Time: " + str(Global.time) + "[NEW RECORD!]
			Old Record: " + str(Global.lowest_time)
			Global.lowest_time = Global.time
		else:
			text = "Time: " + str(Global.time) + "
			Lowest Record: " + str(Global.lowest_time)
	else:
		hide()

