extends Node2D


@export var player : CharacterBody2D
@export var is_random = false
@export var value = 0

var random : int

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if is_random == true:
		value = randi_range(0, 9)
	
	if value == 0:
		$T.play("red")
	elif value == 1:
		$T.play("green")
	elif value == 2:
		$T.play("yellow")
	elif value == 3:
		$T.play("purple")
	elif value == 4:
		$T.play("orange")
	elif value == 5:
		$T.play("cyan")
	elif value == 6:
		$T.play("white")
	elif value == 7:
		$T.play("black")
	elif value == 8:
		$T.play("rainbow")
	elif value == 9:
		$T.play("blue")
	elif value == 10:
		$T.play("portal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_entered(body):
	if body == player:
		if value == 0:
			player.red = player.red + 1
			queue_free()
		elif value == 1:
			player.green = player.green + 1
			queue_free()
		elif value == 2:
			player.yellow = player.yellow + 1
			queue_free()
		elif value == 3:
			player.purple = player.purple + 1
			queue_free()
		elif value == 4:
			player.orange = player.orange + 1
			queue_free()
		elif value == 5:
			player.cyan = player.cyan + 1
			queue_free()
		elif value == 6:
			player.white = player.white + 1
			queue_free()
		elif value == 7:
			player.black = player.black + 1
			queue_free()
		elif value == 8:
			player.rainbow = player.rainbow + 1
			queue_free()
		elif value == 9:
			player.blue = player.blue + 1
			queue_free()
		elif value == 10:
			Global.wins = Global.wins + 1
			queue_free()

