extends CharacterBody2D


var dead = false
var Speed = randf_range(20, 70)
var ScoreRandomness = 5

@onready var navAgent = $NavigationAgent2D

func _physics_process(delta):
	navAgent.target_position = Global.PlayerPosition
	
	var nextPathPosition = navAgent.get_next_path_position()
	var direction = global_position.direction_to(nextPathPosition)
	velocity = direction * Speed
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
