extends CharacterBody2D

var gravity = 250
var speed = 250
var bounceHeight = 100
var spawnVelocity
var Velocity:Vector2
var exploding = false

func _ready():
	#spawnVelocity = Global.mousePos.normalized() * 250
	#velocity = spawnVelocity
	pass

func _physics_process(delta):
	
	velocity = velocity + get_local_mouse_position().normalized() * Vector2(10, 10)
	
	$Rotation.rotation = get_local_mouse_position().angle()
	$CollisionShape2D.rotation = get_local_mouse_position().angle()
	if not exploding:
		move_and_slide()

func explode():
	exploding = true
	velocity = Vector2(0, 0)
	$Rotation/Sprite2D.visible = false
	$ExplosionParticles/RedExplosionParticle.emitting = true
	$ExplosionParticles/YellowExplosionParticle.emitting = true
	$ExplosionParticles/GreenExplosionParticle.emitting = true
	$ExplosionParticles/GreyExplosionParticle.emitting = true
	$ExplosionRadius/CollisionShape2D.disabled = false
	$Rotation/CPUParticles2D.emitting = false

func _on_cpu_particles_2d_2_finished():
	queue_free()

func _on_explosion_detection_area_entered(area):
	$ExplosionTimer.start()

func _on_explosion_detection_body_entered(body):
	$ExplosionTimer.start()

func _on_grey_explosion_particle_finished():
	queue_free()

func _on_explosion_timer_timeout():
	explode()
