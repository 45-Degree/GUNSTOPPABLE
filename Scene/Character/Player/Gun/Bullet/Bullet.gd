extends KinematicBody2D

var explosion = preload("res://Scene/Character/Player/Gun/ExplosionEffect/Explosion.tscn")
export var speed = 400
var direction = Vector2.ZERO
var flaming = false


func _physics_process(delta):
	var collisionResult = move_and_collide(direction * speed * delta)
	if collisionResult:
		if collisionResult.collider.is_in_group("Bounce"):
			direction = direction.bounce(collisionResult.normal)
			rotation = self.direction.angle()
		if collisionResult.collider.is_in_group("Wall"):
			var explosion_instance = explosion.instance()
			explosion_instance.position = get_global_position()
			get_tree().current_scene.add_child(explosion_instance)
			queue_free()

func _on_Hitbox_area_entered(area):
	if area.get_parent().is_in_group("CampFire"):
		$AnimatedSprite.play("Flame")
		flaming = true
	else:
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().current_scene.add_child(explosion_instance)
		queue_free()

func _on_Timer_timeout():
	queue_free()


