extends StaticBody2D

var Trigger = false

func Trigger():
	$Node2D/AnimatedSprite.play("Falling")
	yield($Node2D/AnimatedSprite,"animation_finished")
	$Hurtbox/CollisionShape2D2.set_deferred("disabled" , false)

func _on_TriggerBox_area_entered(area):
	if Trigger == false:
		Trigger()
		Trigger = true
