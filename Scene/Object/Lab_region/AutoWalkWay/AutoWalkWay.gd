extends StaticBody2D

export(String, "MovingUp", "MovingDown","MovingLeft","MovingRight") var Direction
export var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play(str(Direction))
	if Direction == "MovingUp" or "MovingDown":
		$Hurtbox/CollisionShape2D.shape.extents = Vector2(16,26)
		$Hurtbox/CollisionShape2D.position = (Vector2(1,-2.5))
	if Direction  == "MovingLeft" or "MovingRight":
		$Hurtbox/CollisionShape2D.shape.extents = Vector2(18, 21)
		$Hurtbox/CollisionShape2D.position = (Vector2(1,-8))

func _on_Hurtbox_area_entered(area):
	var object =  area.get_parent()
	if Direction == "MovingUp":
		object.ForceMovement.append(Vector2(0,speed))
	if Direction == "MovingDown":
		object.ForceMovement.append(Vector2(0,-speed))
	if Direction  == "MovingLeft":
		object.ForceMovement.append(Vector2(speed,0))
	if Direction == "MovingRight":
		object.ForceMovement.append(Vector2(-speed,0))

func _on_Hurtbox_area_exited(area):
	var object =  area.get_parent()
	object.ForceMovement.pop_front()



