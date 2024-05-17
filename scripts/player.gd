extends CharacterBody2D

@onready var attacker = $Attacker
# https://uquiz.com/1AY4aI

@export var speed = 200
@export var friction = 0.335
@export var acceleration = 0.175
@export var atk_speed : float = 1
@export var atk_damg : float = 3
@export var atk_range : int = 1
@export var max_slow : float = 10
@export var slow_amt = 0.5
@export var lives : int = 3

var slow_charge : float = 0

var level_random : int = randi_range(0, 2)

var first_life = true

var def_speed : int
var def_friction : float
var def_accel : float
var def_atk_sp : float
var def_atk_dam : float
var def_atk_ran : int
var def_max_slow : float
var def_slow_amount : float
var def_lives : int

var can_lose_lives = true
var slow_switch = false

@export var red : int = 0
var pre_red : int = 0
@export var green : int = 0
var pre_green : int = 0
@export var yellow : int = 0
var pre_yellow : int = 0
@export var purple : int = 0
var pre_purple : int = 0
@export var orange : int = 0
var pre_orange : int = 0
@export var cyan : int = 0
var pre_cyan : int = 0
@export var white : int = 0
var pre_white : int = 0
@export var black : int = 0
var pre_black : int = 0
@export var rainbow : int = 0
var pre_rainbow : int = 0
@export var blue : int = 0
var pre_blue : int = 0
@export var portal : int = 0
var pre_portal : int = 0
@export var lalala : Label
var items : Array

var shooting = false

var pre_health : int

var item_list : Array

var item_total : int





func _ready():
	Global.dead = true
	Global.wins = 0
	#pre_health = Global.health
	item_total = red + green + yellow + purple + orange + cyan + white + black + rainbow + blue
	Global.health = item_total
	item_list = [red, green, yellow, purple, orange, cyan, white, black, rainbow, blue]
	def_speed = speed
	def_friction = friction
	def_accel = acceleration
	def_atk_sp = atk_speed
	def_atk_dam = atk_damg
	def_max_slow = max_slow
	def_slow_amount = slow_amt
	def_lives = lives
	def_atk_ran = atk_range
	Global.atk_range = atk_range
	#pre_red = red
	#pre_green = green
	#pre_yellow = yellow
	#pre_purple = purple
	#pre_orange = orange
	#pre_cyan = cyan
	#pre_white = white
	#pre_black = black
	#pre_rainbow = rainbow
	#pre_blue = blue
	#pre_portal = portal
	Global.def_wins = Global.wins
	slow_charge = 0.01
	match  Global.start_bonus:
		0:
			red += 1
		1:
			green += 1
		2:
			yellow += 1
		3:
			purple += 1
		4:
			orange += 1
		5:
			cyan += 1
		6:
			white += 1
		7:
			black += 1
		8:
			rainbow += 1
		9:
			blue += 1
	print("start bonus: " + str(Global.start_bonus))


func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input


func _physics_process(_delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()


func _input(event):
	if event.is_action_pressed("slow"):
		slow_switch = true
	elif event.is_action_released("slow"):
		slow_switch = false
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		$Camera2D/paused.visible = not $Camera2D/paused.visible
		$Camera2D/unpause.visible = not $Camera2D/unpause.visible

func _process(_delta):
	if Global.wins >= 1:
		global_position = Vector2(-200, -200)
		TransitionManager.change_scene("res://scenes/win.tscn", TransitionManager.TransitionType.FallDown)
	#var random_item : int
	#item_list = red, blue, green
	item_total = red + green + yellow + purple + orange + cyan + white + black + rainbow + blue
	
	Global.atk_range = atk_range
	if lives <= 0:
		Global.save_ach()
		$crack.stop()
		$orb.hide()
		$life_left.stop()
		Global.dead = true
		$shatter.play()
		print("gmae over D:")
		OS.delay_msec(500)
		global_position = Vector2(-200, -200)
		TransitionManager.change_scene("res://scenes/lose.tscn", TransitionManager.TransitionType.FallDown)
	
	
	
	
	if Global.health == 0:
		if can_lose_lives == true:
			$Timer.start()
			can_lose_lives = false
			goddamn_it(-1, false)
			OS.delay_msec(50)
			$crack.stop()
			if first_life == true:
				pass
			elif first_life == false:
				$life_left.play()
			lives -= 1
			first_life = false
			print(lives)
	
	stat_window_update()
	
	if slow_switch == true:
		if slow_charge > 0:
			Engine.time_scale = slow_amt
			slow_charge = slow_charge - 0.025
		elif slow_charge <= 0:
			slow_switch = false
	elif slow_switch == false:
		Engine.time_scale = 1
		if slow_charge < max_slow:
			slow_charge = slow_charge + (max_slow / 1000)
	
	if pre_health > Global.health:
		goddamn_it(pre_health - Global.health, true)
		$crack.play()
		pre_health = Global.health
	
	if Global.health < item_total:
		Global.health = item_total
		pre_health = Global.health
	
	
	
	if red >= 15:
		Global.red_bonus = true
		$achievement.play()
	if green >= 15:
		Global.green_bonus = true
		$achievement.play()
	if yellow >= 15:
		Global.yellow_bonus = true
		$achievement.play()
	if purple >= 15:
		Global.purple_bonus = true
		$achievement.play()
	if orange >= 15:
		Global.orange_bonus = true
		$achievement.play()
	if cyan >= 15:
		Global.cyan_bonus = true
		$achievement.play()
	if white >= 15:
		Global.white_bonus = true
		$achievement.play()
	if black >= 15:
		Global.black_bonus = true
		$achievement.play()
	if rainbow >= 15:
		Global.rainbow_bonus = true
		$achievement.play()
	if blue >= 15:
		Global.blue_bonus = true
		$achievement.play()
	
	if red < 0:
		if Global.health > 1:
			red = 0
			goddamn_it(1, false)
	
	if green < 0:
		if Global.health > 1:
			green = 0
			goddamn_it(1, false)
	
	if yellow < 0:
		if Global.health > 1:
			yellow = 0
			goddamn_it(1, false)
	
	if purple < 0:
		if Global.health > 1:
			purple = 0
			goddamn_it(1, false)
	
	if orange < 0:
		if Global.health > 1:
			orange = 0
			goddamn_it(1, false)
	
	if cyan < 0:
		if Global.health > 1:
			cyan = 0
			goddamn_it(1, false)
	
	if white < 0:
		if Global.health > 1:
			white = 0
			goddamn_it(1, false)
	
	if black < 0:
		if Global.health > 1:
			black = 0
			goddamn_it(1, false)
	
	if rainbow < 0:
		if Global.health > 1:
			rainbow = 0
			goddamn_it(1, false)
	
	if blue < 0:
		if Global.health > 1:
			blue = 0
			goddamn_it(1, false)
	
	if red > pre_red:
		$pickup.play()
	if green > pre_green:
		$pickup.play()
	if yellow > pre_yellow:
		$pickup.play()
	if purple > pre_purple:
		$pickup.play()
	if orange > pre_orange:
		$pickup.play()
	if cyan > pre_cyan:
		$pickup.play()
	if white > pre_white:
		$pickup.play()
	if black > pre_black:
		$pickup.play()
	if rainbow > pre_rainbow:
		$pickup.play()
	if blue > pre_blue:
		$pickup.play()
	
	if pre_red != red:
		speed = def_speed + (10 * red)
		pre_red = red
	if pre_green != green:
		friction = def_friction + (0.01 * green)
		pre_green = green
	if pre_yellow != yellow:
		acceleration = def_accel + (0.005 * yellow)
		pre_yellow= yellow
	if pre_purple != purple:
		atk_speed = def_atk_sp + (0.5 * purple)
		pre_purple = purple
	if pre_orange != orange:
		atk_damg = def_atk_dam + (1 * orange)
		pre_orange = orange
	if pre_cyan != cyan:
		atk_range = def_atk_ran + (1 * cyan)
		pre_cyan = cyan
	if pre_white != white:
		max_slow = def_max_slow + (1 * white)
		pre_white = white
	if pre_black != black:
		slow_amt = clamp(def_slow_amount + (0.01 * -black), 0.01, 1)
		pre_black = black
	if pre_rainbow != rainbow:
		speed = def_speed + (1 * rainbow)
		friction = def_friction + (0.002 * rainbow)
		acceleration = def_accel + (0.001 * rainbow)
		atk_speed = def_atk_sp + (0.1 * rainbow)
		atk_damg = def_atk_dam + (0.2 * rainbow)
		max_slow = def_max_slow + (0.1 * rainbow)
		slow_amt = clamp(def_slow_amount + (0.001 * -rainbow), 0, 1)
		pre_rainbow = rainbow
	if pre_blue != blue:
		lives = clamp(def_lives + (1 * blue), 1, 999)
		pre_blue = blue
	if pre_portal != portal:
		$portal.play()
		Global.wins = Global.def_wins + (1 * portal)
		pre_portal = portal
		print(Global.wins)




func goddamn_it(loss : int, allow_blue : bool):
	var random = randi_range(0, 9)
	match random:
		0:
			red -= loss
		1:
			green -= loss
		2:
			yellow -= loss
		3:
			purple -= loss
		4:
			orange -= loss
		5:
			cyan -= loss
		6:
			white -= loss
		7:
			black -= loss
		8:
			rainbow -= loss
		9:
			if allow_blue == true:
				blue -= loss
			else:
				goddamn_it(loss, false)





func stat_window_update():
	lalala.text = "speed: " + str(speed) + "
	friction: " + str(friction) + "
	acceleration: " + str(acceleration) + "
	attack speed: " + str(atk_speed) + "
	attack damage: " + str(atk_damg) + "
	attack range: " + str(atk_range) + "
	max meter: " + str(max_slow) + "
	slow amount: " + str(slow_amt) + "
	lives: " + str(lives) + "
	health: " + str(Global.health)


func _on_timer_timeout():
	can_lose_lives = true




func _on_video_stream_player_finished():
	Global.dead = false
	$VideoStreamPlayer.queue_free()


func _on_unpause_pressed():
	get_tree().paused = not get_tree().paused
	$Camera2D/paused.visible = not $Camera2D/paused.visible
	$Camera2D/unpause.visible = not $Camera2D/unpause.visible



