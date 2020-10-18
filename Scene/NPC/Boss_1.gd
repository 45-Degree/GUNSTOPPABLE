extends KinematicBody2D
var state = PHASE_2
var bullet = preload("res://Scene/Boss01_Bulllet.tscn")
onready var bullet_speed = 500
onready var bullet_speed_2 = 500
onready var bulletPoint = $Node2D/Position2D
onready var bulletGenerator = $Bullet_Generator
export var firerate = .5
var Fire = true
var turn_speed = deg2rad(1)
enum{
	PHASE_1,
	PHASE_2
}
func _physics_process(delta):
	match state:
			PHASE_1:
				pass
#				if Fire == true:
#					shoot()
#
			PHASE_2:
				if bulletGenerator.platforms.size() < 10:
					var bullet_instance = bullet.instance()
					bulletGenerator.add_child(bullet_instance)
				if $Bullet_Generator2.platforms.size() < 10:
					var bullet_instance = bullet.instance()
					$Bullet_Generator2.add_child(bullet_instance)
#				if Fire == true:
#					shoot()
#
#func shoot():
#		var bullet_instance = bullet.instance()
#		bullet_instance.position = bulletPoint.get_global_position()
#		bullet_instance.rotation_degrees = rotation_degrees
#		bullet_instance.apply_impulse(Vector2(0,0), Vector2(bullet_speed,0).rotated(rotation))
#		get_tree().get_root().get_node("Boss_1/Node2D").add_child(bullet_instance)
#		Fire = false
#		yield(get_tree().create_timer(firerate), "timeout")
#		Fire = true
##	
