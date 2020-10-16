extends RigidBody2D
var explosion = preload("res://Scene/Effect/Explosion.tscn")

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

