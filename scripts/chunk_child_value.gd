extends Node2D



var chunk : String


# Called when the node enters the scene tree for the first time.
func _ready():
	chunk = "res://scenes/" + str(get_parent().name) + "/" + str(self.name) + ".tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
