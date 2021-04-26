extends Node2D


var turn_speed = deg2rad(5)
export var firerate = 0.1
var can_fire = true
onready var bulletPoint = $Bulletpoint
export var bullet : PackedScene

func _physics_process(delta):
	var dir = get_angle_to(get_global_mouse_position())
	if abs(dir) < turn_speed:
		rotation += dir
	else:
		if dir>0: rotation += turn_speed 
		if dir<0: rotation -= turn_speed
	
func shoot():
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = self.get_global_position()
		bullet_instance.direction = (bulletPoint.get_global_position() - self.get_global_position()).normalized()
		bullet_instance.rotation = bullet_instance.direction.angle()
		get_tree().current_scene.add_child(bullet_instance)
		SoundManager.play_se("res://Scene/Character/Player/Gun/GunSound/GunsoundNew.wav")
		SoundManager.set_pitch_scale(1,"res://Scene/Character/Player/Gun/GunSound/GunsoundNew.wav")
		can_fire = false
		yield(get_tree().create_timer(firerate), "timeout")
		can_fire = true
