extends Node2D

var waitTime = randf_range(1, 20)
var spriteMovingUp = true
var speed = 0.1
func _ready():
	$Area2D/CollisionShape2D.disabled = true
	$Sprite/HealthPack.visible = false
	$Timer.set_wait_time(waitTime)
	$Sprite/CPUParticles2D.emitting = false


func _physics_process(delta):
	if $Sprite/HealthPack.global_position.y < $TopMarker.global_position.y:
		spriteMovingUp = false
	if $Sprite/HealthPack.global_position.y > $BottomMarker.global_position.y:
		spriteMovingUp = true
	
	
	if spriteMovingUp == true:
		$Sprite/HealthPack.position.y -= speed
	else:
		$Sprite/HealthPack.position.y += speed

func _on_timer_timeout():
	$Area2D/CollisionShape2D.disabled = false
	$Sprite/HealthPack.visible = true
	$Sprite/CPUParticles2D.emitting = true


func _on_area_2d_area_entered(area):
	$Area2D/CollisionShape2D.disabled = true
	$Sprite/HealthPack.visible = false
	$Sprite/CPUParticles2D.emitting = false
	Global.PlayerHP = clamp(Global.PlayerHP + 10, 0, Global.MaxPlayerHP)
	
	waitTime = randf_range(1, 20)
	$Timer.set_wait_time(waitTime)
	
	$Timer.start()
