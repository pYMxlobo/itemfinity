extends CharacterBody2D


@export var type : StringName
var speed = 50
var health : int = 10
@export var bob = true
@export var player : Node2D
@export var player_hitbox : Node2D
#@export var damager : Node2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D

@export var bullets : Spawner

var bullet_time : float

var player_spotted = false
var screen_size = get_viewport_rect().size


var pre_dif = Global.difficulty


func _physics_process(_delta: float) -> void:
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	velocity = dir * speed
	move_and_slide()



func makepath() -> void:
	if player_spotted == true:
		nav_agent.target_position = player.global_position



func _on_timer_timeout():
	makepath()

func _ready():
	var stype = str(type)
	if stype == "red":
		speed = 50
		health = 10
		bullet_time = 0.5
	elif stype == "orange":
		speed = 30
		health = 20
		bullet_time = 0.35
	elif stype == "yellow":
		speed = 55
		health = 8
		bullet_time = 0.7
	elif stype == "green":
		speed = 80
		health = 5
		bullet_time = 2
	elif stype == "blue":
		speed = 40
		health = 10
		bullet_time = 0.05
	elif stype == "purple":
		speed = 20
		health = 15
		bullet_time = 0.05
	elif stype == "rainbow":
		speed = 100
		health = 40
		bullet_time = 0.1
	else:
		print("you named the type wrong moron")
	determine_bullet()
	bullets.trackedNode = player
	bullets.bullet_hit.connect(player_hitbox.bullet_hit)
	$BulletSpawnLoop.wait_time = bullet_time
	$S.play(type)
	var tween = create_tween()
	var sprite_pos = $S
	if bob == true:
		tween.set_loops()
		tween.tween_property(sprite_pos, "position", Vector2(0, -5), 2)
		tween.tween_property(sprite_pos, "position", Vector2(0, 5), 2)


func _process(_delta):
	screen_size = get_viewport_rect().size
	if health <= 0:
		$die.play()
		$hurt.stop()
		queue_free()
	$Label.text = "Health: " + str(health)
	
	if Global.difficulty > pre_dif:
		health += Global.difficulty * 10
		pre_dif = Global.difficulty
	


func _on_area_2d_body_entered(body):
	print("attack detected :/")
	if body == player.attacker:
		$hurt.play()
		health -= player.atk_damg
		player.attacker.position = Vector2(0, 0)
		print("hehe enemy got hit")


func _on_seeing_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body == player:
		player_spotted = true
		$BulletSpawnLoop.start()
		bullets.set_manual_start(true)
		$seeing.queue_free()


func _on_bullet_spawn_loop_timeout():
	bullets.set_manual_start(true)


func _on_enemy_hurt_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("attack detected :/ body shape edition")
	if body == player.attacker:
		$hurt.play()
		health -= player.atk_damg
		player.attacker.position = Vector2(0, 0)
		print("hehe enemy got hit")


func determine_bullet():
	var redname = $red.name
	var orangename = $orange.name
	var yellowname = $yellow.name
	var greenname = $green.name
	var bluename
	var purplename
	var rainbowname
	if redname != type:
		$red.queue_free()
	elif redname == type:
		bullets = $red
	if orangename != type:
		$orange.queue_free()
	elif orangename == type:
		bullets = $orange
	if yellowname != type:
		$yellow.queue_free()
	elif yellowname == type:
		bullets = $yellow
	if greenname != type:
		$green.queue_free()
	elif greenname == type:
		bullets = $green
