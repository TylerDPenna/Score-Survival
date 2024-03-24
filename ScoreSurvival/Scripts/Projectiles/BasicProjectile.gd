extends Node2D

var speed = 750
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	position += transform.x * speed * delta
	$Timer.start()

func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	queue_free()


func _on_area_2d_area_entered(area):
	queue_free()
