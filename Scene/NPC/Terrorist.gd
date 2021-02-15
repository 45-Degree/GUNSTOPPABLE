extends KinematicBody2D

export var moving = false
var ExCe = preload("res://Scene/Effect/Explosion_Celebrate.tscn")

func _physics_process(delta):
	if moving == true:
		$AnimationPlayer.play("Moving")

func _on_Hurtbox_area_entered(area):
	Singleton.emit_signal("Terrorist_Die")
	var ExCe_instance = ExCe.instance()
	ExCe_instance.position = get_global_position()
	get_tree().get_root().add_child(ExCe_instance)
	SoundManager.play_se("res://Sound/SFX/Object/DeadSound.wav")
	queue_free()
