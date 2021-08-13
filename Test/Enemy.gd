extends Area2D

export var health = 100
var damage = 10
var RNG = RandomNumberGenerator.new()
var moveSpeed = 150
var BulletSpawnSpeedInverse = 20
var x = 10
var bulletRecoilTimer
var DiceRoll
export (PackedScene) var Bullet

func _ready():
	RNG.randomize()
	var Randx = RNG.randf_range(-10,(get_viewport().size.x+10))
	RNG.randomize()
	var Randy = RNG.randf_range(-10,(get_viewport().size.y+10))
	RNG.randomize()
	DiceRoll = int(RNG.randf_range(0,9))%2
	if Randx < get_viewport().size.x and Randx > 0 and DiceRoll == 0:
		RNG.randomize()
		if int(RNG.randf_range(0,9))%2 == 0:
			Randx = get_viewport().size.x + 10
		else:
			Randx = -10
	else:
		RNG.randomize()
		if int(RNG.randf_range(0,9))%2 == 0:
			Randy = get_viewport().size.y + 10
		else:
			Randy = -10
	self.position = Vector2(Randx,Randy)
	self.health = 100
	pass 

func _on_Area2D_area_entered(area):
	if area.name == "Bullet" and area.Owner == 1:
		health = health - damage
		if health < 0:
			queue_free()
	
func _process(delta):
	look_at(SomethingH.SomekindNode.position)
	position += Vector2.RIGHT.rotated(rotation) * moveSpeed * delta
	if x == 0:
		SomethingH.EnemyNode = get_node(".")
		SomethingH.BulletCheck = 0
		var b = Bullet.instance()
		get_node("../..").add_child(b)
		x = BulletSpawnSpeedInverse
	x = x - 1

func _on_Enemy_body_entered(body):
	if body.name == "Player":
		SomethingH.PlayerHealth = SomethingH.PlayerHealth - 10
