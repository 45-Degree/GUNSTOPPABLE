extends RayCast2D

const MAX_LENGTH = 2000

onready var beam = $Beam
onready var end = $End
export var is_Player = false
signal send_reflect

func _physics_process(delta):
	if is_Player == true:
		var mouse_position = get_local_mouse_position()
		var max_cast_to = mouse_position.normalized() * MAX_LENGTH
		cast_to = max_cast_to
	else:
		pass
	if is_colliding():
		end.global_position = get_collision_point()
		$Area2D.global_position = get_collision_point()
		var reflect = get_collider()
		if reflect.is_in_group("Bounce"):
			var LaserNormal = get_collision_normal()
			var forward = end.global_position - self.global_position
			var reflection = -forward.reflect(LaserNormal)
			reflect.get_node("LaserBeam").global_rotation = reflection.angle()
			reflect.get_node("LaserBeam").global_position = end.global_position
			reflect.get_node("LaserBeam").visible = true
			reflect.get_node("LaserBeam").cast_to = Vector2(2000,0)
	else:
		end.global_position = cast_to
	beam.rotation = cast_to.angle()
	beam.region_rect.end.x = end.position.length()
