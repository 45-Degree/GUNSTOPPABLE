extends KinematicBody2D

var ExCe = preload("res://Scene/Effect/Explosion_Celebrate.tscn")

func _on_Hurtbox_area_entered(area):
	Singleton.emit_signal("Terrorist_Die")
	var ExCe_instance = ExCe.instance()
	ExCe_instance.position = get_global_position()
	get_tree().get_root().add_child(ExCe_instance)
	queue_free()
