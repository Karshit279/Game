extends KinematicBody2D

var moveSpeed = 500;
export (PackedScene) var Bullet
export (PackedScene) var Enemy
export (PackedScene) var Enemy1
var x = 0
var e = 0
var e2 = 0
var BulletSpawnSpeedInverse = 1
var Enemy1SpawnSpeedInverse = 20
var Enemy2SpawnSpeedInverse = 1
var bulletRecoilTimer
var RNG = RandomNumberGenerator.new()

var timer = 0;

func _ready():
	SomethingH.SomekindNode = get_node(".")
	SomethingH.PlayerHealth = 100;
	bulletRecoilTimer = 0
	self.position = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
	set_process(true)

func _process(delta):
	SomethingH.BulletisShooting = 0
	if Input.is_key_pressed(KEY_W):
		move_and_collide(Vector2(0,(-moveSpeed*delta)))
	if Input.is_key_pressed(KEY_S):
		move_and_collide(Vector2(0,(moveSpeed*delta)))
	if Input.is_key_pressed(KEY_A):
		move_and_collide(Vector2((-moveSpeed*delta),0))
	if Input.is_key_pressed(KEY_D):
		move_and_collide(Vector2((moveSpeed*delta),0))
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if x == 0:
			SomethingH.SomekindNode = get_node(".")
			SomethingH.BulletCheck = 1
			SomethingH.BulletisShooting = 1
			var b = Bullet.instance()
			get_node("../..").add_child(b)
			if int(BulletSpawnSpeedInverse)%1 == 0:
				x = floor(BulletSpawnSpeedInverse)
		x = x - 1
	look_at(get_global_mouse_position())
	if e == 0:
		RNG.randomize()
		var enemy = Enemy.instance()
		get_node("../..").add_child(enemy)
		e = 1000
	e = e - Enemy1SpawnSpeedInverse
	if e2 == 0:
		RNG.randomize()
		var enemy1 = Enemy1.instance()
		get_node("../..").add_child(enemy1)
		e2 = 10000
	e2 = e2 - Enemy1SpawnSpeedInverse
	if SomethingH.PlayerHealth <= 0:
		#get_tree().quit()
		pass
	SomethingH.SomekindNode = get_node(".")
	timer = timer + 1
	if timer%10 == 0 and BulletSpawnSpeedInverse + 0.0078125 != 10:
		BulletSpawnSpeedInverse = BulletSpawnSpeedInverse + 0.0078125
	if bulletRecoilTimer == 1 and SomethingH.BulletisShooting == 1:
		get_node("./Sprite2").position.x = get_node("./Sprite2").position.x - 10
	if bulletRecoilTimer == 0 and SomethingH.BulletisShooting == 1:
		get_node("./Sprite2").position.x = get_node("./Sprite2").position.x + 10
		bulletRecoilTimer = 3
	if SomethingH.BulletisShooting:
		bulletRecoilTimer = bulletRecoilTimer - 1
