extends Node2D


func _ready():
	$EnemyNav/Obstacles/CollisionShape2D.disabled = true
	$EnemyNav/Obstacles/CollisionShape2D2.disabled = true
	$EnemyNav/Obstacles/CollisionShape2D3.disabled = true
