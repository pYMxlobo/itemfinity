extends Node2D


@export var player : CharacterBody2D
@onready var max_vari: int = get_child_count()
var random: int



func _ready():
	#max_vari = get_child_count()
	#print("max_vari:" + str(max_vari))
	random = randi_range(0, max_vari)
	
	


func load_random():
	var loaded_chunk = get_child(random).chunk
	add_child(loaded_chunk)
