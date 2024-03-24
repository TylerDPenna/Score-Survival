extends Control



func _on_button_begin_pressed():
	if Global.weaponSelected:
		get_tree().change_scene_to_file("res://Scenes/Levels/BasicLevel.tscn")


func _on_rifle_selectbutton_pressed():
	Global.weaponSelected = true
	Global.weaponSelectedID = 0

func _on_shotgun_selectbutton_pressed():
	Global.weaponSelected = true
	Global.weaponSelectedID = 1

func _on_ray_gun_selectbutton_pressed():
	Global.weaponSelected = true
	Global.weaponSelectedID = 2

func _on_sword_selectbutton_pressed():
	Global.weaponSelected = true
	Global.weaponSelectedID = 3

func _on_gl_selectbutton_pressed():
	Global.weaponSelected = true
	Global.weaponSelectedID = 4

func _on_rl_selectbutton_pressed():
	Global.weaponSelected = true
	Global.weaponSelectedID = 5


func _on_minigun_selectbutton_pressed():
	Global.weaponSelected = true
	Global.weaponSelectedID = 6


func _on_flame_thrower_selectbutton_pressed():
	Global.weaponSelected = true
	Global.weaponSelectedID = 7
