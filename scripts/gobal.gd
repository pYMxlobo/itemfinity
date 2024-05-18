extends Node

var difficulty = 1

var wins = 0
var def_wins : int

var health : int

var dead = false

var atk_range = 1

var delayed_linear_velocity : Vector2

var start_bonus = 0

var red_bonus = true

var green_bonus = false

var yellow_bonus = false

var purple_bonus = false

var orange_bonus = false

var cyan_bonus = false

var white_bonus = false

var black_bonus = false

var rainbow_bonus = false

var blue_bonus = false




func save_ach():
	var file = FileAccess.open("user://achievements.save", FileAccess.WRITE)
	file.store_var(red_bonus)
	file.store_var(green_bonus)
	file.store_var(yellow_bonus)
	file.store_var(purple_bonus)
	file.store_var(orange_bonus)
	file.store_var(cyan_bonus)
	file.store_var(white_bonus)
	file.store_var(black_bonus)
	file.store_var(rainbow_bonus)
	file.store_var(blue_bonus)
	print("saved :D")


func load_ach():
	if FileAccess.file_exists("user://achievements.save"):
		var file = FileAccess.open("user://achievements.save", FileAccess.READ)
		if file.get_length() > 0:
			red_bonus = file.get_var(red_bonus)
			green_bonus = file.get_var(green_bonus)
			yellow_bonus = file.get_var(yellow_bonus)
			purple_bonus = file.get_var(purple_bonus)
			orange_bonus = file.get_var(orange_bonus)
			cyan_bonus = file.get_var(cyan_bonus)
			white_bonus = file.get_var(white_bonus)
			black_bonus = file.get_var(black_bonus)
			rainbow_bonus = file.get_var(rainbow_bonus)
			blue_bonus = file.get_var(blue_bonus)
		else:
			print("oopsie! no data D:")
			red_bonus = true
			save_ach()
	else:
		print("oopsie! no save D:")
		red_bonus = true
		save_ach()
