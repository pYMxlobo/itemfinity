extends Node2D

var number : int = int(str(self.name))
@export var autoload_chunk = true



# Called when the node enters the scene tree for the first time.
func load_chunk():
	
	if get_parent().random == number:
		show()
		#print("number: " + str(number) + "parent name: "+ str(get_parent().name))
		#pass
	else:
		#print("chunk numer: "+str(number))
		#print("parent random: " + str(get_parent().random))
		queue_free()
	#print("number " + str(number) + " of " + str(get_parent().name) + " successful load call")

func _ready():
	#print("number " + str(number) + " of " + str(get_parent().name) + " successful ready")
	#please(100)
	await get_parent().ready
	if autoload_chunk == true:
		load_chunk()


