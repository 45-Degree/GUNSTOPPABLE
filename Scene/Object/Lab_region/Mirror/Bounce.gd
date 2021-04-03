extends StaticBody2D
onready var state = UNSHOT

enum{
	SHOTTED,
	UNSHOT
}
	
func _physics_process(delta):
	match state:
			UNSHOT:
				$LaserBeam.enabled = false
				$LaserBeam.visible = false
				$LaserBeam.cast_to = Vector2(0,0)
				$LaserBeam/Area2D/CollisionShape2D.disabled = true
			SHOTTED:
				$LaserBeam.enabled = true
				$LaserBeam.visible = true
				$LaserBeam.cast_to = Vector2(2000,0)
				$LaserBeam/Area2D/CollisionShape2D.disabled = false


func _on_Area2D_area_entered(area):
	state = SHOTTED


func _on_Area2D_area_exited(area):
	state = UNSHOT
