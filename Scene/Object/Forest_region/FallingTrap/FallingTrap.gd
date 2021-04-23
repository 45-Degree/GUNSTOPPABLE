extends StaticBody2D

	
func Trigger():
	$Hurtbox/CollisionShape2D2.set_deferred("disabled" , false)
	
	
