extends CharacterBody2D

@export var type : String
var speed = 50
@export var health : int = 10
@export var bob = true
@export var player : Node2D
#@export var damager : Node2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
var screen_size = get_viewport_rect().size

func _physics_process(_delta: float) -> void:
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	velocity = dir * speed
	move_and_slide()



func makepath() -> void:
	nav_agent.target_position = player.global_position



func _on_timer_timeout():
	makepath()

func _ready():
	if type == "red":
		speed = 50
		health = 10
	var tween = create_tween()
	var sprite_pos = $Spellcaster
	if bob == true:
		tween.set_loops()
		tween.tween_property(sprite_pos, "position", Vector2(0, -5), 2)
		tween.tween_property(sprite_pos, "position", Vector2(0, 5), 2)


func _process(_delta):
	screen_size = get_viewport_rect().size
	if health <= 0:
		queue_free()
	$Label.text = "Health: " + str(health)
	
	
	


func _on_area_2d_body_entered(body):
	print("hehe enemy got hit")
