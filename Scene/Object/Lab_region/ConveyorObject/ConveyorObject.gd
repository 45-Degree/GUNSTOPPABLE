extends StaticBody2D

export(String, "MovingUp", "MovingDown","MovingLeft","MovingRight") var Direction
export var speed = 50
var ForceMovement = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#ConveyorObject
func _on_Hurtbox_area_entered(area):
	var object =  area.get_parent()
	if Direction == "MovingUp" :
		object.ForceMovement.append(Vector2(0,-speed))
	if Direction == "MovingDown":
		object.ForceMovement.append(Vector2(0,speed))
	if Direction  == "MovingLeft":
		object.ForceMovement.append(Vector2(-speed,0))
	if Direction == "MovingRight":
		object.ForceMovement.append(Vector2(speed,0))

func _on_Hurtbox_area_exited(area):
	var object =  area.get_parent()
	object.ForceMovement.pop_front()



