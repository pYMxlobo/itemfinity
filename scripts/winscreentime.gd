extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.speedrun == true:
		Global.load_ach()
		show()
		if Global.time < Global.lowest_time:
			text = "Time: " + str(Global.time) + " [NEW RECORD!]
			Old Record: " + str(Global.lowest_time)
			Global.lowest_time = Global.time
			Global.save_ach()
		else:
			text = "Time: " + str(Global.time) + "
			Lowest Record: " + str(Global.lowest_time)
	else:
		hide()

