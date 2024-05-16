extends OptionButton





# Called when the node enters the scene tree for the first time.
func _ready():
	add_item("red")
	add_item("green")
	add_item("yellow")
	add_item("purple")
	add_item("orange")
	add_item("cyan")
	add_item("white")
	add_item("black")
	add_item("rainbow")
	add_item("blue")
	set_item_disabled(0, not Global.red_bonus)
	set_item_disabled(1, not Global.green_bonus)
	set_item_disabled(2, not Global.yellow_bonus)
	set_item_disabled(3, not Global.purple_bonus)
	set_item_disabled(4, not Global.orange_bonus)
	set_item_disabled(5, not Global.cyan_bonus)
	set_item_disabled(6, not Global.white_bonus)
	set_item_disabled(7, not Global.black_bonus)
	set_item_disabled(8, not Global.rainbow_bonus)
	set_item_disabled(9, not Global.blue_bonus)







func _on_item_selected(index):
	Global.start_bonus = index
