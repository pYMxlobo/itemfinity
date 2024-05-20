extends CharacterBody2D

var bullets_fired = 0

@export var is_chunk = true
@export_enum("red", "orange", "yellow", "green", "blue", "purple", "boss") var type : String
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
		await get_parent().ready
	if is_chunk == true:
		player = get_parent().player
	player_hitbox = player.hitbox
	if type == "red":
		speed = 50
		health = 10 * Global.difficulty
		bullet_time = 0.5
		$enemy_hurt/CollisionShape2D.shape.radius = 9
		$enemy_hurt/CollisionShape2D.shape.height = 38
		$CollisionShape2D.shape.radius = 9
		$CollisionShape2D.shape.height = 38
		$seeing/CollisionShape2D.shape.radius = 119
		$Label.position.y = -30
	elif type == "orange":
		speed = 30
		health = 20 * Global.difficulty
		bullet_time = 0.45
		$enemy_hurt/CollisionShape2D.shape.radius = 9
		$enemy_hurt/CollisionShape2D.shape.height = 38
		$CollisionShape2D.shape.radius = 9
		$CollisionShape2D.shape.height = 38
		$seeing/CollisionShape2D.shape.radius = 119
		$Label.position.y = -30
	elif type == "yellow":
		speed = 55
		health = 8 * Global.difficulty
		bullet_time = 0.7
		$enemy_hurt/CollisionShape2D.shape.radius = 9
		$enemy_hurt/CollisionShape2D.shape.height = 38
		$CollisionShape2D.shape.radius = 9
		$CollisionShape2D.shape.height = 38
		$seeing/CollisionShape2D.shape.radius = 119
		$Label.position.y = -30
	elif type == "green":
		speed = 80
		health = 5 * Global.difficulty
		bullet_time = 2
		$enemy_hurt/CollisionShape2D.shape.radius = 9
		$enemy_hurt/CollisionShape2D.shape.height = 38
		$CollisionShape2D.shape.radius = 9
		$CollisionShape2D.shape.height = 38
		$seeing/CollisionShape2D.shape.radius = 119
		$Label.position.y = -30
	elif type == "blue":
		speed = 40
		health = 10 * Global.difficulty
		bullet_time = 0.05
		$enemy_hurt/CollisionShape2D.shape.radius = 9
		$enemy_hurt/CollisionShape2D.shape.height = 38
		$CollisionShape2D.shape.radius = 9
		$CollisionShape2D.shape.height = 38
		$seeing/CollisionShape2D.shape.radius = 119
		$Label.position.y = -30
	elif type == "purple":
		speed = 20
		health = 15 * Global.difficulty
		bullet_time = 0.05
		$enemy_hurt/CollisionShape2D.shape.radius = 9
		$enemy_hurt/CollisionShape2D.shape.height = 38
		$CollisionShape2D.shape.radius = 9
		$CollisionShape2D.shape.height = 38
		$seeing/CollisionShape2D.shape.radius = 119
		$Label.position.y = -30
	elif type == "rainbow":
		speed = 100
		health = 40 * Global.difficulty
		bullet_time = 0.1
	elif type == "boss":
		speed = 10
		health = 300 * Global.difficulty
		bullet_time = 0.2
		$enemy_hurt/CollisionShape2D.shape.radius = 20
		$enemy_hurt/CollisionShape2D.shape.height = 125
		$CollisionShape2D.shape.radius = 20
		$CollisionShape2D.shape.height = 125
		$seeing/CollisionShape2D.shape.radius = 600
		$Label.position.y = -75
	else:
		printerr("you named the type wrong moron")
	determine_bullet()
	#bullets.trackedNode = player
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
		#$die.play()
		$hurt.stop()
		$Timer.stop()
		$BulletSpawnLoop.stop()
		$CollisionShape2D.disabled = true
		if type == "boss":
			$D.play("boss")
			if $laugh.playing == false:
				$laugh.play()
		else:
			$D.play("default")
			Global.enemy_kills += 1
	$Label.text = "Health: " + str(health)
	
	if Global.difficulty > pre_dif:
		health += Global.difficulty * 10
		pre_dif = Global.difficulty
	
	
	
	if bullets_fired > 99990:
		health = 0
	
	
	
	


func _on_area_2d_body_entered(body):
	if body == player.attacker:
		$hurt.play()
		health -= player.atk_damg
		player.attacker.position = Vector2(0, 0)


func _on_bullet_spawn_loop_timeout():
	bullets.set_manual_start(true)
	bullets_fired += (bullets.bulletsPerRadius * bullets.numberOfRadii)
	makepath()



func determine_bullet():
	var loaded_bullet
	loaded_bullet = load("res://scenes/bullets/" + type +  ".tscn")
	loaded_bullet = loaded_bullet.instantiate()
	loaded_bullet.trackedNode = player
	add_child(loaded_bullet)
	bullets = loaded_bullet

func _on_enemy_hurt_area_entered(area):
	if area == player.attacker:
		$hurt.play()
		health -= player.atk_damg
		player.attacker.position = Vector2(0, 0)



func _on_seeing_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body == player:
		player_spotted = true
		bullets.set_manual_start(true)
		bullets_fired += (bullets.bulletsPerRadius * bullets.numberOfRadii)
		$BulletSpawnLoop.start()
		$seeing.get_child(0).set_deferred("disabled", true) #= true
		if type == "boss":
			Global.boss_active = true
			Global.bgm = 2
			$AudioStreamPlayer2D.stop()


func _on_d_animation_finished():
	if type == "boss":
		Global.boss_active = false
	queue_free()


func _on_laugh_finished():
	$bossdie.play()
	Global.boss_active = false
