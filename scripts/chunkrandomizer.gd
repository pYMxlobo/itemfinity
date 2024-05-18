extends Node2D


@export var player : CharacterBody2D
@onready var max_vari: int = get_child_count()
var random: int
# Called when the node enters the scene tree for the first time.




func _ready():
	#max_vari = get_child_count()
	#print("max_vari:" + str(max_vari))
	random = randi_range(1, max_vari)



func load_activated(body):
	if body == player:
		for i in max_vari:
			get_child(i).load_chunk()
