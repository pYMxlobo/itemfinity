extends Area2D

@export var randomized = true
@export var chosen : String
@export var auto_load = false

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
		player.loader.show()
		Global.loading_room = true
		#player.loader.show()
		OS.delay_msec(5)
		birthed_chunk = load(random)
		new_chunk = birthed_chunk.instantiate
		new_chunk = birthed_chunk.instantiate()
		new_chunk.player = player
		add_sibling(new_chunk)
		timer.start()
	#	get_child(0).disabled = true
		#self.queue_free()


func _on_timer_timeout():
	get_child(0).disabled = true
