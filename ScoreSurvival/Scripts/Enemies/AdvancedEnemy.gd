extends CharacterBody2D

var dead = false
var Jumping = false
var Speed = randf_range(30, 50)
var Jump_Velocity = randf_range(-250.0, -350)
var ScoreRandomness = 5

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var navAgent = $NavigationAgent2D

func _physics_process(delta):
	navAgent.target_position = Global.PlayerPosition
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var nextPathPosition = navAgent.get_next_path_position()
	var direction = global_position.direction_to(nextPathPosition)
	
	if nextPathPosition.y - 10 < position.y:
		if $FloorDetection.is_colliding() and not Jumping and $JumpTimer.get_time_left() <= 0:
			Jumping = true
			$JumpTimer.start()
			var Jump_Velocity = randf_range(-250.0, -350)
			velocity.y = Jump_Velocity
	
	if is_on_floor():
		Jumping = false
	
	velocity.x = direction.x * Speed
	if not dead:
		move_and_slide()


func _on_damage_area_area_entered(area):
	if not dead:
		Global.score += randi_range(10 + ScoreRandomness, 10 - ScoreRandomness)
		var dead = true
		$FloorCollsions.queue_free()
		$DamageArea/CollisionShape2D.queue_free()
		$DamageArea.queue_free()
		$CPUParticles2D.emitting = true
		$CPUParticles2D2.emitting = true
		$Sprite2D.visible = false


func _on_cpu_particles_2d_2_finished():
	queue_free()


func _on_jump_timer_timeout():
	Jumping = false
