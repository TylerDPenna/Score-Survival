extends Node2D

var Enemy = preload("res://Scenes/Enemies/BasicEnemy.tscn")


func _on_timer_timeout():
	$Timer.set_wait_time(randf_range(1, 10))
	var EnemyRandomness = 3
	while randf_range(EnemyRandomness * 0, EnemyRandomness + 3) > 0:
		var enemy = Enemy.instantiate()
		owner.add_child(enemy)
		enemy.position = get_position() + Vector2(randf_range(-20, 20), randf_range(-20, 20))
		EnemyRandomness -= 1
		await 4
	$Timer.start()
	pass
