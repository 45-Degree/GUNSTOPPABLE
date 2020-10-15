extends KinematicBody2D
var state = PHASE_1
var bullet = preload("res://Scene/Boss01_Bulllet.tscn")
onready var bullet_speed = 500
onready var bullet_speed_2 = 500
onready var bulletPoint = $Node2D
export var firerate = 0.01
onready var rotate_speed = 1
var Fire = true
var turn_speed = deg2rad(1)
enum{
	PHASE_1,
	PHASE_2
}
func _physics_process(delta):
	if rotation_degrees >= 90:
		rotation -= turn_speed
	elif rotation <= -90:
		rotation_degrees -= turn_speed
#	var min_angle = deg2rad(0.0)
#	var max_angle = deg2rad(90.0)
#	rotation = lerp_angle(min_angle,max_angle, rotate_speed)
#	rotate_speed += delta
	match state:
			PHASE_1:
				pass
#				if Fire == true:
#					shoot()
#
			PHASE_2:
				rotate(0.04)
				if Fire == true:
					shoot()

func shoot():
		var bullet_instance = bullet.instance()
		bullet_instance.position = bulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
		get_tree().get_root().get_node("Boss_1/Node2D").add_child(bullet_instance)
		Fire = false
		yield(get_tree().create_timer(firerate), "timeout")
		Fire = true
#		get_tree().get_root().get_node("World/YSort").add_child(bullet_instance)
#		get_tree().get_root().add_child(bullet_instance)
		
