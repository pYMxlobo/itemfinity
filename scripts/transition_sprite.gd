extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.loading_room == true:
		visible = false
	else:
		visible = true
