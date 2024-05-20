extends Area2D

@export var randomized = true
@export var chosen : String
@export var auto_load = false
@export var dif_increase : int
@export var player : CharacterBody2D
@export var rooms : Array[String]
@export var timer : Timer


var random : String



func _ready():
	#max_vari = get_child_count()
	#print("max_vari:" + str(max_vari))
	if randomized == true:
		random = rooms.pick_random()
	elif randomized == false:
		random = chosen
	if auto_load == true:
		_on_body_entered(player)
	



func _on_body_entered(body):
	var new_chunk
	var birthed_chunk
	if body == player:
		print("load attempt for " + str(name))
		player.loader.show()
		Global.loading_room = true
		Global.difficulty += dif_increase
		#player.loader.show()
		OS.delay_msec(5)
		birthed_chunk = load(random)
		new_chunk = birthed_chunk.instantiate
		new_chunk = birthed_chunk.instantiate()
		new_chunk.player = player
		call_deferred("add_child", new_chunk)
		timer.start()
	#	get_child(0).disabled = true
		#self.queue_free()


func _on_timer_timeout():
	var child_additive : int = 0
	if get_child(child_additive) is CollisionPolygon2D:
		get_child(child_additive).set_deferred("disabled", true)
	else:
		child_additive += 1
