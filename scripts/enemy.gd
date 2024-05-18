extends CharacterBody2D

@export var is_chunk = true
@export var type : String
var speed = 50
var health : int = 10
@export var bob = true
@export var player : CharacterBody2D
var player_hitbox : Node2D
#@export var damager : Node2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D

var bullets : Spawner

var bullet_time : float

var player_spotted = false


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
	if is_chunk == true:
		player = get_parent().get_parent().player
	player_hitbox = player.hitbox
	if type == "red":
		speed = 50
		health = 10
		bullet_time = 0.5
	elif type == "orange":
		speed = 30
		health = 20
		bullet_time = 0.35
	elif type == "yellow":
		speed = 55
		health = 8
		bullet_time = 0.7
	elif type == "green":
		speed = 80
		health = 5
		bullet_time = 2
	elif type == "blue":
		speed = 40
		health = 10
		bullet_time = 0.05
	elif type == "purple":
		speed = 20
		health = 15
		bullet_time = 0.05
	elif type == "rainbow":
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
	if health <= 0:
		$die.play()
		$hurt.stop()
		queue_free()
	$Label.text = "Health: " + str(health)
	
	if Global.difficulty > pre_dif:
		health += Global.difficulty * 10
		pre_dif = Global.difficulty
	


func _on_area_2d_body_entered(body):
	print("attack detected :/ body edition")
	if body == player.attacker:
		$hurt.play()
		health -= player.atk_damg
		player.attacker.position = Vector2(0, 0)
		print("hehe enemy got hit")


func _on_bullet_spawn_loop_timeout():
	bullets.set_manual_start(true)



func determine_bullet():
	var ntype = StringName(type)
	var redname = $red.name
	var orangename = $orange.name
	var yellowname = $yellow.name
	var greenname = $green.name
	var bluename = $blue.name
	var purplename = $purple.name
	#var rainbowname
	if redname == ntype:
		bullets = $red
	else:
		$red.queue_free()
	if orangename == ntype:
		bullets = $orange
	else:
		$orange.queue_free()
	if yellowname == ntype:
		bullets = $yellow
	else:
		$yellow.queue_free()
	if greenname == ntype:
		bullets = $green
	else:
		$green.queue_free()
	if bluename == ntype:
		bullets = $blue
	else:
		$blue.queue_free()
	if purplename == ntype:
		bullets = $purple
	else:
		$purple.queue_free()


func _on_enemy_hurt_area_entered(area):
	if area == player.attacker:
		$hurt.play()
		health -= player.atk_damg
		player.attacker.position = Vector2(0, 0)

