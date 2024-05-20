extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
var damage_allow = true

@export var timer : Timer


#func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
#	if damage_allow == true:
#		Global.health -= 1
#		print(Global.health)
#		damage_allow = false
#		timer.start()

func _on_timer_timeout():
	damage_allow = true

func _process(_delta):
	if Global.dead == true:
		$hitbox.disabled = true
	else:
		$hitbox.disabled = false




#func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
#	if Global.dead == false:
#		if body.is_in_group("bullet"):
#			if damage_allow == true:
#				Global.health -= 1
#				print(Global.health)
#				damage_allow = false
#				timer.start()


func bullet_hit(_result, _bulletIndex, _spawner):
	if Global.dead == false:
		if damage_allow == true:
			Global.health -= 1
			#print(Global.health)
			damage_allow = false
			timer.start()
