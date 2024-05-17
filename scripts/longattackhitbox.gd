extends CollisionShape2D

@export var attack_direction : String
# Called when the node enters the scene tree for the first time.
var default_pos_x : float
var default_pos_y : float


func _ready():
	default_pos_x = position.x
	default_pos_y = position.y
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	shape.size.y = Global.atk_range * 10
	#if disabled == false:
	#	$anim.play("attack")
	#elif disabled == true:
	#	$anim.play("default")
	#get_parent().position.x = default_pos_x
	#get_parent().position.y = default_pos_y



func _input(event):
	if event.is_action_pressed("atk_up"):
		if attack_direction == "up":
			disabled = false
			$anim.play("attack")
			pos_fix()
		else:
			disabled = true
			$anim.stop()
			$anim.play("default")
	if event.is_action_pressed("atk_down"):
		if attack_direction == "down":
			disabled = false
			$anim.play("attack")
			pos_fix()
		else:
			disabled = true
			$anim.stop()
			$anim.play("default")
	if event.is_action_pressed("atk_left"):
		if attack_direction == "left":
			disabled = false
			$anim.play("attack")
			pos_fix()
		else:
			disabled = true
			$anim.stop()
			$anim.play("default")
	if event.is_action_pressed("atk_right"):
		if attack_direction == "right":
			disabled = false
			$anim.play("attack")
			pos_fix()
		else:
			disabled = true
			$anim.stop()
			$anim.play("default")
	if event.is_action_released("atk_up"):
		if attack_direction == "up":
			disabled = true
			$anim.stop()
			$anim.play("default")
	if event.is_action_released("atk_down"):
		if attack_direction == "down":
			disabled = true
			$anim.stop()
			$anim.play("default")
	if event.is_action_released("atk_left"):
		if attack_direction == "left":
			disabled = true
			$anim.stop()
			$anim.play("default")
	if event.is_action_released("atk_right"):
		if attack_direction == "right":
			disabled = true
			$anim.stop()
			$anim.play("default")




func pos_fix():
	position.x = default_pos_x
	position.y = default_pos_y
