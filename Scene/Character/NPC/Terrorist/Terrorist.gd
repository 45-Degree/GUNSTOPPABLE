extends KinematicBody2D

export var moving = false

func _physics_process(delta):
	$Sprite2.play("Idle")
	if moving == true:
		$AnimationPlayer.play("Moving")

#func _on_Hurtbox_body_entered(body):
#	$Sprite2.play("Die")
#	$CollisionShape2D.disabled = true
#	yield($Sprite2,"animation_finished")
#	Singleton.emit_signal("Terrorist_Die")
#	SoundManager.play_se("res://Sound/SFX/Object/DeadSound.wav")
#	queue_free()


func _on_Hurtbox_area_entered(area):
	$Sprite2.play("Die")
	$CollisionShape2D.disabled = true
	yield($Sprite2,"animation_finished")
	Singleton.emit_signal("Terrorist_Die")
	SoundManager.play_se("res://Sound/SFX/Object/DeadSound.wav")
	queue_free()
