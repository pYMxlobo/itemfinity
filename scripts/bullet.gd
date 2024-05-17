extends RigidBody2D

var alive = false

var delayed_linear_velocity = Vector2.ZERO

var screen_size

var color : String
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play(color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#romzerr0 stuff
func delayed_start(t = 0.0,d = 0.0):
	if t != null:
		await get_tree().create_timer(abs(t)).timeout
	show()
	if d != null:
		if d <= 0:
			await get_tree().create_timer(abs(d)-abs(t)).timeout
		else:
			await get_tree().create_timer(d).timeout
	linear_velocity = delayed_linear_velocity
	#$AudioStreamPlayer.play()
	$DeathTimer.start()


func _die():
	queue_free()
