extends CharacterBody2D


@export var speed = 50

@export var player : Node2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta: float) -> void:
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	velocity = dir * speed
	move_and_slide()



func makepath() -> void:
	nav_agent.target_position = player.global_position



func _on_timer_timeout():
	makepath()
