extends CharacterBody2D


@export var speed = 50
@export var health : int = 10
@export var bob = true
@export var player : Node2D
#@export var damager : Node2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
var screen_size = get_viewport_rect().size

func _physics_process(_delta: float) -> void:
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	velocity = dir * speed
	move_and_slide()



func makepath() -> void:
	nav_agent.target_position = player.global_position



func _on_timer_timeout():
	makepath()

func _ready():
	var tween = create_tween()
	var sprite_pos = $Spellcaster
	if bob == true:
		tween.set_loops()
		tween.tween_property(sprite_pos, "position", Vector2(0, -5), 2)
		tween.tween_property(sprite_pos, "position", Vector2(0, 5), 2)


func _process(_delta):
	screen_size = get_viewport_rect().size
	if health <= 0:
		queue_free()
	$Label.text = "Health: " + str(health)
	randy_attack(100)
	
	


func _on_area_2d_body_entered(body):
	print("hehe enemy got hit")

func randy_attack(max_randy : int):
	var random = randi_range(0, max_randy)
	if random == 0:
		pattern_gen()



#romzerr0 stuff
func pattern_gen(amount = 10, target = "player", type = "bullet", speed = 100, shape = "default", order = "default", spread = 0, scale = 2, offset = Vector2.ZERO, att_speed = 0.0, delay = 0.0, phase = 0, color = "rainbow", pregen = false, pregenerated = null):
	var danmaku_type
	var target_angle
	var target_position
	var target_linear_velocity
	var aim: Vector2
	var spread_rad = deg_to_rad(spread)
	var angle_step_r
	var angle_to_player
	var angle_to_player_static
	var angle_step
	var array = []
	var childs = []
	var dummypos = Vector2(global_position.x,global_position.y+500)
	var global_position_local = global_position
	var diff
	danmaku_type = load("res://scenes/"+str(type)+".tscn")
		
	if target == "self":
		aim = Vector2.ZERO
		angle_to_player_static = global_position.angle_to_point(aim)
	if target == "player":
		aim = get_node('../The Orb').position
		angle_to_player_static = global_position.angle_to_point(aim)
	if target == "center":
		aim = screen_size/2
		angle_to_player_static = global_position.angle_to_point(aim)
	if target == "none":
		aim = dummypos
		angle_to_player_static = global_position.angle_to_point(aim)
	if target == "catch":
		var predict = get_node('../The Orb').position + get_node('../The Orb').velocity.normalized()* get_node('../The Orb').speed *0.7
		aim = predict
		angle_to_player_static = position.angle_to_point(aim)	
		
	angle_step = PI * 2 / amount
	angle_step_r = spread_rad / (amount - 1)
	if phase <0:
		angle_step_r = angle_step_r * -1
	angle_to_player_static = position.angle_to_point(aim)
	
	for i in range(amount):
		var angle = angle_step * i
		angle_to_player = global_position_local.angle_to_point(aim)

		if shape == "default":
			target_position = global_position_local + offset
		if shape == "circle":
			var radius = scale * 5
			target_position = Vector2(cos(angle), sin(angle)) * radius
			target_position = target_position.rotated(angle_to_player + 3 * PI / 2 + deg_to_rad(phase)) 
			target_position = target_position + offset
		if shape == "heart":
			var x = scale * (16 * pow(sin(angle), 3))
			var y = -scale * (13 * cos(angle) - 5 * cos(2 * angle) - 2 * cos(3 * angle) - cos(4 * angle))
			target_position = Vector2(x, y)
			target_position = target_position.rotated(angle_to_player + 3 * PI / 2 + deg_to_rad(phase))
			target_position = target_position + offset
		if shape == "delta":
			var x = scale * (2 * cos(angle) + cos(2*angle))
			var y = scale * (2 * sin(angle) - sin(2 * angle))
			target_position = Vector2(x, y)
			target_position = target_position.rotated(angle_to_player + 3 * PI / 2 + deg_to_rad(phase))
			target_position = target_position + offset
		if shape == "clover":
			var x = scale * (20 * (cos(angle) + cos(5*angle)/5))
			var y = scale * (20 * (sin(angle) + sin(5*angle)/5))
			target_position = Vector2(x, y)
			target_position = target_position.rotated(angle_to_player + 3 * PI / 2 + deg_to_rad(phase))
			target_position = target_position + offset
		if shape == "rose5":
			var x = scale * (4 * cos(angle) + cos(4 * angle))
			var y = scale * (4 * sin(angle) - sin(4 * angle))
			target_position = Vector2(x, y)
			target_position = target_position.rotated(angle_to_player + 3 * PI / 2 + deg_to_rad(phase))
			target_position = target_position + offset
		if shape == "rose7":
			var x = scale * (2 * cos(angle) + cos(6 * angle))
			var y = scale * (2 * sin(angle) - sin(6 * angle))
			target_position = Vector2(x, y)
			target_position = target_position.rotated(angle_to_player + 3 * PI / 2 + deg_to_rad(phase))
			target_position = target_position + offset
		if shape == "rose4":
			var x = scale * (2 * cos(angle) + cos(3 * angle))
			var y = scale * (2 * sin(angle) - sin(3 * angle))
			target_position = Vector2(x, y)
			target_position = target_position.rotated(angle_to_player + 3 * PI / 2 + deg_to_rad(phase))
			target_position = target_position + offset
			
		if target == "self":
			target_angle = (target_position+global_position).angle_to_point(global_position)
		elif target == "center":
			target_angle = (target_position+(screen_size / 2)).angle_to_point(screen_size/2)
		else:
			target_angle = (target_position+global_position_local).angle_to_point(aim)
			diff = target_angle - angle_to_player_static
			target_angle = angle_to_player_static + (-diff * (spread_rad * ((target_position+global_position_local).distance_to(aim)/25)))
		target_linear_velocity = Vector2(cos(target_angle), sin(target_angle)) * speed
			
		var danmaku = danmaku_type.instantiate()
		if target == "center":
			danmaku.position = target_position + (screen_size / 2)
		else:
			danmaku.position = target_position + global_position_local
		danmaku.delayed_linear_velocity = target_linear_velocity
		danmaku.linear_velocity = target_linear_velocity
		danmaku.rotation = target_angle
		danmaku.color = color
		
		if delay != 0 or att_speed != 0:
			danmaku.linear_velocity = Vector2.ZERO
		
		if pregen:
			array.append([target_position,target_angle,target_linear_velocity,danmaku.delayed_linear_velocity])
		else:
			array.append(danmaku)
		
	if pregen:
		return(array)
		
	if att_speed >0:
		array.reverse()
	for i in array.size():
		add_child(array[i])
		array[i].delayed_start(att_speed * i,delay)



