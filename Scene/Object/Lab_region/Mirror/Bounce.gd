extends KinematicBody2D
onready var state = UNSHOT
onready var ForceMovement = []
var velocity = Vector2.ZERO
enum{
	SHOTTED,
	UNSHOT
}


func _ready():
	$LaserBeam.enabled = true
	
func _physics_process(delta):
	if ForceMovement.size() != 0:
		velocity = velocity.move_toward(ForceMovement[0] ,50* delta)
	elif ForceMovement.size() == 0:
		velocity = Vector2.ZERO
#		velocity.move_toward(Vector2.ZERO, delta)
	match state:
			UNSHOT:
				$LaserBeam.visible = false
				$LaserBeam.cast_to = Vector2(0,0)
				$LaserBeam/Area2D/CollisionShape2D.disabled = true
			SHOTTED:
				$LaserBeam.enabled = true
				$LaserBeam.visible = true
				$LaserBeam.cast_to = Vector2(2000,0)
				$LaserBeam/Area2D/CollisionShape2D.disabled = false
	velocity = move_and_slide(velocity)
	
func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("Laser"):
		state = SHOTTED

func _on_Area2D_area_exited(area):
	if area.get_parent().is_in_group("Laser"):
		state = UNSHOT
