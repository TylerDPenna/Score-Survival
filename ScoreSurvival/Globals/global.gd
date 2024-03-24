extends Node


var mousePos:Vector2 = Vector2(0, 0)
var weaponSelected = false
var weaponSelectedID = 0
var paused = false

var score = 0
var Highscore = 0

var BulletType = 0
var BulletDamage = 0
var EnemyContactDamage = 0

var PlayerPosition:Vector2 = Vector2(0, 0)
var PlayerHP:float 
var MaxPlayerHP:float 
