extends CharacterBody2D

var gravity = 250
var speed = 250
var spawnVelocity

func _ready():
	spawnVelocity = Global.mousePos.normalized() * 250
	velocity = spawnVelocity

func _physics_process(delta):
	if is_on_floor():
		velocity.x *= 0.5
	
	velocity.y += gravity * delta / 2
	
	
	move_and_slide()


func _on_timer_timeout():
	queue_free()
