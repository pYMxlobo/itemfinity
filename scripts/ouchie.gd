extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
var damage_allow = true

@export var timer : Timer

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if damage_allow == true:
		Global.health -= 1
		print(Global.health)
		damage_allow = false
		timer.start()

func _on_timer_timeout():
	damage_allow = true
