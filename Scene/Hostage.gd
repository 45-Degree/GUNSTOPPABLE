extends StaticBody2D
signal hostageDie

func _on_Hurtbox_area_entered(area):
	Singleton.emit_signal("Hostage_Die")
	var Blood_instance = load("res://Scene/Blood.tscn")
	var blood_instace = Blood_instance.instance()
	var world = get_tree().current_scene
	world.add_child(blood_instace)
	blood_instace.global_position = global_position
	queue_free()

