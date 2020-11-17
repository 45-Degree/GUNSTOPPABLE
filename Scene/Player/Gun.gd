extends Node2D


var turn_speed = deg2rad(5)
export var bullet_speed  = 200
export var firerate = 0.1
var can_fire = true
var steering_angle = Vector2.ZERO
onready var bulletPoint = $Bulletpoint
onready var gunSound = $AudioStreamPlayer
var target = Vector2.ZERO
var bullet = preload("res://Scene/Player/Bullet.tscn")

func _physics_process(delta):
	var dir = get_angle_to(get_global_mouse_position())
	if abs(dir) < turn_speed:
		rotation += dir
	else:
		if dir>0: rotation += turn_speed #clockwise
		if dir<0: rotation -= turn_speed
	
	
func shoot():
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = bulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
		get_tree().current_scene.add_child(bullet_instance)
#		get_tree().get_root().get_node("World/YSort").add_child(bullet_instance)
#		get_tree().get_root().add_child(bullet_instance)
		gunSound.play()
		can_fire = false
		yield(get_tree().create_timer(firerate), "timeout")
		can_fire = true
