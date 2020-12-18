extends KinematicBody2D

var explosion = preload("res://Scene/Effect/Explosion.tscn")
export var speed = 400
var direction = Vector2.ZERO


func _physics_process(delta):
	var collisionResult = move_and_collide(direction * speed * delta)
	if collisionResult:
		direction = direction.bounce(collisionResult.normal)
		rotation = self.direction.angle()

func _on_Bullet_body_entered(body):
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().current_scene.add_child(explosion_instance)
	#	get_tree().get_root().get_node("World/YSort").add_child(explosion_instance)
		queue_free()

func _on_Hitbox_area_entered(area):
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().current_scene.add_child(explosion_instance)
	#	get_tree().get_root().get_node("World/YSort").add_child(explosion_instance)
		queue_free()


func _on_Timer_timeout():
	queue_free()
