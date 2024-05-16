extends Label



func _ready():
	if OS.has_feature("web"):
		show()
	else:
		hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = ("Health : " + str(Global.health))
