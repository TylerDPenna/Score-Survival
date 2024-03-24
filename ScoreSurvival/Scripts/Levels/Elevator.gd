extends CharacterBody2D

@export var topTarget:Marker2D
@export var bottomTarget:Marker2D

var movingUp = false

var speed = 5


func _physics_process(delta):
	
	
	
	if global_position.y < topTarget.global_position.y:
		movingUp = false
	if global_position.y > bottomTarget.global_position.y:
		movingUp = true
	
	
	if movingUp == true:
		position.y -= speed
	else:
		position.y += speed
	
	
	move_and_slide()
