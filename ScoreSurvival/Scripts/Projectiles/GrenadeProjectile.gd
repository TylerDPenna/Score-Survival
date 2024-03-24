extends CharacterBody2D

var gravity = 250
var speed = 250
var bounceHeight = 100
var spawnVelocity
var Velocity:Vector2
var exploding = false


func _ready():
	spawnVelocity = Global.mousePos.normalized() * 250
	velocity = spawnVelocity

func _physics_process(delta):
	
	if velocity.x < 0:
		$WallCheck.target_position.x = -4
	else:
		$WallCheck.target_position.x = 4
	
	if $FloorCheck.is_colliding():
		velocity.y = bounceHeight
		velocity.x = velocity.x * 0.9
	else:
		Velocity.y = velocity.y
		velocity.y += gravity * delta
		bounceHeight = Velocity.y * -0.5
	
	if velocity.x != 0:
		$Sprite2D.rotation += velocity.normalized().x / 4
	
	if $WallCheck.is_colliding():
		velocity.x = -Velocity.x * 0.5
		
	else:
		Velocity.x = velocity.x
	if not exploding:
		move_and_slide()



func _on_explosion_timer_timeout():
	exploding = true
	velocity = Vector2(0, 0)
	$Sprite2D.visible = false
	$ExplosionParticles/RedExplosionParticle.emitting = true
	$ExplosionParticles/YellowExplosionParticle.emitting = true
	$ExplosionParticles/GreenExplosionParticle.emitting = true
	$ExplosionParticles/GreyExplosionParticle.emitting = true
	$ExplosionShape/CollisionShape2D.disabled = false

func _on_cpu_particles_2d_2_finished():
	queue_free()
