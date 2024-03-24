extends CharacterBody2D

var gravity = 250
var speed = 250
var inWall = false
var bounceHeight = 100
var spawnVelocity


func _ready():
	spawnVelocity = Global.mousePos.normalized() * 250
	velocity = spawnVelocity

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		velocity.y -= bounceHeight
	
	if is_on_wall() or is_on_ceiling():
		inWall = true
		speed = 0
		$CPUParticles2D.emitting = false
	
	if not inWall:
		$Area2D/CollisionShape2D/Sprite2D.rotation += velocity.normalized().x / 3
		move_and_slide()
	

func _on_timer_timeout():
	queue_free()
