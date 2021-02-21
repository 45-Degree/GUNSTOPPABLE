extends KinematicBody2D

export var moving = false

func _ready():
	$Sprite2.play("Idle")

func _physics_process(delta):
	if moving == true:
		$AnimationPlayer.play("Moving")
#
func _on_Hurtbox_area_entered(area):
	Singleton.emit_signal("Terrorist_Die")
	$Sprite2.play("Die")
	$CollisionShape2D.set_deferred("disabled", true)
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	SoundManager.play_se("res://Scene/Character/NPC/NPC death.wav")
	yield($Sprite2,"animation_finished")
	queue_free()
