extends CharacterBody2D

@export var speed = 200
@export var friction = 0.335
@export var acceleration = 0.175

var def_speed : int
var def_friction : float
var def_accel : float

var slow_switch = false

@export var item_a : int = 0
var pre_item_a : int
@export var item_b : int = 0
var pre_item_b : int
@export var item_c : int = 0
var pre_item_c : int

var shooting = false

func _ready():
	def_speed = speed
	def_friction = friction
	def_accel = acceleration
	pre_item_a = item_a
	pre_item_b = item_b
	pre_item_c = item_c

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
	
	
	if event.is_action_pressed("shoot"):
		shooting = true
	elif event.is_action_released("shoot"):
		shooting = false


func _process(delta):
	if slow_switch == true:
		Engine.time_scale = 0.25
	else:
		Engine.time_scale = 1
	
	
	if pre_item_a != item_a:
		speed = def_speed + (10 * item_a)
		pre_item_a = item_a
		print(speed)
	if pre_item_b != item_b:
		friction = def_friction + (0.01 * item_b)
		pre_item_b = item_b
		print(friction)
	if pre_item_c != item_c:
		acceleration = def_accel + (0.005 * item_c)
		pre_item_c = item_c
		print(acceleration)
