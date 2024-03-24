extends Control

var savePath = "user://SSHighScore.save"

func _ready():
	
	loadData()
	saveData()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Global.score > Global.Highscore:
		Global.Highscore = Global.score

func _process(delta):
	$HighScoreLabel.text = "HighScore: " + str(Global.Highscore)

func _on_button_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/WeaponSelect.tscn")
	Global.score = 0


func _on_button_exit_pressed():
	saveData()
	get_tree().quit()

func saveData():
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(Global.Highscore)
	file.store_var(Global.weaponSelected)
	file.store_var(Global.weaponSelectedID)
	

func loadData():
	if FileAccess.file_exists(savePath):
		var file = FileAccess.open(savePath, FileAccess.READ)
		Global.Highscore = file.get_var(Global.Highscore)
		Global.weaponSelected = file.get_var(Global.weaponSelected)
		Global.weaponSelectedID = file.get_var(Global.weaponSelectedID)
	else:
		Global.Highscore = 0
		Global.weaponSelected = false
		Global.weaponSelectedID = 0


func _on_button_clear_save_pressed():
	Global.Highscore = 0
	Global.weaponSelected = false
	Global.weaponSelectedID = 0
	saveData()
	loadData()
