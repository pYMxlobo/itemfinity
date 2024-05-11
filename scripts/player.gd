extends CharacterBody2D

@export var speed = 200
@export var friction = 0.335
@export var acceleration = 0.175
@export var atk_speed : float = 1
@export var atk_damg : float = 3
@export var max_slow : float = 10
@export var slow_amt = 0.5
@export var orbiting : int = 0
@export var lives : int = 1

var slow_charge : float = 0

var def_speed : int
var def_friction : float
var def_accel : float
var def_atk_sp : float
var def_atk_dam : float
var def_max_slow : float
var def_slow_amount : float
var def_orbiting : int
var def_lives : int


var slow_switch = false

@export var red : int = 0
var pre_red : int
@export var green : int = 0
var pre_green : int
@export var yellow : int = 0
var pre_yellow : int
@export var purple : int = 0
var pre_purple : int
@export var orange : int = 0
var pre_orange : int
@export var cyan : int = 0
var pre_cyan : int
@export var white : int = 0
var pre_white : int
@export var black : int = 0
var pre_black : int
@export var rainbow : int = 0
var pre_rainbow : int
@export var blue : int = 0
var pre_blue : int
@export var portal : int = 0
var pre_portal : int

var items : Array

var shooting = false

var pre_health : int

var item_list : Array

var item_total : int
func _ready():
	randomize()
	pre_health = Global.health
	item_list = [red, green, yellow, purple, orange, cyan, white, black, rainbow, blue]
	def_speed = speed
	def_friction = friction
	def_accel = acceleration
	def_atk_sp = atk_speed
	def_atk_dam = atk_damg
	def_max_slow = max_slow
	def_slow_amount = slow_amt
	def_orbiting = orbiting
	def_lives = lives
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


func _physics_process(delta):
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
	
	
	if event.is_action_pressed("shooting"):
		shooting = true
		Global.health = Global.health - 1
		print(Global.health)
	elif event.is_action_released("shooting"):
		shooting = false


func _process(delta):
	var random_item : int
	#item_list = red, blue, green
	item_total = red + green + yellow + purple + orange + cyan + white + black + rainbow + blue
	
	if lives == 0:
		print("gmae over D:")
	
	
	
	
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
		random_item = item_list.pick_random()
		while random_item == 0:
			random_item = item_list.pick_random()
		if random_item == 0:
			lives - 1
		random_item -= 1
		pre_health = Global.health
		print( "random item :" + str(random_item))
	
	if pre_red != red:
		speed = def_speed + (10 * red)
		pre_red = red
		print(speed)
	if pre_green != green:
		friction = def_friction + (0.01 * green)
		pre_green = green
		print(friction)
	if pre_yellow != yellow:
		acceleration = def_accel + (0.005 * yellow)
		pre_yellow= yellow
		print(acceleration)
	if pre_purple != purple:
		atk_speed = def_atk_sp + (0.5 * purple)
		pre_purple = purple
		print(atk_speed)
	if pre_orange != orange:
		atk_damg = def_atk_dam + (1 * orange)
		pre_orange = orange
		print(atk_damg)
	if pre_cyan != cyan:
		orbiting = def_orbiting + (1 * cyan)
		pre_cyan = cyan
		print(orbiting)
	if pre_white != white:
		max_slow = def_max_slow + (1 * white)
		pre_white = white
		print(max_slow)
	if pre_black != black:
		slow_amt = def_slow_amount + (0.01 * -black)
		pre_black = black
		print(slow_amt)
	if pre_rainbow != rainbow:
		speed = def_speed + (1 * rainbow)
		friction = def_friction + (0.002 * rainbow)
		acceleration = def_accel + (0.001 * rainbow)
		atk_speed = def_atk_sp + (0.1 * rainbow)
		atk_damg = def_atk_dam + (0.2 * rainbow)
		max_slow = def_max_slow + (0.1 * rainbow)
		slow_amt = def_slow_amount + (0.001 * -rainbow)
		pre_rainbow = rainbow
	if pre_blue != blue:
		lives = def_lives + (1 * blue)
		pre_blue = blue
		print(lives)
	if pre_portal != portal:
		Global.wins = Global.def_wins + (1 * portal)
		pre_portal = portal
		print(Global.wins)
