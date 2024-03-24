extends CharacterBody2D


const Movement_Speed = 300.0
const Jump_Velocity = -400.0

var MaxHealth = 25
var Health = 25

var canJump = true
var reloading = false
var canFire = true

var Max_Ammo_Count = 30
var Ammo_Count = 0
var Reload_Time = 10
var Fire_Rate = 2
var BulletNumber = 1
var BulletSpread = 0
var Recoil = 0
var WeaponOffsetX = 0
var WeaponOffsetY = 0

var VelocityBeforeRecoil:Vector2 = Vector2(0, 0)

var diff = Vector2(0, 0)

var BasicProjectile = preload("res://Scenes/Projectiles/BasicProjectile.tscn")
var RayProjectile = preload("res://Scenes/Projectiles/RayProjectile.tscn")
var SwordProjectile = preload("res://Scenes/Projectiles/SwordProjectile.tscn")
var GrenadeProjectile = preload("res://Scenes/Projectiles/GrenadeProjectile.tscn")
var RocketProjectile = preload("res://Scenes/Projectiles/RocketProjectile.tscn")
var FlameProjectile = preload("res://Scenes/Projectiles/FlameProjectile.tscn")

var BulletSpawn

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var SelectedWeapon = $WeaponSprites/Riflesprite

 

func _ready():
	
	$WeaponSprites/Riflesprite.visible = false
	$WeaponSprites/Shotgunsprite.visible = false
	$WeaponSprites/RayGunsprite.visible = false
	$WeaponSprites/Swordsprite.visible = false
	$WeaponSprites/GrenadeLaunchersprite.visible = false
	$WeaponSprites/RocketLaunchersprite.visible = false
	$WeaponSprites/Minigunsprite.visible = false
	$WeaponSprites/FlameThrowersprite.visible = false
	
	Global.PlayerHP = Health
	
	Global.MaxPlayerHP = MaxHealth
	
	if Global.weaponSelectedID == 0:
		
		#Rifle
		SelectedWeapon = $WeaponSprites/Riflesprite
		
		Max_Ammo_Count = 20
		Reload_Time = 2
		Fire_Rate = 0.1
		BulletNumber = 1
		BulletSpread = 0.05
		Recoil = 10
		Global.BulletType = 0 #Normal
		

	elif Global.weaponSelectedID == 1:
		
		#Shotgun
		SelectedWeapon = $WeaponSprites/Shotgunsprite
		
		Max_Ammo_Count = 24
		Reload_Time = 0.7
		Fire_Rate = 1
		BulletNumber = 6
		BulletSpread = 0.1
		Recoil = 300
		Global.BulletType = 0 #Normal
		

	elif Global.weaponSelectedID == 2:
		
		#RayGun
		SelectedWeapon = $WeaponSprites/RayGunsprite
		
		Max_Ammo_Count = 5
		Reload_Time = 3
		Fire_Rate = 1
		BulletNumber = 1
		BulletSpread = 0
		Recoil = 0
		Global.BulletType = 1 #Rays
		

	elif Global.weaponSelectedID == 3:
		
		#Sword
		SelectedWeapon = $WeaponSprites/Swordsprite
		
		Max_Ammo_Count = 1
		Reload_Time = 2
		Fire_Rate = 1
		BulletNumber = 1
		BulletSpread = 0.1
		Recoil = 0
		Global.BulletType = 2 #Sword
		
	
	elif Global.weaponSelectedID == 4:
		
		#Grenade Launcher
		SelectedWeapon = $WeaponSprites/GrenadeLaunchersprite
		
		Max_Ammo_Count = 8
		Reload_Time = 5
		Fire_Rate = 1
		BulletNumber = 1
		BulletSpread = 2
		Recoil = 5
		Global.BulletType = 3 #Grenade
		
	
	elif Global.weaponSelectedID == 5:
		
		#RPG
		SelectedWeapon = $WeaponSprites/RocketLaunchersprite
		
		Max_Ammo_Count = 1
		Reload_Time = 3
		Fire_Rate = 150
		BulletNumber = 1
		BulletSpread = 0
		Recoil = 450
		Global.BulletType = 4 #Rocket
		
	
	elif Global.weaponSelectedID == 6:
		
		#MiniGun
		SelectedWeapon = $WeaponSprites/Minigunsprite
		
		Max_Ammo_Count = 250
		Reload_Time = 5
		Fire_Rate = 0.01
		BulletNumber = 1
		BulletSpread = 0.5
		Recoil = 25
		Global.BulletType = 0 #Normal
		
	elif Global.weaponSelectedID == 7:
		
		#FlameThrower
		SelectedWeapon = $WeaponSprites/FlameThrowersprite
		
		Max_Ammo_Count = 10
		Reload_Time = 5
		Fire_Rate = 0.1
		BulletNumber = 1
		BulletSpread = 100
		Recoil = 0
		Global.BulletType = 5 #Normal
		
	
	SelectedWeapon.visible = true
	
	Ammo_Count = Max_Ammo_Count

func _physics_process(delta):

	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	if not is_on_floor():
		velocity.y += gravity * delta
	
	$CanvasLayer/HealthBar.value = Global.PlayerHP
	
	if Health <= 0:
		get_tree().change_scene_to_file("res://Scenes/Levels/Menu.tscn")
	
	if Input.is_action_just_pressed("Jump") and canJump:
		velocity.y = Jump_Velocity

	if is_on_floor():
		canJump = true
		$JumpBuffer.start()

	if Input.is_action_pressed("Right"):
		velocity.x = Movement_Speed
	elif Input.is_action_pressed("Left"):
		velocity.x = Movement_Speed * -1
	else:
		if is_on_floor():
			velocity.x = velocity.x * 0.6
		if not is_on_floor():
			velocity.x = velocity.x * 0.95
	
	$WeaponSprites.look_at(get_global_mouse_position())
	
	if get_local_mouse_position().x < 0:
		BulletSpawn = $WeaponSprites/BulletSpawns/BulletSpawnR
		
		SelectedWeapon.flip_v = true
		$WeaponSprites/Minigunsprite.offset.y = -2
	
	else:
		BulletSpawn = $WeaponSprites/BulletSpawns/BulletSpawnL
		SelectedWeapon.flip_v = false
		$WeaponSprites/Minigunsprite.offset.y = 2
	
	$CanvasLayer/ScoreLabel.text = "Score: " + str(Global.score)
	$CanvasLayer/AmmoCount.text = "Ammo: " + str(Ammo_Count) + "/" + str(Max_Ammo_Count)
	
	Global.PlayerPosition = get_position()
	Health = Global.PlayerHP
	
	$Reticle.position = get_local_mouse_position()
	
	if not reloading and Ammo_Count <= 0:
		reload()

	if Input.is_action_pressed("Shoot"):
		shoot()
	
	if Input.is_action_just_pressed("Menu"):
		Global.score = 0
		get_tree().change_scene_to_file("res://Scenes/Levels/Menu.tscn")
	
	Global.mousePos = get_local_mouse_position()
	move_and_slide()


func shoot():
	var SavedBulletNumber = BulletNumber
	if not reloading and canFire:
		if Ammo_Count > 0:
			while BulletNumber != 0:
				if Global.BulletType == 0:
					var bullet = BasicProjectile.instantiate()
					owner.add_child(bullet)
					bullet.transform = BulletSpawn.global_transform
					bullet.rotation = BulletSpawn.global_rotation + randf_range(-BulletSpread, BulletSpread)
				if Global.BulletType == 1:
					var bullet = RayProjectile.instantiate()
					owner.add_child(bullet)
					bullet.transform = BulletSpawn.global_transform
					bullet.rotation = BulletSpawn.global_rotation + randf_range(-BulletSpread, BulletSpread)
				if Global.BulletType == 2:
					var bullet = SwordProjectile.instantiate()
					owner.add_child(bullet)
					bullet.transform = BulletSpawn.global_transform
					bullet.rotation = BulletSpawn.global_rotation + randf_range(-BulletSpread, BulletSpread)
				if Global.BulletType == 3:
					var bullet = GrenadeProjectile.instantiate()
					owner.add_child(bullet)
					bullet.position = BulletSpawn.global_position
				if Global.BulletType == 4:
					var bullet = RocketProjectile.instantiate()
					owner.add_child(bullet)
					bullet.position = BulletSpawn.global_position
				if Global.BulletType == 5:
					var bullet = FlameProjectile.instantiate()
					owner.add_child(bullet)
					bullet.position = BulletSpawn.global_position
				BulletNumber -= 1
				Ammo_Count -= 1
				$WeaponSprites/Swordsprite.visible = false
			BulletNumber = SavedBulletNumber
			
			
			diff = get_local_mouse_position().normalized()
			diff = diff * -1
			
			VelocityBeforeRecoil = velocity
			velocity = velocity + diff * Recoil
				
				
			$FireRateTimer.set_wait_time(Fire_Rate)
			$FireRateTimer.start()
			canFire = false
		else:
			pass
		


func reload():
	reloading = true
	$ReloadTimer.set_wait_time(Reload_Time)
	$ReloadTimer.start()

func _on_reload_timer_timeout():
	if Global.weaponSelectedID == 3:
		$WeaponSprites/Swordsprite.visible = true
	Ammo_Count = Max_Ammo_Count
	reloading = false
	canFire = true
	$ReloadTimer.stop()

func _on_fire_rate_timer_timeout():
	canFire = true

func _on_jump_buffer_timeout():
	canJump = false


func _on_damage_area_area_entered(area):
	Global.PlayerHP -= 1
