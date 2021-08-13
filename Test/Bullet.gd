extends Area2D

var moveSpeed = 1000
var Owner;
var timer = 0;

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * moveSpeed * delta
	if self.position.x <= -500 or self.position.x >= (get_viewport().size.x+500) or self.position.y <= -500 or self.position.y >= (get_viewport().size.y+500):
		queue_free()
	timer = timer + 1;
	
	
func _on_Area2D_tree_entered():
	var temporary
	if SomethingH.BulletCheck == 1:
		Owner = 1
		temporary = SomethingH.SomekindNode
		self.position = temporary.position
		look_at(get_global_mouse_position())
	if SomethingH.BulletCheck == 0:
		Owner = 0
		temporary = SomethingH.EnemyNode
		self.position = temporary.position
		look_at(SomethingH.SomekindNode.position)

func _on_Area2D_area_entered(area):
	if area.name == "Enemy" and Owner == 1:
		area.health = area.health - 10
		queue_free()
	pass



func _on_Bullet_body_entered(body):
	if body.name == "Player" and Owner == 0:
		SomethingH.PlayerHealth = SomethingH.PlayerHealth - 10
		queue_free()
