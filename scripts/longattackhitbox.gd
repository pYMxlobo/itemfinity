extends CollisionShape2D

@export var attack_direction : String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shape.size.y = get_parent().atk_range * 10




func _input(event):
	if event.is_action_pressed("atk_up"):
		if attack_direction == "up":
			disabled = false
		else:
			disabled = true
	if event.is_action_pressed("atk_down"):
		if attack_direction == "down":
			disabled = false
		else:
			disabled = true
	if event.is_action_pressed("atk_left"):
		if attack_direction == "left":
			disabled = false
		else:
			disabled = true
	if event.is_action_pressed("atk_right"):
		if attack_direction == "right":
			disabled = false
		else:
			disabled = true
	if event.is_action_released("atk_up"):
		if attack_direction == "up":
			disabled = true
	if event.is_action_released("atk_down"):
		if attack_direction == "down":
			disabled = true
	if event.is_action_released("atk_left"):
		if attack_direction == "left":
			disabled = true
	if event.is_action_released("atk_right"):
		if attack_direction == "right":
			disabled = true
