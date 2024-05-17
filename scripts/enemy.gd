extends CharacterBody2D


var type : String
var speed = 50
var health : int = 10
@export var bob = true
@export var player : Node2D
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
	type = str(bullets.name)
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
